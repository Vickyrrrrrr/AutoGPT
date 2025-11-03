# AutoGPT Platform - Free Cloud Deployment Guide

This guide will help you deploy AutoGPT Platform to free cloud services.

## Services Used

- **Database & Auth**: Supabase (PostgreSQL + Authentication)
- **Backend API**: Render.com (Free tier)
- **Frontend**: Vercel (Free tier)
- **Redis**: Upstash (Free tier)
- **RabbitMQ**: CloudAMQP (Free tier)

---

## Step 1: Setup Supabase (Database + Auth)

### 1.1 Create Supabase Project

1. Go to https://supabase.com/
2. Click "Start your project" → Sign up with GitHub
3. Click "New Project"
4. Fill in:
   - **Name**: `autogpt-platform`
   - **Database Password**: Generate a strong password (save it!)
   - **Region**: Choose closest to you
   - **Pricing**: Free tier
5. Click "Create new project" (takes ~2 minutes)

### 1.2 Get Supabase Credentials

Once created, go to **Project Settings** → **API**:

- **Project URL**: `https://xxxxx.supabase.co`
- **anon/public key**: `eyJhbGc...` (long string)
- **service_role key**: `eyJhbGc...` (different long string - keep secret!)

Also get your **Database Connection String**:
- Go to **Project Settings** → **Database**
- Copy the **Connection string** (URI format)
- It looks like: `postgresql://postgres:[YOUR-PASSWORD]@db.xxxxx.supabase.co:5432/postgres`

**Save these values - you'll need them!**

---

## Step 2: Setup Upstash (Redis)

1. Go to https://upstash.com/
2. Sign up with GitHub
3. Click "Create Database"
4. Fill in:
   - **Name**: `autogpt-redis`
   - **Type**: Regional
   - **Region**: Same as Supabase
   - **Eviction**: No eviction
5. Click "Create"

### Get Redis Credentials:

From the database page, copy:
- **Endpoint**: `xxxxx.upstash.io`
- **Port**: `6379` or custom
- **Password**: Your Redis password

**Save these values!**

---

## Step 3: Setup CloudAMQP (RabbitMQ)

1. Go to https://www.cloudamqp.com/
2. Sign up (free)
3. Click "Create New Instance"
4. Fill in:
   - **Name**: `autogpt-rabbitmq`
   - **Plan**: Little Lemur (Free)
   - **Region**: Same as Supabase
5. Click "Create instance"

### Get RabbitMQ Credentials:

From the instance details page, copy the **AMQP URL**:
- Format: `amqps://user:pass@host/vhost`

**Save this URL!**

---

## Step 4: Deploy Backend to Render

### 4.1 Create Render Account

1. Go to https://render.com/
2. Sign up with GitHub
3. Authorize Render to access your AutoGPT repository

### 4.2 Deploy Backend

1. Click "New +" → "Web Service"
2. Connect your GitHub repository: `AutoGPT`
3. Fill in:
   - **Name**: `autogpt-backend`
   - **Root Directory**: `autogpt_platform/backend`
   - **Environment**: Docker
   - **Branch**: `master`
   - **Plan**: Free
4. Click "Advanced" and add environment variables:

```bash
DATABASE_URL=<your-supabase-connection-string>
DIRECT_URL=<your-supabase-connection-string>
REDIS_HOST=<your-upstash-endpoint>
REDIS_PORT=6379
REDIS_PASSWORD=<your-upstash-password>
RABBITMQ_URL=<your-cloudamqp-url>
SUPABASE_URL=<your-supabase-project-url>
SUPABASE_SERVICE_ROLE_KEY=<your-supabase-service-role-key>
JWT_VERIFY_KEY=<generate-random-32-char-string>
ENCRYPTION_KEY=<generate-random-32-char-string>
UNSUBSCRIBE_SECRET_KEY=<generate-random-32-char-string>
DB_SCHEMA=platform
PLATFORM_BASE_URL=https://autogpt-backend.onrender.com
FRONTEND_BASE_URL=https://autogpt-platform.vercel.app
```

5. Click "Create Web Service"
6. Wait for deployment (~10 minutes)

**Save your backend URL**: `https://autogpt-backend.onrender.com`

---

## Step 5: Deploy Frontend to Vercel

### 5.1 Create Vercel Account

1. Go to https://vercel.com/
2. Sign up with GitHub

### 5.2 Deploy Frontend

1. Click "Add New" → "Project"
2. Import your GitHub repository: `AutoGPT`
3. Configure:
   - **Project Name**: `autogpt-platform`
   - **Framework Preset**: Next.js
   - **Root Directory**: `autogpt_platform/frontend`
   - **Build Command**: `pnpm build`
   - **Install Command**: `pnpm install`

4. Add environment variables:

```bash
NEXT_PUBLIC_SUPABASE_URL=<your-supabase-project-url>
NEXT_PUBLIC_SUPABASE_ANON_KEY=<your-supabase-anon-key>
NEXT_PUBLIC_AGPT_SERVER_URL=https://autogpt-backend.onrender.com/api
NEXT_PUBLIC_AGPT_WS_SERVER_URL=wss://autogpt-backend.onrender.com/ws
NEXT_PUBLIC_FRONTEND_BASE_URL=https://autogpt-platform.vercel.app
NEXT_PUBLIC_APP_ENV=production
NEXT_PUBLIC_BEHAVE_AS=PRODUCTION
```

5. Click "Deploy"
6. Wait for deployment (~5 minutes)

**Your frontend URL**: `https://autogpt-platform.vercel.app`

---

## Step 6: Run Database Migrations

After backend is deployed, you need to run Prisma migrations:

### Option A: Using Render Shell

1. Go to your Render backend service
2. Click "Shell" tab
3. Run:
```bash
npx prisma migrate deploy
npx prisma generate
```

### Option B: Using local machine (if you have backend access)

```bash
# Set DATABASE_URL to your Supabase connection string
$env:DATABASE_URL="<your-supabase-connection-string>"
cd autogpt_platform/backend
poetry run prisma migrate deploy
poetry run prisma generate
```

---

## Step 7: Test Your Deployment

1. Open your frontend URL: `https://autogpt-platform.vercel.app`
2. You should see the AutoGPT Platform login/signup page
3. Create an account
4. Start building workflows!

---

## Important Notes

### Free Tier Limitations:

- **Render**: Backend sleeps after 15min inactivity (takes ~30s to wake up)
- **Supabase**: 500MB database, 2GB bandwidth/month
- **Upstash**: 10,000 commands/day
- **CloudAMQP**: Limited connections
- **Vercel**: 100GB bandwidth/month

### Security Keys Generation:

Generate random 32-character strings for:
- `JWT_VERIFY_KEY`
- `ENCRYPTION_KEY`
- `UNSUBSCRIBE_SECRET_KEY`

You can generate them using:
```python
import secrets
print(secrets.token_urlsafe(32))
```

Or online: https://generate-random.org/api-key-generator

---

## Troubleshooting

### Backend won't start:
- Check environment variables are set correctly
- Verify database connection string
- Check Render logs

### Frontend shows errors:
- Verify `NEXT_PUBLIC_AGPT_SERVER_URL` points to your Render backend
- Check browser console for errors
- Ensure backend is running (visit backend URL)

### Database connection fails:
- Verify Supabase connection string format
- Check if database is active (Supabase dashboard)
- Ensure `DB_SCHEMA=platform` is set

---

## Optional: Add API Keys

To enable AI features, add these to your Render backend environment variables:

```bash
OPENAI_API_KEY=sk-...
ANTHROPIC_API_KEY=sk-ant-...
```

Get API keys from:
- OpenAI: https://platform.openai.com/api-keys
- Anthropic: https://console.anthropic.com/

---

## Next Steps

Once deployed:
1. Explore the visual workflow editor
2. Browse the block library
3. Create your first automation workflow
4. Share your agents with others!

Enjoy your n8n-style AI automation platform! 🚀
