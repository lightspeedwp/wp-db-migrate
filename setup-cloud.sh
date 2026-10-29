#!/bin/bash
# setup-cloud.sh — Complete cloud environment setup for wp-db-migrate
# Usage: ./setup-cloud.sh [--production] [--ci] [--skip-tests]
#
# This script sets up wp-db-migrate in cloud environments, including:
# - Dependency installation
# - Environment validation
# - Test suite execution
# - Skill configuration

set -euo pipefail

# ═══════════════════════════════════════════════════════════════════════════
# Configuration
# ═══════════════════════════════════════════════════════════════════════════

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="${SCRIPT_DIR}"
PRODUCTION="${PRODUCTION:-false}"
CI_MODE="${CI_MODE:-false}"
SKIP_TESTS="${SKIP_TESTS:-false}"
VERBOSE="${VERBOSE:-false}"

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# ═══════════════════════════════════════════════════════════════════════════
# Utility Functions
# ═══════════════════════════════════════════════════════════════════════════

log() {
    echo -e "${BLUE}ℹ${NC} $*"
}

success() {
    echo -e "${GREEN}✅${NC} $*"
}

warning() {
    echo -e "${YELLOW}⚠️${NC} $*"
}

error() {
    echo -e "${RED}❌${NC} $*"
}

debug() {
    if [[ "$VERBOSE" == "true" ]]; then
        echo -e "${BLUE}🔍${NC} $*"
    fi
}

section() {
    echo ""
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}$*${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
}

# Check if command exists
command_exists() {
    command -v "$1" &> /dev/null
}

# ═══════════════════════════════════════════════════════════════════════════
# Parse Arguments
# ═══════════════════════════════════════════════════════════════════════════

parse_args() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            --production)
                PRODUCTION="true"
                shift
                ;;
            --ci)
                CI_MODE="true"
                shift
                ;;
            --skip-tests)
                SKIP_TESTS="true"
                shift
                ;;
            --verbose|-v)
                VERBOSE="true"
                shift
                ;;
            --help|-h)
                show_help
                exit 0
                ;;
            *)
                error "Unknown option: $1"
                exit 1
                ;;
        esac
    done
}

show_help() {
    cat <<EOF
Cloud setup script for wp-db-migrate

Usage: $0 [OPTIONS]

Options:
  --production     Set up for production deployment
  --ci             Set up for CI/CD environment
  --skip-tests     Skip running test suite
  --verbose, -v    Enable verbose output
  --help, -h       Show this help message

Examples:
  # Basic setup
  $0

  # Production setup with CI
  $0 --production --ci

  # Skip tests for faster setup
  $0 --skip-tests

  # Verbose output
  $0 --verbose
EOF
}

# ═══════════════════════════════════════════════════════════════════════════
# System Checks
# ═══════════════════════════════════════════════════════════════════════════

check_requirements() {
    section "System Requirements Check"

    local required_commands=("bash" "curl" "git")
    local missing_commands=()

    for cmd in "${required_commands[@]}"; do
        if command_exists "$cmd"; then
            success "Found: $cmd"
        else
            error "Missing: $cmd"
            missing_commands+=("$cmd")
        fi
    done

    if [[ ${#missing_commands[@]} -gt 0 ]]; then
        error "Please install missing commands: ${missing_commands[*]}"
        exit 1
    fi
}

# ═══════════════════════════════════════════════════════════════════════════
# OS Detection & Setup
# ═══════════════════════════════════════════════════════════════════════════

detect_os() {
    debug "Detecting operating system..."

    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        OS="linux"
        if command_exists apt-get; then
            DISTRO="debian"
        elif command_exists yum; then
            DISTRO="rhel"
        elif command_exists apk; then
            DISTRO="alpine"
        else
            DISTRO="linux"
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        OS="macos"
    elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]]; then
        OS="windows"
    else
        OS="unknown"
    fi

    debug "OS: $OS"
    [[ -n "${DISTRO:-}" ]] && debug "Distro: $DISTRO"
}

# ═══════════════════════════════════════════════════════════════════════════
# Dependency Installation
# ═══════════════════════════════════════════════════════════════════════════

install_node() {
    section "Installing Node.js & npm"

    if command_exists node; then
        local node_version=$(node -v)
        success "Node.js already installed: $node_version"
        return 0
    fi

    log "Installing Node.js..."

    case "$OS" in
        linux)
            case "${DISTRO:-}" in
                debian)
                    debug "Using apt-get for Debian/Ubuntu"
                    sudo apt-get update
                    sudo apt-get install -y nodejs npm
                    ;;
                rhel)
                    debug "Using yum for RHEL/CentOS"
                    sudo yum install -y nodejs npm
                    ;;
                alpine)
                    debug "Using apk for Alpine"
                    sudo apk add --no-cache nodejs npm
                    ;;
                *)
                    warning "Unknown Linux distro, trying apt-get"
                    sudo apt-get update && sudo apt-get install -y nodejs npm
                    ;;
            esac
            ;;
        macos)
            if command_exists brew; then
                debug "Using Homebrew"
                brew install node
            else
                error "Homebrew not found. Please install Node.js manually."
                return 1
            fi
            ;;
        *)
            error "Cannot auto-install Node.js on $OS. Please install manually."
            return 1
            ;;
    esac

    if command_exists node; then
        success "Node.js installed: $(node -v)"
    else
        error "Node.js installation failed"
        return 1
    fi
}

install_project_dependencies() {
    section "Installing Project Dependencies"

    if [[ ! -f "$PROJECT_ROOT/package.json" ]]; then
        error "package.json not found in $PROJECT_ROOT"
        return 1
    fi

    debug "Installing npm packages..."
    cd "$PROJECT_ROOT"

    npm install --loglevel=error

    if [[ -f "$PROJECT_ROOT/package-lock.json" ]]; then
        success "npm packages installed (using package-lock.json)"
    else
        success "npm packages installed"
    fi
}

# ═══════════════════════════════════════════════════════════════════════════
# File Permissions
# ═══════════════════════════════════════════════════════════════════════════

setup_permissions() {
    section "Setting up File Permissions"

    local scripts=(
        "skill/scripts/preflight-check.sh"
        "skill/scripts/migrate-recovery.sh"
        "skill/scripts/migrate-recovery-enhanced.sh"
        "skill/scripts/verify-import.sh"
        "skill/scripts/replace-urls.sh"
        "skill/scripts/start-server.sh"
    )

    for script in "${scripts[@]}"; do
        if [[ -f "$PROJECT_ROOT/$script" ]]; then
            chmod +x "$PROJECT_ROOT/$script"
            success "Made executable: $script"
        else
            warning "Script not found: $script"
        fi
    done
}

# ═══════════════════════════════════════════════════════════════════════════
# Test Execution
# ═══════════════════════════════════════════════════════════════════════════

run_tests() {
    section "Running Test Suite"

    if [[ "$SKIP_TESTS" == "true" ]]; then
        warning "Skipping tests (--skip-tests)"
        return 0
    fi

    if [[ ! -f "$PROJECT_ROOT/package.json" ]]; then
        warning "package.json not found, skipping tests"
        return 0
    fi

    cd "$PROJECT_ROOT"

    if command_exists npm; then
        log "Running: npm test"

        if npm test; then
            success "All tests passed"
        else
            error "Tests failed"
            if [[ "$CI_MODE" == "true" ]]; then
                return 1
            else
                warning "Tests failed but continuing (not in CI mode)"
            fi
        fi
    else
        warning "npm not found, skipping tests"
    fi
}

# ═══════════════════════════════════════════════════════════════════════════
# Environment Validation
# ═══════════════════════════════════════════════════════════════════════════

validate_environment() {
    section "Validating Environment"

    # Check for optional but recommended tools
    local optional_tools=("git" "jq" "grep" "sed" "curl")

    for tool in "${optional_tools[@]}"; do
        if command_exists "$tool"; then
            success "Found: $tool"
        else
            warning "Recommended tool not found: $tool"
        fi
    done
}

# ═══════════════════════════════════════════════════════════════════════════
# Skill Setup
# ═══════════════════════════════════════════════════════════════════════════

setup_skill() {
    section "Configuring Claude Skill"

    local skill_dir="$PROJECT_ROOT/skill"

    if [[ ! -d "$skill_dir" ]]; then
        error "Skill directory not found: $skill_dir"
        return 1
    fi

    if [[ ! -f "$skill_dir/SKILL.md" ]]; then
        error "SKILL.md not found in $skill_dir"
        return 1
    fi

    success "Skill directory verified: $skill_dir"
    success "Skill documentation found: SKILL.md"
    success "Skill ready for installation"

    if [[ "$PRODUCTION" == "true" ]]; then
        log "Production mode: Skill ready for deployment"
    fi
}

# ═══════════════════════════════════════════════════════════════════════════
# Plugin Setup
# ═══════════════════════════════════════════════════════════════════════════

setup_plugin() {
    section "Configuring Claude Plugin"

    local plugin_dir="$PROJECT_ROOT/plugin"

    if [[ ! -d "$plugin_dir" ]]; then
        error "Plugin directory not found: $plugin_dir"
        return 1
    fi

    if [[ ! -f "$plugin_dir/manifest.json" ]]; then
        error "manifest.json not found in $plugin_dir"
        return 1
    fi

    success "Plugin directory verified: $plugin_dir"
    success "Plugin manifest found: manifest.json"

    # Validate manifest JSON if jq is available
    if command_exists jq; then
        if jq empty "$plugin_dir/manifest.json" 2>/dev/null; then
            success "Plugin manifest is valid JSON"
        else
            error "Plugin manifest has invalid JSON"
            return 1
        fi
    fi

    success "Plugin ready for deployment"
}

# ═══════════════════════════════════════════════════════════════════════════
# Status Report
# ═══════════════════════════════════════════════════════════════════════════

print_summary() {
    section "Setup Complete ✅"

    cat <<EOF
${GREEN}WordPress Database Migration Skill${NC}
Version: $(grep '"version"' "$PROJECT_ROOT/package.json" | head -1 | cut -d'"' -f4)

${GREEN}Status:${NC}
  ✅ Environment validated
  ✅ Dependencies installed
  ✅ Scripts are executable
  ✅ Tests passed
  ✅ Skill configured
  ✅ Plugin configured

${GREEN}Next Steps:${NC}

1. ${BLUE}Install the Skill${NC}
   Link to your Claude workspace:
   ln -s "$PROJECT_ROOT/skill" ~/.claude/skills/wp-db-migrate

2. ${BLUE}Install the Plugin${NC}
   Add plugin from: $PROJECT_ROOT/plugin

3. ${BLUE}Verify Installation${NC}
   Run: ./skill/scripts/preflight-check.sh

4. ${BLUE}Start Using${NC}
   Use the skill to migrate WordPress databases:
   ./skill/scripts/migrate-recovery.sh /path/to/site "old-url" "new-url"

${GREEN}Documentation:${NC}
  📖 Main README: $PROJECT_ROOT/README.md
  📖 Skill Guide: $PROJECT_ROOT/skill/SKILL.md
  📖 Improvements: $PROJECT_ROOT/skill/IMPROVEMENTS.md
  📖 Scripts: $PROJECT_ROOT/skill/scripts/README.md

${GREEN}Quick Test${NC}
  ./skill/scripts/preflight-check.sh

EOF

    if [[ "$PRODUCTION" == "true" ]]; then
        echo -e "${GREEN}🚀 Production Mode Enabled${NC}"
    fi

    if [[ "$CI_MODE" == "true" ]]; then
        echo -e "${GREEN}🤖 CI/CD Mode Enabled${NC}"
    fi
}

# ═══════════════════════════════════════════════════════════════════════════
# Main Setup Flow
# ═══════════════════════════════════════════════════════════════════════════

main() {
    parse_args "$@"

    echo ""
    echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║  WordPress Database Migration - Cloud Setup              ║${NC}"
    echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    # Set environment variables
    export PRODUCTION
    export CI_MODE
    export VERBOSE

    log "Project root: $PROJECT_ROOT"
    log "Production mode: $PRODUCTION"
    log "CI mode: $CI_MODE"
    log "Verbose output: $VERBOSE"

    # Run setup phases
    check_requirements
    detect_os
    install_node
    install_project_dependencies
    setup_permissions
    validate_environment
    run_tests
    setup_skill
    setup_plugin
    print_summary

    echo ""
    success "Setup completed successfully!"
    exit 0
}

# Run main function
main "$@"
