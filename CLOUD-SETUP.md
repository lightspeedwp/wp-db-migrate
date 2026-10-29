# Cloud Setup Guide for wp-db-migrate

Complete guide for deploying the WordPress database migration skill to cloud environments, including Claude Cloud, GitHub Actions, Docker, and other cloud platforms.

## 📋 Table of Contents

- [Quick Start](#quick-start)
- [Claude Cloud Setup](#claude-cloud-setup)
- [GitHub Actions CI/CD](#github-actions-cicd)
- [Docker Deployment](#docker-deployment)
- [Cloud Providers](#cloud-providers)
- [Environment Configuration](#environment-configuration)
- [Troubleshooting](#troubleshooting)

---

## 🚀 Quick Start

### Basic Cloud Setup (One Command)

```bash
# Make the setup script executable
chmod +x setup-cloud.sh

# Run basic setup
./setup-cloud.sh

# For production with CI/CD
./setup-cloud.sh --production --ci

# With verbose output
./setup-cloud.sh --verbose
```

### What Gets Set Up

✅ Node.js and npm dependencies  
✅ All project dependencies  
✅ Script permissions (executable)  
✅ Full test suite execution  
✅ Skill configuration  
✅ Plugin configuration  

---

## 🧠 Claude Cloud Setup

### Installation as a Claude Skill

1. **In Your Claude Workspace**

   ```bash
   # Option 1: Create symbolic link
   ln -s /path/to/wp-db-migrate/skill ~/.claude/skills/wp-db-migrate

   # Option 2: Copy to workspace skills
   cp -r /path/to/wp-db-migrate/skill ~/.claude/skills/wp-db-migrate
   ```

2. **Verify Installation**

   ```bash
   # Check if skill is discoverable
   ls -la ~/.claude/skills/wp-db-migrate/
   
   # Should show:
   # SKILL.md
   # scripts/
   # evals/
   ```

3. **Use in Claude**

   The skill will automatically be available in your Claude workspace:
   - Start a new chat
   - Mention "wp-db-migrate" or "database migration"
   - Use the skill commands

### Installation as a Claude Plugin

1. **Add Plugin to Claude**

   - Open Claude settings
   - Go to Plugins section
   - Click "Add Plugin"
   - Point to `/path/to/wp-db-migrate/plugin`
   - Enable the plugin

2. **Use in Chat**

   ```
   /wp-db-migrate

   Then use commands like:
   - migrate-recovery: Complete migration workflow
   - preflight-check: Verify environment
   - verify-import: Check if import succeeded
   ```

---

## 🤖 GitHub Actions CI/CD

### Automatic Setup with GitHub Actions

The repository includes a complete GitHub Actions workflow (`.github/workflows/setup-cloud.yml`) that:

- Runs on every push and pull request
- Tests across Node.js versions (18.x, 20.x, 22.x)
- Validates configuration files
- Runs security scans
- Builds deployment artifacts
- Uploads coverage reports

### Enable GitHub Actions

1. **Push the Workflow File**

   The workflow is already in `.github/workflows/setup-cloud.yml`

2. **Trigger Workflow**

   ```bash
   # Automatically runs on push
   git push origin main

   # Or manually trigger in GitHub UI
   # Actions → Cloud Setup & Test → Run workflow
   ```

3. **Monitor Workflow**

   - Visit: `https://github.com/lightspeedwp/wp-db-migrate/actions`
   - Click "Cloud Setup & Test"
   - View logs and coverage reports

### Workflow Jobs

#### 1. Setup & Test
- ✅ Installs Node.js
- ✅ Installs dependencies
- ✅ Runs complete test suite
- ✅ Uploads coverage to Codecov

#### 2. Validate Configuration
- ✅ Validates JSON files
- ✅ Checks plugin manifest
- ✅ Verifies required files exist

#### 3. Security Scanning
- ✅ Runs Trivy vulnerability scanner
- ✅ Uploads results to GitHub Security

#### 4. Build Artifact
- ✅ Creates deployment packages (tar.gz and zip)
- ✅ Uploads as GitHub artifact
- ✅ Available for download/deployment

---

## 🐳 Docker Deployment

### Build Docker Images

#### Production Image

```bash
# Build production image
docker build -t wp-db-migrate:latest .

# Run production container
docker run -v /path/to/wordpress:/wordpress wp-db-migrate
```

#### Development Image

```bash
# Build development image
docker build -f Dockerfile.dev -t wp-db-migrate:dev .

# Run development container with shell access
docker run -it -v $(pwd):/app wp-db-migrate:dev bash
```

### Using Docker Compose

#### Development Environment

```bash
# Start development container
docker-compose up dev

# Inside container, run setup
./setup-cloud.sh --verbose
```

#### Run Tests

```bash
# Run test suite in container
docker-compose up test

# Output shows coverage report
```

#### Run Linting

```bash
# Run shellcheck and other linters
docker-compose up lint
```

#### Production Container

```bash
# Build and run production container
docker-compose up prod

# Container runs preflight checks and exits
```

### Docker Commands Reference

```bash
# Build specific service
docker-compose build dev

# Run service in background
docker-compose up -d dev

# View logs
docker-compose logs -f dev

# Stop all services
docker-compose down

# Clean up (remove containers, networks, volumes)
docker-compose down -v

# List running containers
docker-compose ps
```

### Docker Deployment Options

#### Push to Docker Registry

```bash
# Tag for registry
docker tag wp-db-migrate:latest registry.example.com/wp-db-migrate:latest

# Push to registry
docker push registry.example.com/wp-db-migrate:latest

# Pull from registry
docker pull registry.example.com/wp-db-migrate:latest
```

#### Deploy to Docker Container Services

**AWS ECS:**
```bash
# Create ECS task definition
aws ecs register-task-definition \
  --family wp-db-migrate \
  --container-definitions file://task-definition.json
```

**Google Cloud Run:**
```bash
# Build and deploy
gcloud run deploy wp-db-migrate \
  --source . \
  --platform managed \
  --region us-central1
```

**Azure Container Instances:**
```bash
# Deploy container
az container create \
  --resource-group myResourceGroup \
  --name wp-db-migrate \
  --image wp-db-migrate:latest
```

---

## ☁️ Cloud Providers

### AWS (Amazon Web Services)

#### Option 1: EC2 Instance

```bash
# SSH into EC2 instance
ssh -i key.pem ec2-user@instance-ip

# Clone repository
git clone https://github.com/lightspeedwp/wp-db-migrate.git
cd wp-db-migrate

# Run setup
./setup-cloud.sh --production

# (Optional) Set up as service
sudo cp setup-cloud.sh /usr/local/bin/
```

#### Option 2: AWS Lambda

```bash
# Create Lambda function with Node.js 20.x runtime
aws lambda create-function \
  --function-name wp-db-migrate \
  --runtime nodejs20.x \
  --role arn:aws:iam::ACCOUNT_ID:role/lambda-role \
  --zip-file fileb://deployment.zip \
  --handler index.handler

# Invoke function
aws lambda invoke \
  --function-name wp-db-migrate \
  --payload '{}' \
  response.json
```

### Google Cloud Platform (GCP)

#### Cloud Compute Engine

```bash
# Create instance
gcloud compute instances create wp-db-migrate \
  --image-family=debian-11 \
  --image-project=debian-cloud \
  --zone=us-central1-a

# SSH to instance
gcloud compute ssh wp-db-migrate --zone=us-central1-a

# On instance:
git clone https://github.com/lightspeedwp/wp-db-migrate.git
cd wp-db-migrate
./setup-cloud.sh --production
```

#### Cloud Functions

```bash
# Deploy as Cloud Function
gcloud functions deploy wp-db-migrate \
  --runtime nodejs20 \
  --trigger-http \
  --entry-point handler \
  --allow-unauthenticated
```

### DigitalOcean

#### App Platform

```yaml
# app.yaml
name: wp-db-migrate
services:
  - name: web
    github:
      repo: lightspeedwp/wp-db-migrate
      branch: main
    build_command: npm install && npm test
    run_command: ./setup-cloud.sh --production
    http_port: 3000
```

Deploy:
```bash
doctl apps create --spec app.yaml
```

#### Droplet

```bash
# Create and SSH to droplet
doctl compute droplet create wp-db-migrate --region nyc1 --image ubuntu-22-04-x64

# SSH in and setup
ssh root@droplet-ip
apt update && apt install -y nodejs npm git
git clone https://github.com/lightspeedwp/wp-db-migrate.git
cd wp-db-migrate
./setup-cloud.sh --production
```

### Azure

#### App Service

```bash
# Create resource group
az group create --name myResourceGroup --location eastus

# Create App Service plan
az appservice plan create \
  --name wp-db-migrate-plan \
  --resource-group myResourceGroup \
  --sku B1

# Create web app
az webapp create \
  --resource-group myResourceGroup \
  --plan wp-db-migrate-plan \
  --name wp-db-migrate-app \
  --runtime "NODE|20"

# Deploy from GitHub
az webapp deployment source config-github \
  --resource-group myResourceGroup \
  --name wp-db-migrate-app \
  --repo-url https://github.com/lightspeedwp/wp-db-migrate
```

#### Virtual Machine

```bash
# Create VM
az vm create \
  --resource-group myResourceGroup \
  --name wp-db-migrate-vm \
  --image UbuntuLTS

# SSH and setup
ssh azureuser@vm-ip
sudo apt update && sudo apt install -y nodejs npm git
git clone https://github.com/lightspeedwp/wp-db-migrate.git
cd wp-db-migrate
./setup-cloud.sh --production
```

---

## 🔧 Environment Configuration

### Using Environment Variables

```bash
# Set environment variables
export NODE_ENV=production
export VERBOSE=true
export CI_MODE=true

# Run setup with environment
./setup-cloud.sh

# Or set inline
NODE_ENV=production CI_MODE=true ./setup-cloud.sh --ci
```

### Using .env File

```bash
# Copy example to .env
cp .env.example .env

# Edit with your settings
nano .env

# Setup automatically loads .env
./setup-cloud.sh
```

### Environment Variables Reference

See `.env.example` for complete list. Key variables:

```bash
# Application
NODE_ENV=production
DEBUG=false
VERBOSE=false

# Database
SOURCE_DB_HOST=localhost
SOURCE_DB_PORT=3306
SOURCE_DB_NAME=wordpress

# WordPress Studio
STUDIO_PATH=~/.studio

# Migration
CURRENT_URL=https://old-site.com
TARGET_URL=https://new-site.local

# Cloud
CLOUD_PROVIDER=aws
```

---

## 🐛 Troubleshooting

### Setup Script Issues

#### Permission Denied
```bash
# Make script executable
chmod +x setup-cloud.sh

# Verify
./setup-cloud.sh --help
```

#### Node.js Not Found
```bash
# Check Node.js installation
node -v
npm -v

# Install Node.js manually
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs
```

#### Dependencies Installation Fails
```bash
# Clear npm cache
npm cache clean --force

# Try again
npm install

# If still failing, check:
npm ls
npm audit
```

### GitHub Actions Issues

#### Workflow Not Triggering
- Check branch protection rules
- Verify workflow file syntax (yml)
- Check file is in `.github/workflows/`
- Try manual trigger: Actions → workflow name → Run workflow

#### Tests Failing in CI
```bash
# Run tests locally first
npm test

# Check Node.js version consistency
node -v  # Should match matrix version

# Check package-lock.json is committed
git status package-lock.json
```

#### Artifacts Not Uploading
- Check workflow has `upload-artifact` step
- Verify artifact paths exist
- Check artifact doesn't exceed size limit (400MB)

### Docker Issues

#### Image Build Fails
```bash
# Check Docker daemon
docker ps

# Build with verbose output
docker build -t wp-db-migrate:latest . --progress=plain

# Check Dockerfile syntax
docker build --help | grep -i check
```

#### Container Won't Start
```bash
# Check logs
docker logs container-id

# Inspect image
docker inspect wp-db-migrate:latest

# Test base image
docker run -it node:22-alpine bash
```

#### Permission Issues in Container
```bash
# Check user in container
docker exec -it container-id whoami

# Check file permissions
docker exec -it container-id ls -la /app

# Run as root (temporary)
docker run -u root wp-db-migrate:dev bash
```

### Cloud Deployment Issues

#### Cannot Connect to Database
- Check network connectivity to database
- Verify credentials in environment variables
- Check security groups/firewall rules
- Test with `ping` or `nc` (netcat)

#### Setup Script Hangs
- Set timeout: `timeout 600 ./setup-cloud.sh`
- Check for interactive prompts: `./setup-cloud.sh --ci --force`
- Monitor with `./setup-cloud.sh --verbose`

#### Low Disk Space
```bash
# Check available space
df -h

# Clean Docker (frees ~1GB)
docker system prune -a

# Clean npm cache
npm cache clean --force
```

---

## 📚 Additional Resources

- **GitHub Actions Docs**: https://docs.github.com/en/actions
- **Docker Docs**: https://docs.docker.com/
- **Claude Code**: https://claude.com/claude-code
- **WordPress Studio CLI**: https://developer.wordpress.com/docs/developer-tools/studio/cli/
- **WordPress CLI**: https://wp-cli.org/

---

## ✅ Verification Checklist

After cloud setup, verify everything works:

- [ ] Setup script runs without errors
- [ ] All dependencies installed
- [ ] Scripts are executable
- [ ] Tests pass (or skipped in --skip-tests)
- [ ] Skill configured correctly
- [ ] Plugin manifest valid
- [ ] Environment variables set
- [ ] Network connectivity to database
- [ ] Disk space available
- [ ] Docker images build successfully
- [ ] GitHub Actions workflow triggers

---

## 🆘 Getting Help

1. **Check Troubleshooting Section** above
2. **Run Preflight Check**: `./skill/scripts/preflight-check.sh`
3. **Enable Verbose Output**: `./setup-cloud.sh --verbose`
4. **Check Logs**: Look in `./logs/` directory
5. **Review Documentation**:
   - README.md — Feature overview
   - skill/SKILL.md — Detailed usage guide
   - skill/IMPROVEMENTS.md — Changelog and roadmap

---

**Version**: 1.1.0  
**Last Updated**: 2026-10-29  
**Maintainer**: Ash Shaw <ashley@lightspeedwp.agency>
