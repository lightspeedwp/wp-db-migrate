#!/bin/bash
# Progress bar library for wp-db-migrate scripts
# Provides reusable progress tracking functions

# Initialize progress state
PROGRESS_CURRENT=0
PROGRESS_TOTAL=0
PROGRESS_LABEL=""

# Start a progress bar
# Usage: progress_start <total> [label]
progress_start() {
  local total=$1
  local label="${2:-Processing}"

  PROGRESS_TOTAL=$total
  PROGRESS_CURRENT=0
  PROGRESS_LABEL="$label"

  printf "📊 %s: [" "$PROGRESS_LABEL"
}

# Update progress
# Usage: progress_update <current> [message]
progress_update() {
  local current=$1
  local message="${2:-}"

  PROGRESS_CURRENT=$current

  if [ "$PROGRESS_TOTAL" -eq 0 ]; then
    return
  fi

  # Calculate percentage
  local percent=$((current * 100 / PROGRESS_TOTAL))
  local bar_width=30
  local filled=$((percent * bar_width / 100))

  # Build progress bar
  local bar=""
  for ((i=0; i<filled; i++)); do
    bar="${bar}▓"
  done
  for ((i=filled; i<bar_width; i++)); do
    bar="${bar}░"
  done

  # Print progress line (carriage return to overwrite)
  printf "\r📊 %s: [%s] %3d%%" "$PROGRESS_LABEL" "$bar" "$percent"

  if [ -n "$message" ]; then
    printf " • %s" "$message"
  fi
}

# Complete progress bar
# Usage: progress_complete [message]
progress_complete() {
  local message="${1:-Done}"

  if [ "$PROGRESS_TOTAL" -eq 0 ]; then
    return
  fi

  # Fill to 100%
  local bar_width=30
  local bar=""
  for ((i=0; i<bar_width; i++)); do
    bar="${bar}▓"
  done

  printf "\r📊 %s: [%s] 100%% • %s\n" "$PROGRESS_LABEL" "$bar" "$message"

  # Reset state
  PROGRESS_CURRENT=0
  PROGRESS_TOTAL=0
  PROGRESS_LABEL=""
}

# Fail progress bar
# Usage: progress_fail [message]
progress_fail() {
  local message="${1:-Failed}"

  if [ "$PROGRESS_TOTAL" -eq 0 ]; then
    return
  fi

  printf "\r❌ %s: Failed • %s\n" "$PROGRESS_LABEL" "$message"

  # Reset state
  PROGRESS_CURRENT=0
  PROGRESS_TOTAL=0
  PROGRESS_LABEL=""
}

# Spinner for indeterminate progress
# Usage: spinner_start [label]
spinner_start() {
  local label="${1:-Processing}"
  SPINNER_LABEL="$label"
  SPINNER_PID=""

  {
    local spinner=( '⠋' '⠙' '⠹' '⠸' '⠼' '⠴' '⠦' '⠧' '⠇' '⠏' )
    local i=0
    while true; do
      printf "\r⏳ %s %s" "$SPINNER_LABEL" "${spinner[$((i % 10))]}"
      sleep 0.1
      ((i++))
    done
  } &
  SPINNER_PID=$!
}

# Stop spinner
# Usage: spinner_complete [message]
spinner_complete() {
  local message="${1:-Done}"

  if [ -z "$SPINNER_PID" ]; then
    return
  fi

  kill $SPINNER_PID 2>/dev/null
  wait $SPINNER_PID 2>/dev/null

  printf "\r✅ %s • %s\n" "$SPINNER_LABEL" "$message"
  SPINNER_PID=""
}

# Stop spinner with failure
# Usage: spinner_fail [message]
spinner_fail() {
  local message="${1:-Failed}"

  if [ -z "$SPINNER_PID" ]; then
    return
  fi

  kill $SPINNER_PID 2>/dev/null
  wait $SPINNER_PID 2>/dev/null

  printf "\r❌ %s • %s\n" "$SPINNER_LABEL" "$message"
  SPINNER_PID=""
}

# Multi-stage progress tracker
# Usage: stage_start <stage_num> <stage_name> <total_stages>
stage_start() {
  local current=$1
  local name=$2
  local total=$3

  printf "📍 Stage %d/%d: %s\n" "$current" "$total" "$name"
}

# Stage complete
# Usage: stage_complete
stage_complete() {
  printf "✅ Stage complete\n"
}

export -f progress_start progress_update progress_complete progress_fail
export -f spinner_start spinner_complete spinner_fail
export -f stage_start stage_complete
