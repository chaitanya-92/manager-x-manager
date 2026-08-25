# Astrotalk — Private Root Manager Build Notes

Rebrand of KernelSU-Next into a private, exclusive root manager, LKM-mode.

## Identity

| | |
|---|---|
| App name | **Astrotalk** |
| Package / applicationId | `com.astrotalk.manager` |
| Keystore | `manager/key.jks` (gitignored) |
| Key alias | `astrotalk` |
| Store/key password | `astrotalk123` |
| Key type | **RSA 2048** (required — see limit below) |

## Signing certificate values baked into the kernel

```
KSU_NEXT_MANAGER_SIZE = 0x2d1   (721 bytes)
KSU_NEXT_MANAGER_HASH = 87b15367b9b35431b501bd2f9e2737a701200231e46cf35d3472e1eaa52a4baa
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
python3 verify_apk.py app/build/outputs/apk/release/Astrotalk_*.apk
```
