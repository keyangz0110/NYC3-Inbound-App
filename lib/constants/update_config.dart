/// Default URL of the hosted [version.json] used by Check for Update.
///
/// Override this at runtime in Settings → Advanced → Update server URL.
class UpdateConfig {
  UpdateConfig._();

  /// Stable raw URL on GitHub (update [update_hosting/version.json] when you ship).
  static const String defaultManifestUrl =
      'https://raw.githubusercontent.com/keyangz0110/NYC3-Inbound-App/main/update_hosting/version.json';
}
