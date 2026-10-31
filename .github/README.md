# GitHub Configuration

Configuration and workflows for GitHub-specific features.

## Structure

```
.github/
├── README.md                     # This file
├── labeler.yml                  # Auto-labeling configuration
├── ISSUE_TEMPLATE/              # Issue templates
│   ├── bug.md                   # Bug report template
│   ├── feature.md               # Feature request template
│   └── question.md              # Question template
├── PULL_REQUEST_TEMPLATE/       # PR templates
│   └── default.md               # Standard PR template
└── workflows/                   # GitHub Actions
    ├── test.yml                 # Test on push/PR
    └── lint.yml                 # Lint and format check
```

## Files

### labeler.yml
Automatically applies labels to PRs based on changed files.

**How it works:**
- When a PR is opened or updated, GitHub Actions reads this file
- Labels are applied automatically based on which files changed
- Example: `"tests"` label applied when `__tests__/**` files change

**Customizing labels:**
Edit the file to add new label patterns. Use glob patterns to match files.

### Issue Templates
Help contributors report bugs and request features consistently.

**Templates:**
- `bug.md` — Report bugs with reproduction steps
- `feature.md` — Request new features with use cases
- `question.md` — Ask questions with context

### Pull Request Template
Standardizes PR descriptions and ensures quality checks.

**Template Location:** `PULL_REQUEST_TEMPLATE/default.md`

**Checklist includes:**
- Type of change
- Testing verification
- Documentation updates
- Bash compatibility check

### Workflows

#### test.yml
Runs Jest and BATS tests on multiple Node versions and operating systems.

**Triggers:** Push to main/develop, PRs to main/develop

**What it does:**
1. Installs Node.js (18.x, 20.x)
2. Runs Jest tests with coverage
3. Uploads coverage to Codecov
4. Runs BATS integration tests
5. Checks Bash version

**Customizing:**
- Change Node versions in `strategy.matrix.node-version`
- Modify test commands if npm scripts change
- Add more os options to `strategy.matrix.os`

#### lint.yml
Checks code quality and formatting.

**Triggers:** Push to main/develop, PRs to main/develop

**What it does:**
1. Runs ESLint (if configured)
2. Checks shell scripts with ShellCheck
3. Validates JSON files
4. Checks YAML formatting

## Adding New Workflows

To create a new workflow:

1. Create a file in `.github/workflows/` (e.g., `my-workflow.yml`)
2. Define triggers (`on:`)
3. Define jobs and steps
4. Test locally with `act` (see https://github.com/nektos/act)

**Template:**
```yaml
name: My Workflow

on:
  push:
    branches: [main, develop]

jobs:
  my-job:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: echo "Hello, World!"
```

## Linking Templates

These templates are automatically offered when:
- Creating a new issue → Choose from issue templates
- Creating a new PR → Shown the PR template

## Organization Integration

LightSpeed WP has organization-wide defaults in [lightspeedwp/.github](https://github.com/lightspeedwp/.github):
- `branch-labels.yml` — Label types
- `branch-types.yml` — Branch naming conventions
- `issue-types.yml` — Issue categories
- `labels.yml` — Label definitions

This repo's `.github/labeler.yml` adds project-specific auto-labeling on top of org-wide labels.

## Troubleshooting

**Labels not applying:**
- Check that files changed match glob patterns in `labeler.yml`
- Labels are applied to PRs, not commits
- GitHub Actions must be enabled in repo settings

**Workflows not running:**
- Check branch protection rules don't require approval
- Verify workflows are not marked as disabled
- Check GitHub Actions quota hasn't been exceeded

**Templates not appearing:**
- Ensure filenames match exactly (case-sensitive on Linux)
- Template must have YAML frontmatter (`---`)
- Clear browser cache if recently changed

## Testing Locally

Test workflows locally with `act`:

```bash
# Install act
brew install act

# Run all workflows
act

# Run specific workflow
act -j test

# Dry run (don't actually run)
act -n
```

See [nektos/act](https://github.com/nektos/act) for full documentation.
