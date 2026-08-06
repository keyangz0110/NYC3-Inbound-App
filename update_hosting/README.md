# Hosting app updates

1. Upload your release APK and this `version.json` to the same HTTPS folder (or any URLs you prefer).
2. Edit `version.json`:
   - `versionCode` must be **greater** than the installed app's build number (`+N` in `pubspec.yaml`).
   - `versionName` is the display version (e.g. `2.4.0`).
   - `apkUrl` must be a direct HTTPS link to the `.apk` file.
3. In the app: **Settings → Advanced → Update server URL** → paste the URL of `version.json`.
4. On each PDA: **Settings → About → Check for Update**.

Example `pubspec.yaml` version `2.4.0+14` means `versionCode` = `14`.
