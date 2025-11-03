# AutoGPT Platform - Quick Deploy to Cloud
# This script helps you deploy AutoGPT Platform to free cloud services

Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "AutoGPT Platform - Cloud Deployment Helper" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "This script will guide you through deploying AutoGPT Platform" -ForegroundColor Yellow
Write-Host "to free cloud services (Supabase, Render, Vercel)." -ForegroundColor Yellow
Write-Host ""

Write-Host "STEP 1: Generated Security Keys" -ForegroundColor Green
Write-Host "---------------------------------------" -ForegroundColor Green
Write-Host "Save these keys - you'll need them for deployment:" -ForegroundColor White
Write-Host ""

# Generate keys
$jwt_key = [Convert]::ToBase64String([System.Security.Cryptography.RandomNumberGenerator]::GetBytes(32))
$encryption_key = [Convert]::ToBase64String([System.Security.Cryptography.RandomNumberGenerator]::GetBytes(32))
$unsubscribe_key = [Convert]::ToBase64String([System.Security.Cryptography.RandomNumberGenerator]::GetBytes(32))

Write-Host "JWT_VERIFY_KEY=" -NoNewline; Write-Host $jwt_key -ForegroundColor Cyan
Write-Host "ENCRYPTION_KEY=" -NoNewline; Write-Host $encryption_key -ForegroundColor Cyan
Write-Host "UNSUBSCRIBE_SECRET_KEY=" -NoNewline; Write-Host $unsubscribe_key -ForegroundColor Cyan
Write-Host ""

Write-Host "STEP 2: Create Cloud Accounts" -ForegroundColor Green
Write-Host "---------------------------------------" -ForegroundColor Green
Write-Host "Please create accounts (if you haven't already):" -ForegroundColor White
Write-Host ""
Write-Host "1. Supabase:   https://supabase.com" -ForegroundColor Yellow
Write-Host "2. Upstash:    https://upstash.com" -ForegroundColor Yellow
Write-Host "3. CloudAMQP:  https://cloudamqp.com" -ForegroundColor Yellow
Write-Host "4. Render:     https://render.com" -ForegroundColor Yellow
Write-Host "5. Vercel:     https://vercel.com" -ForegroundColor Yellow
Write-Host ""

Write-Host "STEP 3: Follow the Deployment Guide" -ForegroundColor Green
Write-Host "---------------------------------------" -ForegroundColor Green
Write-Host "Open the detailed guide:" -ForegroundColor White
Write-Host "  autogpt_platform\CLOUD_DEPLOYMENT.md" -ForegroundColor Cyan
Write-Host ""

Write-Host "The guide includes:" -ForegroundColor White
Write-Host "  ✓ Step-by-step setup for each service" -ForegroundColor Gray
Write-Host "  ✓ Environment variables configuration" -ForegroundColor Gray
Write-Host "  ✓ Database migration instructions" -ForegroundColor Gray
Write-Host "  ✓ Troubleshooting tips" -ForegroundColor Gray
Write-Host ""

Write-Host "STEP 4: Estimated Time" -ForegroundColor Green
Write-Host "---------------------------------------" -ForegroundColor Green
Write-Host "Total deployment time: ~30-45 minutes" -ForegroundColor White
Write-Host "  - Supabase setup:    5 min" -ForegroundColor Gray
Write-Host "  - Upstash + AMQP:    5 min" -ForegroundColor Gray
Write-Host "  - Render backend:    15 min" -ForegroundColor Gray
Write-Host "  - Vercel frontend:   5 min" -ForegroundColor Gray
Write-Host "  - Testing:           10 min" -ForegroundColor Gray
Write-Host ""

Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "Ready to start? Open CLOUD_DEPLOYMENT.md and let's go! 🚀" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""

# Ask if user wants to open the guide
$response = Read-Host "Open deployment guide now? (Y/N)"
if ($response -eq "Y" -or $response -eq "y") {
    Start-Process "autogpt_platform\CLOUD_DEPLOYMENT.md"
}
