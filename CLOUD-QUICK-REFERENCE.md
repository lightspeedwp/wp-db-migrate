# Cloud Setup Quick Reference Card

Fast lookup for common cloud setup tasks.

## 🚀 One-Liners

```bash
# Basic setup
./setup-cloud.sh

# Production deployment
./setup-cloud.sh --production --ci

# Skip tests (fast)
./setup-cloud.sh --skip-tests

# Verbose debugging
./setup-cloud.sh --verbose

# Docker development
docker-compose up dev

# Run tests in Docker
docker-compose up test

# Build production Docker image
docker build -t wp-db-migrate:latest .

# Docker Compose all services
docker-compose up

# Stop Docker services
docker-compose down

# Verify environment
./skill/scripts/preflight-check.sh

# Run migration (after setup)
./skill/scripts/migrate-recovery.sh /path/to/site "old-url" "new-url"
```

---

## 📁 Key Files & Locations

| File | Purpose | Edit? |
|------|---------|-------|
| `setup-cloud.sh` | Main setup script | No* |
| `.env.example` | Configuration template | Copy to `.env` |
| `.github/workflows/setup-cloud.yml` | GitHub Actions CI/CD | Only if customizing |
| `Dockerfile` | Production image | Rarely |
| `Dockerfile.dev` | Development image | Rarely |
| `docker-compose.yml` | Compose config | As needed |
| `CLOUD-SETUP.md` | Full documentation | Reference only |

*Leave setup-cloud.sh unchanged unless fixing bugs

---

## 🔧 Common Tasks

### Setup Fresh Environment
```bash
./setup-cloud.sh
```

### Test Before Deployment
```bash
npm test
npm test -- --coverage
```

### Deploy to Production
```bash
./setup-cloud.sh --production --ci
# Check GitHub Actions logs
# Download artifacts
```

### Use Docker
```bash
docker-compose up dev        # Start dev container
docker-compose exec dev bash # Enter container
./setup-cloud.sh --verbose   # Run setup inside
exit                         # Leave container
docker-compose down          # Stop services
```

### Verify Setup
```bash
./skill/scripts/preflight-check.sh
npm test
npm run lint  # If available
```

### Deploy to AWS
```bash
# EC2
ssh -i key.pem user@host
./setup-cloud.sh --production

# Lambda: use GitHub Actions artifacts
```

### Deploy to GCP
```bash
# Cloud Run: auto-deploy from GitHub
# (GitHub Actions creates artifact)

# Compute Engine
gcloud compute ssh instance-name
./setup-cloud.sh --production
```

### Configure Environment
```bash
cp .env.example .env
nano .env              # Edit with your values
./setup-cloud.sh       # Uses .env automatically
```

---

## 📊 Setup Time Estimates

| Method | Time | Best For |
|--------|------|----------|
| `./setup-cloud.sh` | 3-5 min | Local dev |
| `./setup-cloud.sh --skip-tests` | 2-3 min | Quick setup |
| `./setup-cloud.sh --production` | 5-10 min | Production |
| `docker build .` | 5-10 min | Container deploy |
| `docker-compose up` | 10-15 min | Full local stack |
| GitHub Actions | 5-15 min | CI/CD (auto) |

---

## 🐛 Quick Debugging

### Setup failing?
```bash
# Enable verbose output
./setup-cloud.sh --verbose

# Check each step manually
node -v                              # Node.js installed?
npm -v                               # npm installed?
./skill/scripts/preflight-check.sh   # All deps?
npm test                             # Tests pass?
```

### Docker not working?
```bash
docker ps                    # Docker running?
docker ps -a                 # Check all containers
docker logs container-name   # View errors
docker-compose ps           # Check compose services
docker system prune -a       # Free up space
```

### GitHub Actions failing?
1. Go to: github.com/owner/repo/actions
2. Click failed workflow
3. Expand failed job
4. Check step logs
5. Common fixes:
   - Check Node version matches
   - Ensure package-lock.json committed
   - Verify secrets configured

### Environment variables not working?
```bash
# Check .env file exists
ls -la .env

# Check values are set
grep -E "^[A-Z_]+=" .env

# Verify path is correct
cd /to/project
echo $NODE_ENV  # Should print if exported
```

---

## ✅ Pre-Deployment Checklist

```
□ Cloned repo successfully
□ Ran ./setup-cloud.sh
□ All tests pass
□ .env configured
□ Network connectivity works
□ Disk space available (>5GB)
□ No lingering containers
□ GitHub Actions triggered (if using)
□ Cloud credentials configured
□ Monitoring/logging setup
```

---

## 🔑 Important Files to Never Edit

- `setup-cloud.sh` — Master script
- `Dockerfile` — Base image config
- `Dockerfile.dev` — Dev image config
- `.github/workflows/setup-cloud.yml` — CI/CD definition

**Note**: Only edit these to *add* features, not replace core logic.

---

## 🌐 Cloud Platform Quick Links

| Platform | Console | Docs |
|----------|---------|------|
| AWS | console.aws.amazon.com | aws.amazon.com/docs |
| GCP | console.cloud.google.com | cloud.google.com/docs |
| Azure | portal.azure.com | learn.microsoft.com/azure |
| DigitalOcean | cloud.digitalocean.com | docs.digitalocean.com |
| GitHub | github.com | docs.github.com |

---

## 💡 Pro Tips

1. **Use `--verbose` for debugging**
   ```bash
   ./setup-cloud.sh --verbose > setup.log
   ```

2. **Save setup logs**
   ```bash
   ./setup-cloud.sh 2>&1 | tee setup-$(date +%Y%m%d).log
   ```

3. **Run tests before committing**
   ```bash
   npm test && git push
   ```

4. **Use Docker for consistency**
   ```bash
   docker-compose up dev  # Same as production
   ```

5. **Automate with GitHub Actions**
   ```bash
   git push  # Automatically runs workflow
   ```

6. **Cache npm packages**
   ```bash
   docker-compose build --no-cache dev  # Skip cache
   ```

7. **Monitor background jobs**
   ```bash
   docker-compose logs -f dev  # Watch logs
   ```

---

## 🆘 Emergency Commands

```bash
# Reset everything (dangerous!)
docker-compose down -v
rm -rf node_modules package-lock.json
npm install
./setup-cloud.sh

# Kill stuck process
docker-compose kill dev
docker ps | grep wp-db-migrate | awk '{print $1}' | xargs docker kill

# Free disk space
docker system prune -a
npm cache clean --force

# Check what's consuming space
docker system df
du -sh ./* | sort -h
```

---

## 📞 Getting Help

**Quick Help**:
```bash
./setup-cloud.sh --help
docker-compose --help
./skill/scripts/preflight-check.sh
```

**Full Documentation**:
- CLOUD-SETUP.md — Complete guide
- README.md — Overview
- skill/SKILL.md — Detailed skill guide

**Debugging**:
```bash
./setup-cloud.sh --verbose 2>&1 | tee debug.log
```

---

## ⏱️ Setup Time by Method

```
Fastest → Slowest

1. ./setup-cloud.sh --skip-tests      (2 min)
2. ./setup-cloud.sh                   (5 min)
3. docker build -t image .            (10 min)
4. docker-compose up                  (15 min)
5. GitHub Actions (full)              (15 min)
```

---

## 🎯 Next Command to Run

```bash
cd /Users/ash/.claude/plugins/marketplaces/lightspeedwp/wp-db-migrate
./setup-cloud.sh --help
```

---

**Version**: 1.1.0  
**Updated**: 2026-10-29
