# Documentation Guide

Welcome to the wp-db-migrate documentation. This guide helps you find what you need quickly.

## 🚀 Getting Started (First Time?)

**Start here if you're new:**

1. **[Setup Requirements](./SETUP-REQUIREMENTS.md)** — Verify your machine is ready (2 min)
2. **[Team Installation Guide](./TEAM-INSTALLATION.md)** — Install in Claude for your team (5 min)
3. **[Getting Started](./GETTING-STARTED.md)** — Your first migration in 5 minutes
4. **[Quick FAQ](./FAQ.md)** — Answers to 30+ common questions

## 📖 Documentation Hub

### By What You're Trying to Do

#### I want to install the tool

→ **[Team Installation Guide](./TEAM-INSTALLATION.md)**

- Three installation methods (Skill, Plugin, CLI)
- Step-by-step setup for each
- Dependency checks
- Troubleshooting installation

#### I want to run my first migration

→ **[Getting Started](./GETTING-STARTED.md)**

- 5-minute quick start
- Understanding the 5-stage workflow
- Basic usage examples
- Common issues & quick fixes

#### I want to configure it for my team

→ **[Configuration & Profiles](./CONFIGURATION.md)**

- Config file reference
- Environment-specific setup
- Reusable profiles
- Team workflows

#### I want to optimize performance

→ **[Advanced Usage](./ADVANCED.md)**

- SSH export for remote servers
- Parallel processing (multi-job)
- Compression tuning
- Dry-run mode
- Progress tracking
- Custom table exclusions

#### I want it to be reliable

→ **[Reliability & Error Recovery](./RELIABILITY.md)**

- Automatic error detection
- Recovery checkpoints
- Failure type reference (6 types)
- Remediation step-by-step
- Backup & rollback
- Best practices

#### I want to track performance

→ **[Analytics & Reporting](./ANALYTICS.md)**

- Three report formats
- Understanding metrics
- Compression analysis
- Import throughput optimization
- CI/CD integration
- Team reporting templates

#### I want to follow best practices

→ **[Best Practices](./BEST-PRACTICES.md)**

- Safe migration strategies
- Backup procedures
- Performance optimization
- Table exclusion guide
- URL replacement safety
- Post-import validation

#### Something went wrong

→ **[Troubleshooting](./TROUBLESHOOTING.md)**

- Common error messages
- Performance issues
- SSH problems
- Import failures
- Validation errors
- Recovery procedures

#### I have a question

→ **[FAQ](./FAQ.md)**

- 30+ common questions answered
- Reliability questions
- Analytics questions
- Configuration help

---

## 📚 Documentation Structure

```
docs/
├── README-GUIDE.md (← you are here)
│   └── Navigation & overview
│
├── SETUP-REQUIREMENTS.md ⭐ START HERE
│   └── Verify dependencies & team setup
│
├── TEAM-INSTALLATION.md
│   └── How to install for your team
│
├── GETTING-STARTED.md
│   └── 5-minute quick start
│
├── CONFIGURATION.md
│   └── Config files & profiles
│
├── BEST-PRACTICES.md
│   └── Safe & efficient migrations
│
├── ADVANCED.md
│   └── Power features & optimization
│
├── RELIABILITY.md
│   └── Error recovery & resilience
│
├── ANALYTICS.md
│   └── Reports & performance metrics
│
├── FAQ.md
│   └── 30+ common questions
│
└── TROUBLESHOOTING.md
    └── Diagnose & fix issues
```

---

## 🎯 Quick Decision Tree

**Are you...**

```
├─ New to this tool?
│  └─ Read: Setup Requirements → TEAM-INSTALLATION.md → Getting Started
│
├─ Just got a new Mac?
│  └─ Read: Setup Requirements (verify dependencies)
│
├─ Installing for your team?
│  └─ Read: Setup Requirements → TEAM-INSTALLATION.md
│
├─ Running your first migration?
│  └─ Read: Getting Started → Best Practices
│
├─ Setting up team workflows?
│  └─ Read: Configuration → Best Practices
│
├─ Want to optimize performance?
│  └─ Read: Advanced Usage → Analytics
│
├─ Want better error handling?
│  └─ Read: Reliability Guide → Best Practices
│
├─ Something broke?
│  └─ Read: Troubleshooting → Reliability
│
└─ Have a question?
   └─ Read: FAQ (covers most questions)
```

---

## 🔍 Search by Topic

### Installation & Setup

- **Check dependencies?** → [Setup Requirements](./SETUP-REQUIREMENTS.md)
- **Verify all tools installed?** → Run: `./skill/scripts/setup-dependencies.sh`
- **First time?** → [Team Installation Guide](./TEAM-INSTALLATION.md)
- **Dependencies?** → [Setup Requirements](./SETUP-REQUIREMENTS.md#required-dependencies)
- **Troubleshooting install?** → [Setup Requirements](./SETUP-REQUIREMENTS.md#troubleshooting)

### Basic Usage

- **Quick start (5 min)?** → [Getting Started](./GETTING-STARTED.md)
- **5-stage workflow?** → [Getting Started](./GETTING-STARTED.md#understanding-the-5-stage-workflow)
- **Command-line options?** → Run `./wp-migrate-clone-to-studio.sh --help`

### Configuration

- **Config files?** → [Configuration](./CONFIGURATION.md)
- **Reusing settings?** → [Configuration](./CONFIGURATION.md#configuration-profiles)
- **Environment variables?** → [Configuration](./CONFIGURATION.md)

### Performance

- **Slow migrations?** → [Advanced Usage](./ADVANCED.md) → [Analytics](./ANALYTICS.md)
- **Compression?** → [Advanced Usage](./ADVANCED.md#compression)
- **Parallel processing?** → [Advanced Usage](./ADVANCED.md#parallel-processing)

### Reliability

- **Migration failed?** → [Reliability](./RELIABILITY.md)
- **Error recovery?** → [Reliability](./RELIABILITY.md#error-recovery)
- **Checkpoint recovery?** → [Reliability](./RELIABILITY.md#recovery-checkpoints)

### Analytics

- **Where are reports?** → [Analytics](./ANALYTICS.md#accessing-reports)
- **Understanding metrics?** → [Analytics](./ANALYTICS.md#understanding-key-metrics)
- **CI/CD integration?** → [Analytics](./ANALYTICS.md#cicd-integration)

### Troubleshooting

- **Common errors?** → [Troubleshooting](./TROUBLESHOOTING.md#error-messages)
- **Performance issues?** → [Troubleshooting](./TROUBLESHOOTING.md#performance-issues)
- **SSH problems?** → [Troubleshooting](./TROUBLESHOOTING.md#ssh-connection-problems)

### Questions

- **General Q&A?** → [FAQ](./FAQ.md#general-questions)
- **Configuration Q&A?** → [FAQ](./FAQ.md#configuration-questions)
- **Reliability Q&A?** → [FAQ](./FAQ.md#reliability--error-recovery)
- **Analytics Q&A?** → [FAQ](./FAQ.md#analytics--reporting)

---

## 📋 Learning Paths

### Path 1: Getting Started (35 minutes)

1. [Setup Requirements](./SETUP-REQUIREMENTS.md) — 5 min (verify dependencies)
2. [Team Installation](./TEAM-INSTALLATION.md) — 10 min
3. [Getting Started](./GETTING-STARTED.md) — 10 min
4. [FAQ](./FAQ.md) — 10 min
   **Result:** Ready for first migration

### Path 2: Deep Dive (2 hours)

1. [Team Installation](./TEAM-INSTALLATION.md) — 15 min
2. [Getting Started](./GETTING-STARTED.md) — 15 min
3. [Best Practices](./BEST-PRACTICES.md) — 20 min
4. [Configuration](./CONFIGURATION.md) — 15 min
5. [Advanced Usage](./ADVANCED.md) — 20 min
6. [Reliability](./RELIABILITY.md) — 20 min
7. [Analytics](./ANALYTICS.md) — 15 min
   **Result:** Expert user

### Path 3: Troubleshooting (15 minutes)

1. [Troubleshooting](./TROUBLESHOOTING.md) — Find your error
2. [Reliability](./RELIABILITY.md) — Get recovery steps
3. [FAQ](./FAQ.md) — Check Q&A
   **Result:** Issue resolved

### Path 4: Team Rollout (1 hour)

1. [Team Installation](./TEAM-INSTALLATION.md) — 20 min (read & prepare)
2. [Getting Started](./GETTING-STARTED.md) — 10 min (walk through with team)
3. [Best Practices](./BEST-PRACTICES.md) — 15 min (set team standards)
4. [FAQ](./FAQ.md) — 15 min (prep for questions)
   **Result:** Team ready to use

---

## 🎓 By Experience Level

### Beginner (New to migrations)

1. Start with [Getting Started](./GETTING-STARTED.md)
2. Then [Best Practices](./BEST-PRACTICES.md)
3. Check [FAQ](./FAQ.md) for common questions
4. Refer to [Troubleshooting](./TROUBLESHOOTING.md) if issues arise

### Intermediate (A few migrations under belt)

1. Review [Configuration](./CONFIGURATION.md) for team setup
2. Explore [Advanced Usage](./ADVANCED.md) for optimization
3. Read [Reliability](./RELIABILITY.md) for error handling
4. Study [Analytics](./ANALYTICS.md) for performance tracking

### Advanced (Building team workflows)

1. Master [Team Installation](./TEAM-INSTALLATION.md) workflows
2. Deep dive into [Advanced Usage](./ADVANCED.md)
3. Design [Configuration](./CONFIGURATION.md) profiles
4. Set up [Analytics](./ANALYTICS.md) CI/CD integration
5. Create recovery procedures with [Reliability](./RELIABILITY.md)

---

## 🤝 For Teams

### Team Lead Checklist

- [ ] Verify your own [Setup Requirements](./SETUP-REQUIREMENTS.md)
- [ ] Review team's dependency needs (run `./skill/scripts/setup-dependencies.sh`)
- [ ] Read [Team Installation](./TEAM-INSTALLATION.md)
- [ ] Review [Best Practices](./BEST-PRACTICES.md)
- [ ] Create team `.wp-db-migrate.conf` file
- [ ] Set up [Analytics](./ANALYTICS.md) reporting
- [ ] Document your team's [Configuration](./CONFIGURATION.md) profiles
- [ ] Create recovery runbook from [Reliability](./RELIABILITY.md)

### Team Member Setup

- [ ] Run [Setup Requirements](./SETUP-REQUIREMENTS.md) verification
- [ ] Install missing dependencies if needed
- [ ] Follow [Team Installation](./TEAM-INSTALLATION.md)
- [ ] Read [Getting Started](./GETTING-STARTED.md)
- [ ] Study [Best Practices](./BEST-PRACTICES.md)
- [ ] Bookmark [Troubleshooting](./TROUBLESHOOTING.md)
- [ ] Check [FAQ](./FAQ.md) for common questions

---

## 💡 Pro Tips

- **Bookmark this page** — It's your documentation hub
- **Use Ctrl+F** to search within any document
- **Check the FAQ first** — It answers 30+ common questions
- **Read Reliability** — Prevents most issues
- **Use dry-run mode** — Always test before committing

---

## 📊 Documentation Overview

| Guide                                         | Focus           | Read Time | Best For             |
| --------------------------------------------- | --------------- | --------- | -------------------- |
| [Setup Requirements](./SETUP-REQUIREMENTS.md) | Dependencies    | 10 min    | Verify machine setup |
| [Team Installation](./TEAM-INSTALLATION.md)   | Installation    | 20 min    | Teams & CI/CD        |
| [Getting Started](./GETTING-STARTED.md)       | Basics          | 5 min     | First migration      |
| [Configuration](./CONFIGURATION.md)           | Setup           | 15 min    | Team profiles        |
| [Best Practices](./BEST-PRACTICES.md)         | Strategy        | 15 min    | Safe migrations      |
| [Advanced](./ADVANCED.md)                     | Power features  | 25 min    | Optimization         |
| [Reliability](./RELIABILITY.md)               | Error handling  | 20 min    | Resilience           |
| [Analytics](./ANALYTICS.md)                   | Metrics         | 20 min    | Performance          |
| [FAQ](./FAQ.md)                               | Q&A             | 10 min    | Quick answers        |
| [Troubleshooting](./TROUBLESHOOTING.md)       | Problem-solving | 15 min    | Fixing issues        |

---

## 🚀 Ready to Start?

**First time?**

1. Go to [Team Installation](./TEAM-INSTALLATION.md)
2. Install in Claude
3. Read [Getting Started](./GETTING-STARTED.md)
4. Run your first migration

**Have a question?**
→ Check [FAQ](./FAQ.md) first (covers most questions)

**Something broken?**
→ Go to [Troubleshooting](./TROUBLESHOOTING.md)

**Want to optimize?**
→ Read [Advanced Usage](./ADVANCED.md) then [Analytics](./ANALYTICS.md)

---

**Last Updated:** October 2026  
**Version:** 1.1.0  
**Status:** Complete documentation suite with team onboarding guides
