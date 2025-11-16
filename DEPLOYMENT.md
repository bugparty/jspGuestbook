# Deployment Guide

This guide covers deploying the JSP Guestbook application to various free hosting platforms.

## 📋 Table of Contents

- [Railway.app](#railwayapp-recommended)
- [Render.com](#rendercom)
- [Fly.io](#flyio)
- [Google Cloud Run](#google-cloud-run)
- [Platform Comparison](#platform-comparison)

---

## Railway.app (Recommended)

**Free Tier:** $5/month credit (500 hours)

### Why Railway?
- ✅ Easy to use
- ✅ Auto-deploy from GitHub
- ✅ Persistent storage included
- ✅ Automatic HTTPS
- ✅ Great for Java applications

### Deployment Steps

1. **Sign up at [Railway.app](https://railway.app)**

2. **Create a new project:**
   - Click "New Project"
   - Select "Deploy from GitHub repo"
   - Authorize GitHub and select your repository

3. **Configure deployment:**
   - Railway will auto-detect the Maven project
   - The `railway.json` configuration is already set up

4. **Add persistent storage (optional but recommended):**
   - Click "New" → "Empty Volume"
   - Mount path: `/app/data`
   - This ensures your database persists across deployments

5. **Set environment variables (optional):**
   ```
   DB_PATH=/app/data/guestbook.db
   ```

6. **Deploy:**
   - Railway will automatically build and deploy
   - You'll get a URL like: `https://your-app.railway.app`

### Access your app:
```
https://your-app.railway.app/guestbook/
```

---

## Render.com

**Free Tier:** 750 hours/month per service

### Why Render?
- ✅ True free tier (no credit card required)
- ✅ Auto-deploy from GitHub
- ✅ Automatic HTTPS
- ✅ Good Java support

### Deployment Steps

1. **Sign up at [Render.com](https://render.com)**

2. **Create a new Web Service:**
   - Click "New +" → "Web Service"
   - Connect your GitHub repository

3. **Configure:**
   - **Name:** jsp-guestbook
   - **Environment:** Java
   - **Build Command:** `mvn clean package -DskipTests && wget -q https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-runner/9.4.51.v20230217/jetty-runner-9.4.51.v20230217.jar -O jetty-runner.jar`
   - **Start Command:** `java -Ddb.path=/opt/render/project/src/guestbook.db -jar jetty-runner.jar --port $PORT web`

4. **Add Disk (for persistent database):**
   - In your service settings, add a disk
   - Name: guestbook-data
   - Mount Path: `/opt/render/project/src`
   - Size: 1 GB

5. **Deploy:**
   - Click "Create Web Service"
   - Render will build and deploy automatically

**Note:** The `render.yaml` file is already configured for one-click deployment.

### Access your app:
```
https://jsp-guestbook.onrender.com/guestbook/
```

---

## Fly.io

**Free Tier:** 3 shared-cpu-1x VMs, 3GB persistent storage

### Why Fly.io?
- ✅ Generous free tier
- ✅ Fast global deployment
- ✅ Docker-based (flexible)
- ✅ Persistent volumes included

### Prerequisites

Install Fly CLI:
```bash
# macOS
brew install flyctl

# Linux
curl -L https://fly.io/install.sh | sh

# Windows
powershell -Command "iwr https://fly.io/install.ps1 -useb | iex"
```

### Deployment Steps

1. **Login to Fly.io:**
   ```bash
   fly auth login
   ```

2. **Launch the app:**
   ```bash
   fly launch
   ```

   When prompted:
   - App name: Press Enter to use auto-generated name or type your own
   - Region: Select closest to you
   - PostgreSQL: No (we use SQLite)
   - Redis: No
   - Deploy now: Yes

3. **Create persistent volume for database:**
   ```bash
   fly volumes create guestbook_data --size 1
   ```

4. **Deploy:**
   ```bash
   fly deploy
   ```

5. **Open your app:**
   ```bash
   fly open /guestbook/
   ```

### Useful Fly.io Commands

```bash
# View logs
fly logs

# Check status
fly status

# SSH into machine
fly ssh console

# Scale (adjust resources)
fly scale count 1

# View dashboard
fly dashboard
```

### Access your app:
```
https://your-app-name.fly.dev/guestbook/
```

---

## Google Cloud Run

**Free Tier:** 2 million requests/month, 360,000 GB-seconds memory

### Why Cloud Run?
- ✅ Very generous free tier
- ✅ Scales to zero (no cost when idle)
- ✅ Fast cold starts
- ✅ Part of GCP ecosystem

### Prerequisites

1. Install [Google Cloud CLI](https://cloud.google.com/sdk/docs/install)
2. Create a [GCP project](https://console.cloud.google.com)
3. Enable Cloud Run API

### Deployment Steps

1. **Authenticate:**
   ```bash
   gcloud auth login
   gcloud config set project YOUR_PROJECT_ID
   ```

2. **Build and push image:**
   ```bash
   # Enable Container Registry
   gcloud services enable containerregistry.googleapis.com

   # Build image
   docker build -f Dockerfile.production -t gcr.io/YOUR_PROJECT_ID/jsp-guestbook .

   # Push to registry
   docker push gcr.io/YOUR_PROJECT_ID/jsp-guestbook
   ```

3. **Deploy to Cloud Run:**
   ```bash
   gcloud run deploy jsp-guestbook \
     --image gcr.io/YOUR_PROJECT_ID/jsp-guestbook \
     --platform managed \
     --region us-central1 \
     --allow-unauthenticated \
     --memory 512Mi
   ```

4. **Access your app:**
   - Cloud Run will provide a URL
   - Add `/guestbook/` to access the app

**Note:** Cloud Run is stateless, so the SQLite database will reset on each deployment. For production, consider using Cloud SQL or another persistent database.

---

## Platform Comparison

| Feature | Railway | Render | Fly.io | Cloud Run |
|---------|---------|--------|--------|-----------|
| **Free Tier** | $5/month credit | 750 hrs/month | 3 VMs always on | 2M requests/month |
| **Ease of Setup** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐ |
| **Persistent Storage** | ✅ Easy | ✅ Yes | ✅ Yes | ❌ Complex |
| **Auto-deploy from Git** | ✅ Yes | ✅ Yes | ✅ Yes | ❌ Manual |
| **Custom Domain** | ✅ Free | ✅ Free | ✅ Free | ✅ Free |
| **HTTPS** | ✅ Auto | ✅ Auto | ✅ Auto | ✅ Auto |
| **Build Time** | ~2-3 min | ~3-4 min | ~2-3 min | ~2-3 min |
| **Cold Start** | Fast | Medium | Fast | Very Fast |
| **Best For** | Quick demos | Production apps | Global apps | Serverless |

---

## Recommendations

### For Quick Demo (Easiest):
**Use Railway.app** - Just connect your GitHub repo and deploy in 2 clicks.

### For Long-term Free Hosting:
**Use Render.com** - 750 hours/month is enough for personal projects, and it requires no credit card.

### For Production-like Environment:
**Use Fly.io** - More control, better performance, and generous free tier.

### For Serverless/Scaling:
**Use Google Cloud Run** - Best for apps with variable traffic, but database persistence is challenging with SQLite.

---

## Troubleshooting

### Database Issues
- Ensure persistent storage/volume is mounted
- Check DB_PATH environment variable
- Verify write permissions on data directory

### Port Binding
- Most platforms auto-set `PORT` environment variable
- The app is configured to use `$PORT` automatically

### Memory Issues
- Default: 512MB should be sufficient
- If needed, increase to 1GB in platform settings

### Build Failures
- Check Maven logs for dependency issues
- Ensure Java 21 (or at least 1.8) is available
- Verify internet connectivity for downloading Jetty Runner

---

## Support

For platform-specific issues:
- Railway: https://railway.app/help
- Render: https://render.com/docs
- Fly.io: https://fly.io/docs
- Cloud Run: https://cloud.google.com/run/docs

For application issues, please open an issue on GitHub.
