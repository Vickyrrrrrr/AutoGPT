# 🚀 AutoGPT Platform Deployment Checklist

## ✅ Completed Steps:
- [x] Created Supabase project
- [x] Created Upstash Redis database
- [x] Created CloudAMQP RabbitMQ instance
- [x] Generated security keys
- [x] Prepared environment variables

---

## 🔄 Current Step: Deploy Backend to Render

### What to Do:
1. Go to https://render.com
2. Sign in with GitHub
3. Click "New +" → "Web Service"
4. Connect your AutoGPT repository
5. Configure:
   - Name: autogpt-backend
   - Root Directory: autogpt_platform/backend
   - Runtime: Docker
   - Branch: master
   - Instance Type: Free

6. Add environment variables from: `render-env-vars.txt`
   - Total: 14 variables
   - Copy each key-value pair

7. Click "Create Web Service"

### What to Expect:
- ⏱️ Build time: 10-15 minutes
- ⚠️ First deploy may FAIL - this is normal!
- Why? Database migrations need to run first

### After First Deploy:
When it fails (or succeeds), go to:
- Shell tab → Run: `npx prisma migrate deploy`
- Then: Manual Deploy → Deploy

---

## ⏳ Next Step: Deploy Frontend to Vercel

### What to Do:
1. Go to https://vercel.com
2. Sign in with GitHub
3. Click "Add New" → "Project"
4. Import your AutoGPT repository
5. Configure:
   - Project Name: autogpt-platform
   - Framework: Next.js
   - Root Directory: autogpt_platform/frontend
   - Build Command: pnpm build
   - Install Command: pnpm install

6. Add environment variables from: `vercel-env-vars.txt`
   - Total: 7 variables
   - Copy each key-value pair

7. Click "Deploy"

### What to Expect:
- ⏱️ Deploy time: 5-10 minutes
- ✅ Should succeed on first try
- 🎉 You'll get a live URL!

---

## 🎯 Final Steps:

### After Both Deployments:
1. Get your Render backend URL (e.g., https://autogpt-backend-xxxx.onrender.com)
2. Update Vercel environment variables if URL is different:
   - NEXT_PUBLIC_AGPT_SERVER_URL
   - NEXT_PUBLIC_AGPT_WS_SERVER_URL
3. Redeploy Vercel frontend

### Test Your Deployment:
1. Visit your Vercel URL
2. Sign up for an account
3. Try creating a workflow!

---

## 📝 Important Notes:

### Free Tier Limitations:
- Render backend sleeps after 15min inactivity (wakes in ~30s)
- Supabase: 500MB database
- Upstash: 10,000 Redis commands/day
- CloudAMQP: Limited connections

### Troubleshooting:
- Backend won't start? Check environment variables
- Database errors? Run Prisma migrations
- Frontend errors? Check backend URL in env vars

---

## 🎉 Success Criteria:

You'll know it's working when:
- ✅ Render backend shows "Live" status
- ✅ Vercel frontend is accessible
- ✅ You can sign up/login
- ✅ You can see the workflow editor

---

## 📞 Current Status:

- [ ] Render backend deploying...
- [ ] Vercel frontend (waiting for backend)
- [ ] Database migrations
- [ ] Testing deployment

**Update this checklist as you progress!**
