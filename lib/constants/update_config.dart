/// Default URL of the hosted [version.json] used by Check for Update.
///
/// Override this at runtime in Settings → Advanced → Update server URL.
/// Leave empty to require configuring the URL on each device (or set a
/// company HTTPS URL here before building).
class UpdateConfig {
  UpdateConfig._();

  /// Example: `https://files.example.com/nyc3-inbound/version.json`
  static const String defaultManifestUrl = '';
}
