# Hosting app updates (GitHub)

## Current release

- APK: https://github.com/keyangz0110/NYC3-Inbound-App/releases/download/v2.3.2/NYC3-Inbound-App-v2.3.2.apk
- Manifest (stable URL for the app): https://raw.githubusercontent.com/keyangz0110/NYC3-Inbound-App/main/update_hosting/version.json

## When you ship a new version

1. Bump `version:` in `pubspec.yaml` (e.g. `2.3.3+14`).
2. Build: `flutter build apk --release`
3. Create a GitHub Release (tag e.g. `v2.3.3`) and upload the APK.
4. Edit `update_hosting/version.json`:
   - `versionCode` = build number (`+14` → `14`)
   - `versionName` = `2.3.3`
   - `apkUrl` = the new release download URL
5. Commit and push `version.json` to `main`.

PDAs already have the default manifest URL baked in. They only need **About → Check for Update**.

Devices that installed an older build without the default URL: set  
`https://raw.githubusercontent.com/keyangz0110/NYC3-Inbound-App/main/update_hosting/version.json`  
in **Settings → Advanced → Update server URL**.
