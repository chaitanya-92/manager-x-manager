# Rapido — Private Root Manager Build Notes

Rebrand of KernelSU-Next into a private, exclusive root manager, LKM-mode.

## Identity

| | |
|---|---|
| App name | **Rapido** |
| Package / applicationId | `com.rapido.manager` |
| Keystore | `manager/key.jks` (gitignored) |
| Key alias | `rapido` |
| Store/key password | `rapido123` |
| Key type | **RSA 2048** (required — see limit below) |

## Signing certificate values baked into the kernel

```
KSU_NEXT_MANAGER_SIZE = 0x2cb   (715 bytes)
KSU_NEXT_MANAGER_HASH = 674b15d02ebff1ccf5e515ef2ae7c672309ef02d0a4502f5d976e97e26e407b7
```

Configured in `kernel/Kbuild`.

## Hard Limits in Kernel (`kernel/manager/apk_sign.c`)

1. **Certificate must be <= 1024 bytes.** The kernel copies the signing cert into a fixed `CERT_MAX_LENGTH 1024` buffer and rejects anything bigger.
2. **APK must be signed with v2 scheme ONLY.** The kernel rejects APKs with v1 (JAR) or v3/v3.1 signatures.

## Local Build & Verify

```bash
cd manager
./gradlew clean assembleRelease

# Verify cert hash matches baked-in kernel hash:
python3 verify_apk.py app/build/outputs/apk/release/Rapido_*.apk
```
