"""
Generate secure random keys for AutoGPT Platform deployment
"""
import secrets
from cryptography.fernet import Fernet

print("=" * 60)
print("AutoGPT Platform - Security Keys Generator")
print("=" * 60)
print()

print("Copy these values to your deployment environment variables:")
print()

print("JWT_VERIFY_KEY:")
print(secrets.token_urlsafe(32))
print()

print("ENCRYPTION_KEY:")
print(Fernet.generate_key().decode())
print()

print("UNSUBSCRIBE_SECRET_KEY:")
print(secrets.token_urlsafe(32))
print()

print("=" * 60)
print("IMPORTANT: Keep these keys secret and secure!")
print("=" * 60)
