// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Sorting';

  @override
  String get sortTab => 'Sort';

  @override
  String get manageTab => 'Manage';

  @override
  String get scanBoxCartonBarcode => 'Scan Box Carton Barcode';

  @override
  String get scanProductBarcode => 'Scan Product Barcode';

  @override
  String get readyToScan => 'Ready to scan...';

  @override
  String get slotLabel => 'Slot';

  @override
  String get quantityLabel => 'Quantity';

  @override
  String get displayQuantityOnSortScreen => 'Display Quantity on Sort Screen';

  @override
  String get totalQuantityLabel => 'Total Quantity';

  @override
  String cartonTotalQuantity(int count) {
    return 'Total quantity: $count';
  }

  @override
  String get productBarcodeLabel => 'Product Barcode';

  @override
  String get newSlotAssigned => 'New slot assigned';

  @override
  String get existingSlot => 'Existing slot';

  @override
  String get cartonOpened => 'Carton opened';

  @override
  String get invalidIbrBarcode => 'Barcode must start with IBR';

  @override
  String get activeCartonExists => 'Finish or clear the current carton first';

  @override
  String get noActiveCarton => 'No active carton';

  @override
  String get closeSlot => 'Close Slot';

  @override
  String get finishSorting => 'Finish Sorting';

  @override
  String get closeSlotTitle => 'Close slot?';

  @override
  String closeSlotContent(String slot) {
    return 'Close slot $slot? The next scan of this product will open a new slot.';
  }

  @override
  String get finishSortingTitle => 'Finish sorting?';

  @override
  String finishSortingContent(String ibr) {
    return 'Mark carton $ibr as finished?';
  }

  @override
  String errorMessage(String error) {
    return 'Error: $error';
  }

  @override
  String get searchCartons => 'Search IBR number';

  @override
  String get searchSlots => 'Barcode or slot number';

  @override
  String get noCartonsYet => 'No cartons yet';

  @override
  String get noSearchResults => 'No matching entries';

  @override
  String get clearSearch => 'Clear search';

  @override
  String get activeCarton => 'Active';

  @override
  String get finishedCarton => 'Finished';

  @override
  String get reopenCarton => 'Reopen Carton';

  @override
  String get deleteCarton => 'Delete Carton';

  @override
  String get reopenCartonTitle => 'Reopen carton?';

  @override
  String reopenCartonContent(String ibr) {
    return 'Reopen carton $ibr for sorting?';
  }

  @override
  String get deleteCartonTitle => 'Delete carton?';

  @override
  String deleteCartonContent(String ibr) {
    return 'Delete carton $ibr and all its slots?';
  }

  @override
  String get slotClosedLabel => 'Closed';

  @override
  String get undoProduct => 'Undo';

  @override
  String get deleteProduct => 'Delete';

  @override
  String get undoProductTitle => 'Undo last scan?';

  @override
  String undoProductContent(String slot) {
    return 'Decrease quantity for slot $slot by 1?';
  }

  @override
  String get deleteProductTitle => 'Delete product?';

  @override
  String deleteProductContent(String slot) {
    return 'Remove product from slot $slot and release the slot number?';
  }

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get confirm => 'Confirm';

  @override
  String get clearAllHistoryTitle => 'Clear all records?';

  @override
  String get clearAllHistoryContent =>
      'This archives all cartons to history and clears the screen. Archived data can be exported from Settings.';

  @override
  String get clearAll => 'Clear All';

  @override
  String get settings => 'Settings';

  @override
  String get advanced => 'Advanced';

  @override
  String get exportHistory => 'Export History';

  @override
  String exportHistorySuccess(String path) {
    return 'Exported to $path';
  }

  @override
  String get exportHistoryEmpty =>
      'No history to export. Use Clear All on Manage first.';

  @override
  String exportHistoryFailed(String error) {
    return 'Export failed: $error';
  }

  @override
  String get theme => 'Theme';

  @override
  String get themeSystem => 'System default';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get about => 'About';

  @override
  String get versionLabel => 'Version';

  @override
  String get authorLabel => 'Author';

  @override
  String get language => 'Language';

  @override
  String get languageEnUs => 'English (US)';

  @override
  String get languageEs419 => 'Español (Latinoamérica)';

  @override
  String get languageZhCn => '中文（简体）';

  @override
  String get languageIdId => 'Bahasa Indonesia';

  @override
  String get languageFrFr => 'Français (France)';

  @override
  String get printer => 'Printer';

  @override
  String get printerSettings => 'Printer Settings';

  @override
  String get discoverPrinters => 'Discover Printers';

  @override
  String get discoverBluetoothPrinters => 'Discover Bluetooth Printers';

  @override
  String get discoverWifiPrinters => 'Discover Wi-Fi Printers';

  @override
  String get discoveringPrinters => 'Discovering printers...';

  @override
  String get noPrinterConfigured => 'No printer configured';

  @override
  String get selectPrinter => 'Select a printer';

  @override
  String get connectionType => 'Connection type';

  @override
  String get connectionBluetooth => 'Bluetooth';

  @override
  String get connectionWifi => 'Wi-Fi';

  @override
  String get enterPrinterIp => 'Enter printer IP address';

  @override
  String get enterPrinterIpHint =>
      'Use when discovery fails. PDA and printer must be on the same Wi-Fi network.';

  @override
  String get printerIpHint => '192.168.1.50';

  @override
  String get savePrinterIp => 'Save';

  @override
  String get invalidPrinterIp =>
      'Enter a valid IPv4 address (e.g. 192.168.1.50)';

  @override
  String get testPrint => 'Test Print';

  @override
  String get printLabels => 'Print Labels';

  @override
  String get printingLabels => 'Printing labels...';

  @override
  String printProgress(int current, int total) {
    return 'Printing $current of $total';
  }

  @override
  String printSuccess(int count) {
    return 'Printed $count labels';
  }

  @override
  String printFailed(String error) {
    return 'Print failed: $error';
  }

  @override
  String get printFailedRetryHint => 'Use Manage → Print to try again';

  @override
  String get noSlotsToPrint => 'No slots to print';

  @override
  String get printerNotReady => 'Printer is not ready';

  @override
  String get bluetoothPermissionRequired =>
      'Bluetooth permissions are required for printing';

  @override
  String get cartonBarcodeLabel => 'Carton Barcode';

  @override
  String get printerSetupHelp =>
      'Configure your ZQ521 with the Zebra Printer Setup app. Use Bluetooth Classic for Bluetooth printing, or join the printer to your Wi-Fi network and use Discover Wi-Fi or enter its IP address.';

  @override
  String printerSaved(String name) {
    return 'Printer saved: $name';
  }

  @override
  String get noPrintersFound => 'No printers found';

  @override
  String get checkForUpdate => 'Check for Update';

  @override
  String get checkForUpdateSubtitle =>
      'Download the latest APK from your update server';

  @override
  String get updateUpToDate => 'You are on the latest version';

  @override
  String get updateUrlNotConfigured =>
      'Set the update server URL in Advanced settings first';

  @override
  String updateCheckFailed(String error) {
    return 'Update check failed: $error';
  }

  @override
  String get updateAvailableTitle => 'Update available';

  @override
  String updateAvailableContent(String currentVersion, String newVersion) {
    return 'Current: $currentVersion\nNew: $newVersion';
  }

  @override
  String get downloadAndInstall => 'Download & Install';

  @override
  String get updateDownloading => 'Downloading update...';

  @override
  String updateDownloadProgress(int percent) {
    return 'Downloading… $percent%';
  }

  @override
  String get updateInstallPrompt =>
      'Opening installer. Allow install if prompted.';

  @override
  String updateInstallFailed(String error) {
    return 'Install failed: $error';
  }

  @override
  String get updateServerUrl => 'Update server URL';

  @override
  String get updateServerUrlHint =>
      'HTTPS URL of version.json hosted with your release APK.';

  @override
  String get updateServerUrlExample =>
      'https://example.com/nyc3-inbound/version.json';

  @override
  String get saveUpdateUrl => 'Save URL';

  @override
  String get updateUrlSaved => 'Update server URL saved';

  @override
  String get invalidUpdateUrl => 'Enter a valid HTTPS URL';
}

/// The translations for English, as used in the United States (`en_US`).
class AppLocalizationsEnUs extends AppLocalizationsEn {
  AppLocalizationsEnUs() : super('en_US');

  @override
  String get appTitle => 'Sorting';

  @override
  String get sortTab => 'Sort';

  @override
  String get manageTab => 'Manage';

  @override
  String get scanBoxCartonBarcode => 'Scan Box Carton Barcode';

  @override
  String get scanProductBarcode => 'Scan Product Barcode';

  @override
  String get readyToScan => 'Ready to scan...';

  @override
  String get slotLabel => 'Slot';

  @override
  String get quantityLabel => 'Quantity';

  @override
  String get displayQuantityOnSortScreen => 'Display Quantity on Sort Screen';

  @override
  String get totalQuantityLabel => 'Total Quantity';

  @override
  String cartonTotalQuantity(int count) {
    return 'Total quantity: $count';
  }

  @override
  String get productBarcodeLabel => 'Product Barcode';

  @override
  String get newSlotAssigned => 'New slot assigned';

  @override
  String get existingSlot => 'Existing slot';

  @override
  String get cartonOpened => 'Carton opened';

  @override
  String get invalidIbrBarcode => 'Barcode must start with IBR';

  @override
  String get activeCartonExists => 'Finish or clear the current carton first';

  @override
  String get noActiveCarton => 'No active carton';

  @override
  String get closeSlot => 'Close Slot';

  @override
  String get finishSorting => 'Finish Sorting';

  @override
  String get closeSlotTitle => 'Close slot?';

  @override
  String closeSlotContent(String slot) {
    return 'Close slot $slot? The next scan of this product will open a new slot.';
  }

  @override
  String get finishSortingTitle => 'Finish sorting?';

  @override
  String finishSortingContent(String ibr) {
    return 'Mark carton $ibr as finished?';
  }

  @override
  String errorMessage(String error) {
    return 'Error: $error';
  }

  @override
  String get searchCartons => 'Search IBR number';

  @override
  String get searchSlots => 'Barcode or slot number';

  @override
  String get noCartonsYet => 'No cartons yet';

  @override
  String get noSearchResults => 'No matching entries';

  @override
  String get clearSearch => 'Clear search';

  @override
  String get activeCarton => 'Active';

  @override
  String get finishedCarton => 'Finished';

  @override
  String get reopenCarton => 'Reopen Carton';

  @override
  String get deleteCarton => 'Delete Carton';

  @override
  String get reopenCartonTitle => 'Reopen carton?';

  @override
  String reopenCartonContent(String ibr) {
    return 'Reopen carton $ibr for sorting?';
  }

  @override
  String get deleteCartonTitle => 'Delete carton?';

  @override
  String deleteCartonContent(String ibr) {
    return 'Delete carton $ibr and all its slots?';
  }

  @override
  String get slotClosedLabel => 'Closed';

  @override
  String get undoProduct => 'Undo';

  @override
  String get deleteProduct => 'Delete';

  @override
  String get undoProductTitle => 'Undo last scan?';

  @override
  String undoProductContent(String slot) {
    return 'Decrease quantity for slot $slot by 1?';
  }

  @override
  String get deleteProductTitle => 'Delete product?';

  @override
  String deleteProductContent(String slot) {
    return 'Remove product from slot $slot and release the slot number?';
  }

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get confirm => 'Confirm';

  @override
  String get clearAllHistoryTitle => 'Clear all records?';

  @override
  String get clearAllHistoryContent =>
      'This archives all cartons to history and clears the screen. Archived data can be exported from Settings.';

  @override
  String get clearAll => 'Clear All';

  @override
  String get settings => 'Settings';

  @override
  String get advanced => 'Advanced';

  @override
  String get exportHistory => 'Export History';

  @override
  String exportHistorySuccess(String path) {
    return 'Exported to $path';
  }

  @override
  String get exportHistoryEmpty =>
      'No history to export. Use Clear All on Manage first.';

  @override
  String exportHistoryFailed(String error) {
    return 'Export failed: $error';
  }

  @override
  String get theme => 'Theme';

  @override
  String get themeSystem => 'System default';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get about => 'About';

  @override
  String get versionLabel => 'Version';

  @override
  String get authorLabel => 'Author';

  @override
  String get language => 'Language';

  @override
  String get languageEnUs => 'English (US)';

  @override
  String get languageEs419 => 'Español (Latinoamérica)';

  @override
  String get languageZhCn => '中文（简体）';

  @override
  String get languageIdId => 'Bahasa Indonesia';

  @override
  String get languageFrFr => 'Français (France)';

  @override
  String get printer => 'Printer';

  @override
  String get printerSettings => 'Printer Settings';

  @override
  String get discoverPrinters => 'Discover Printers';

  @override
  String get discoverBluetoothPrinters => 'Discover Bluetooth Printers';

  @override
  String get discoverWifiPrinters => 'Discover Wi-Fi Printers';

  @override
  String get discoveringPrinters => 'Discovering printers...';

  @override
  String get noPrinterConfigured => 'No printer configured';

  @override
  String get selectPrinter => 'Select a printer';

  @override
  String get connectionType => 'Connection type';

  @override
  String get connectionBluetooth => 'Bluetooth';

  @override
  String get connectionWifi => 'Wi-Fi';

  @override
  String get enterPrinterIp => 'Enter printer IP address';

  @override
  String get enterPrinterIpHint =>
      'Use when discovery fails. PDA and printer must be on the same Wi-Fi network.';

  @override
  String get printerIpHint => '192.168.1.50';

  @override
  String get savePrinterIp => 'Save';

  @override
  String get invalidPrinterIp =>
      'Enter a valid IPv4 address (e.g. 192.168.1.50)';

  @override
  String get testPrint => 'Test Print';

  @override
  String get printLabels => 'Print Labels';

  @override
  String get printingLabels => 'Printing labels...';

  @override
  String printProgress(int current, int total) {
    return 'Printing $current of $total';
  }

  @override
  String printSuccess(int count) {
    return 'Printed $count labels';
  }

  @override
  String printFailed(String error) {
    return 'Print failed: $error';
  }

  @override
  String get printFailedRetryHint => 'Use Manage → Print to try again';

  @override
  String get noSlotsToPrint => 'No slots to print';

  @override
  String get printerNotReady => 'Printer is not ready';

  @override
  String get bluetoothPermissionRequired =>
      'Bluetooth permissions are required for printing';

  @override
  String get cartonBarcodeLabel => 'Carton Barcode';

  @override
  String get printerSetupHelp =>
      'Configure your ZQ521 with the Zebra Printer Setup app. Use Bluetooth Classic for Bluetooth printing, or join the printer to your Wi-Fi network and use Discover Wi-Fi or enter its IP address.';

  @override
  String printerSaved(String name) {
    return 'Printer saved: $name';
  }

  @override
  String get noPrintersFound => 'No printers found';

  @override
  String get checkForUpdate => 'Check for Update';

  @override
  String get checkForUpdateSubtitle =>
      'Download the latest APK from your update server';

  @override
  String get updateUpToDate => 'You are on the latest version';

  @override
  String get updateUrlNotConfigured =>
      'Set the update server URL in Advanced settings first';

  @override
  String updateCheckFailed(String error) {
    return 'Update check failed: $error';
  }

  @override
  String get updateAvailableTitle => 'Update available';

  @override
  String updateAvailableContent(String currentVersion, String newVersion) {
    return 'Current: $currentVersion\nNew: $newVersion';
  }

  @override
  String get downloadAndInstall => 'Download & Install';

  @override
  String get updateDownloading => 'Downloading update...';

  @override
  String updateDownloadProgress(int percent) {
    return 'Downloading… $percent%';
  }

  @override
  String get updateInstallPrompt =>
      'Opening installer. Allow install if prompted.';

  @override
  String updateInstallFailed(String error) {
    return 'Install failed: $error';
  }

  @override
  String get updateServerUrl => 'Update server URL';

  @override
  String get updateServerUrlHint =>
      'HTTPS URL of version.json hosted with your release APK.';

  @override
  String get updateServerUrlExample =>
      'https://example.com/nyc3-inbound/version.json';

  @override
  String get saveUpdateUrl => 'Save URL';

  @override
  String get updateUrlSaved => 'Update server URL saved';

  @override
  String get invalidUpdateUrl => 'Enter a valid HTTPS URL';
}
