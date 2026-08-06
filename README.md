# NYC3 Inbound

Android PDA app for warehouse inbound sorting: scan carton (IBR) and product barcodes, assign slot numbers, manage finished cartons, and print ZPL labels on Zebra ZQ521 printers.

**Current release:** [v2.3.2](https://github.com/keyangz0110/NYC3-Inbound-App/releases/tag/v2.3.2) (`2.3.2+13`)

## Features

- **Sort** — Open a carton with an IBR barcode, scan products into slots, optional on-screen quantity (tap to undo/delete), close slots, finish sorting with optional label print
- **Manage** — Search cartons, reopen/delete, view slots and totals, print labels, clear all (archives for export)
- **Zebra printing** — Bluetooth Classic or Wi-Fi (discovery or manual IP, TCP 9100) for ZQ521 ZPL labels
- **Settings** — Language (EN / ES / ZH / ID / FR), theme, display quantity, printer, export history, About → Check for Update
- **Self-update** — Fetches hosted `version.json`, downloads the release APK, and opens the system installer

## Requirements

- Flutter SDK (see `pubspec.yaml` for the Dart SDK constraint)
- Android device or PDA (primary target); release builds are APKs

## Build

```bash
flutter pub get
flutter build apk --release
```

Output APK is named like `NYC3-Inbound-2.3.2.apk` under `build/app/outputs/flutter-apk/`.

## Install / update on PDAs

1. Install from a [GitHub Release](https://github.com/keyangz0110/NYC3-Inbound-App/releases) APK, or use **About → Check for Update** on a build that already has the update flow.
2. Manifest URL (prefer this form; less CDN lag than `/main/`):

   `https://raw.githubusercontent.com/keyangz0110/NYC3-Inbound-App/refs/heads/main/update_hosting/version.json`

3. Shipping a new version: bump `pubspec.yaml`, upload a Release APK, update [`update_hosting/version.json`](update_hosting/version.json). Details in [`update_hosting/README.md`](update_hosting/README.md).

## Project layout

| Path | Role |
| ------ | ------ |
| `lib/screens/` | Sort, Manage, settings, printer, About |
| `lib/services/` | Storage, print, export, updates, locale/theme |
| `lib/l10n/` | ARB localizations |
| `update_hosting/` | Hosted update manifest example |

## License

Private / internal use unless otherwise stated.
