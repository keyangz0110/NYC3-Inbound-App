import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_id.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('en', 'US'),
    Locale('es'),
    Locale('es', '419'),
    Locale('fr'),
    Locale('fr', 'FR'),
    Locale('id'),
    Locale('id', 'ID'),
    Locale('zh'),
    Locale('zh', 'CN'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Sorting'**
  String get appTitle;

  /// No description provided for @sortTab.
  ///
  /// In en, this message translates to:
  /// **'Sort'**
  String get sortTab;

  /// No description provided for @manageTab.
  ///
  /// In en, this message translates to:
  /// **'Manage'**
  String get manageTab;

  /// No description provided for @scanBoxCartonBarcode.
  ///
  /// In en, this message translates to:
  /// **'Scan Box Carton Barcode'**
  String get scanBoxCartonBarcode;

  /// No description provided for @scanProductBarcode.
  ///
  /// In en, this message translates to:
  /// **'Scan Product Barcode'**
  String get scanProductBarcode;

  /// No description provided for @readyToScan.
  ///
  /// In en, this message translates to:
  /// **'Ready to scan...'**
  String get readyToScan;

  /// No description provided for @slotLabel.
  ///
  /// In en, this message translates to:
  /// **'Slot'**
  String get slotLabel;

  /// No description provided for @quantityLabel.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantityLabel;

  /// No description provided for @displayQuantityOnSortScreen.
  ///
  /// In en, this message translates to:
  /// **'Display Quantity on Sort Screen'**
  String get displayQuantityOnSortScreen;

  /// No description provided for @totalQuantityLabel.
  ///
  /// In en, this message translates to:
  /// **'Total Quantity'**
  String get totalQuantityLabel;

  /// No description provided for @cartonTotalQuantity.
  ///
  /// In en, this message translates to:
  /// **'Total quantity: {count}'**
  String cartonTotalQuantity(int count);

  /// No description provided for @productBarcodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Product Barcode'**
  String get productBarcodeLabel;

  /// No description provided for @newSlotAssigned.
  ///
  /// In en, this message translates to:
  /// **'New slot assigned'**
  String get newSlotAssigned;

  /// No description provided for @existingSlot.
  ///
  /// In en, this message translates to:
  /// **'Existing slot'**
  String get existingSlot;

  /// No description provided for @cartonOpened.
  ///
  /// In en, this message translates to:
  /// **'Carton opened'**
  String get cartonOpened;

  /// No description provided for @invalidIbrBarcode.
  ///
  /// In en, this message translates to:
  /// **'Barcode must start with IBR'**
  String get invalidIbrBarcode;

  /// No description provided for @activeCartonExists.
  ///
  /// In en, this message translates to:
  /// **'Finish or clear the current carton first'**
  String get activeCartonExists;

  /// No description provided for @noActiveCarton.
  ///
  /// In en, this message translates to:
  /// **'No active carton'**
  String get noActiveCarton;

  /// No description provided for @closeSlot.
  ///
  /// In en, this message translates to:
  /// **'Close Slot'**
  String get closeSlot;

  /// No description provided for @finishSorting.
  ///
  /// In en, this message translates to:
  /// **'Finish Sorting'**
  String get finishSorting;

  /// No description provided for @closeSlotTitle.
  ///
  /// In en, this message translates to:
  /// **'Close slot?'**
  String get closeSlotTitle;

  /// No description provided for @closeSlotContent.
  ///
  /// In en, this message translates to:
  /// **'Close slot {slot}? The next scan of this product will open a new slot.'**
  String closeSlotContent(String slot);

  /// No description provided for @finishSortingTitle.
  ///
  /// In en, this message translates to:
  /// **'Finish sorting?'**
  String get finishSortingTitle;

  /// No description provided for @finishSortingContent.
  ///
  /// In en, this message translates to:
  /// **'Mark carton {ibr} as finished?'**
  String finishSortingContent(String ibr);

  /// No description provided for @errorMessage.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String errorMessage(String error);

  /// No description provided for @searchCartons.
  ///
  /// In en, this message translates to:
  /// **'Search IBR number'**
  String get searchCartons;

  /// No description provided for @searchSlots.
  ///
  /// In en, this message translates to:
  /// **'Barcode or slot number'**
  String get searchSlots;

  /// No description provided for @noCartonsYet.
  ///
  /// In en, this message translates to:
  /// **'No cartons yet'**
  String get noCartonsYet;

  /// No description provided for @noSearchResults.
  ///
  /// In en, this message translates to:
  /// **'No matching entries'**
  String get noSearchResults;

  /// No description provided for @clearSearch.
  ///
  /// In en, this message translates to:
  /// **'Clear search'**
  String get clearSearch;

  /// No description provided for @activeCarton.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get activeCarton;

  /// No description provided for @finishedCarton.
  ///
  /// In en, this message translates to:
  /// **'Finished'**
  String get finishedCarton;

  /// No description provided for @reopenCarton.
  ///
  /// In en, this message translates to:
  /// **'Reopen Carton'**
  String get reopenCarton;

  /// No description provided for @deleteCarton.
  ///
  /// In en, this message translates to:
  /// **'Delete Carton'**
  String get deleteCarton;

  /// No description provided for @reopenCartonTitle.
  ///
  /// In en, this message translates to:
  /// **'Reopen carton?'**
  String get reopenCartonTitle;

  /// No description provided for @reopenCartonContent.
  ///
  /// In en, this message translates to:
  /// **'Reopen carton {ibr} for sorting?'**
  String reopenCartonContent(String ibr);

  /// No description provided for @deleteCartonTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete carton?'**
  String get deleteCartonTitle;

  /// No description provided for @deleteCartonContent.
  ///
  /// In en, this message translates to:
  /// **'Delete carton {ibr} and all its slots?'**
  String deleteCartonContent(String ibr);

  /// No description provided for @slotClosedLabel.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get slotClosedLabel;

  /// No description provided for @undoProduct.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get undoProduct;

  /// No description provided for @deleteProduct.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteProduct;

  /// No description provided for @undoProductTitle.
  ///
  /// In en, this message translates to:
  /// **'Undo last scan?'**
  String get undoProductTitle;

  /// No description provided for @undoProductContent.
  ///
  /// In en, this message translates to:
  /// **'Decrease quantity for slot {slot} by 1?'**
  String undoProductContent(String slot);

  /// No description provided for @deleteProductTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete product?'**
  String get deleteProductTitle;

  /// No description provided for @deleteProductContent.
  ///
  /// In en, this message translates to:
  /// **'Remove product from slot {slot} and release the slot number?'**
  String deleteProductContent(String slot);

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @clearAllHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Clear all records?'**
  String get clearAllHistoryTitle;

  /// No description provided for @clearAllHistoryContent.
  ///
  /// In en, this message translates to:
  /// **'This archives all cartons to history and clears the screen. Archived data can be exported from Settings.'**
  String get clearAllHistoryContent;

  /// No description provided for @clearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear All'**
  String get clearAll;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @advanced.
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get advanced;

  /// No description provided for @exportHistory.
  ///
  /// In en, this message translates to:
  /// **'Export History'**
  String get exportHistory;

  /// No description provided for @exportHistorySuccess.
  ///
  /// In en, this message translates to:
  /// **'Exported to {path}'**
  String exportHistorySuccess(String path);

  /// No description provided for @exportHistoryEmpty.
  ///
  /// In en, this message translates to:
  /// **'No history to export. Use Clear All on Manage first.'**
  String get exportHistoryEmpty;

  /// No description provided for @exportHistoryFailed.
  ///
  /// In en, this message translates to:
  /// **'Export failed: {error}'**
  String exportHistoryFailed(String error);

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @versionLabel.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get versionLabel;

  /// No description provided for @authorLabel.
  ///
  /// In en, this message translates to:
  /// **'Author'**
  String get authorLabel;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @languageEnUs.
  ///
  /// In en, this message translates to:
  /// **'English (US)'**
  String get languageEnUs;

  /// No description provided for @languageEs419.
  ///
  /// In en, this message translates to:
  /// **'Español (Latinoamérica)'**
  String get languageEs419;

  /// No description provided for @languageZhCn.
  ///
  /// In en, this message translates to:
  /// **'中文（简体）'**
  String get languageZhCn;

  /// No description provided for @languageIdId.
  ///
  /// In en, this message translates to:
  /// **'Bahasa Indonesia'**
  String get languageIdId;

  /// No description provided for @languageFrFr.
  ///
  /// In en, this message translates to:
  /// **'Français (France)'**
  String get languageFrFr;

  /// No description provided for @printer.
  ///
  /// In en, this message translates to:
  /// **'Printer'**
  String get printer;

  /// No description provided for @printerSettings.
  ///
  /// In en, this message translates to:
  /// **'Printer Settings'**
  String get printerSettings;

  /// No description provided for @discoverPrinters.
  ///
  /// In en, this message translates to:
  /// **'Discover Printers'**
  String get discoverPrinters;

  /// No description provided for @discoverBluetoothPrinters.
  ///
  /// In en, this message translates to:
  /// **'Discover Bluetooth Printers'**
  String get discoverBluetoothPrinters;

  /// No description provided for @discoverWifiPrinters.
  ///
  /// In en, this message translates to:
  /// **'Discover Wi-Fi Printers'**
  String get discoverWifiPrinters;

  /// No description provided for @discoveringPrinters.
  ///
  /// In en, this message translates to:
  /// **'Discovering printers...'**
  String get discoveringPrinters;

  /// No description provided for @noPrinterConfigured.
  ///
  /// In en, this message translates to:
  /// **'No printer configured'**
  String get noPrinterConfigured;

  /// No description provided for @selectPrinter.
  ///
  /// In en, this message translates to:
  /// **'Select a printer'**
  String get selectPrinter;

  /// No description provided for @connectionType.
  ///
  /// In en, this message translates to:
  /// **'Connection type'**
  String get connectionType;

  /// No description provided for @connectionBluetooth.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth'**
  String get connectionBluetooth;

  /// No description provided for @connectionWifi.
  ///
  /// In en, this message translates to:
  /// **'Wi-Fi'**
  String get connectionWifi;

  /// No description provided for @enterPrinterIp.
  ///
  /// In en, this message translates to:
  /// **'Enter printer IP address'**
  String get enterPrinterIp;

  /// No description provided for @enterPrinterIpHint.
  ///
  /// In en, this message translates to:
  /// **'Use when discovery fails. PDA and printer must be on the same Wi-Fi network.'**
  String get enterPrinterIpHint;

  /// No description provided for @printerIpHint.
  ///
  /// In en, this message translates to:
  /// **'192.168.1.50'**
  String get printerIpHint;

  /// No description provided for @savePrinterIp.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get savePrinterIp;

  /// No description provided for @invalidPrinterIp.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid IPv4 address (e.g. 192.168.1.50)'**
  String get invalidPrinterIp;

  /// No description provided for @testPrint.
  ///
  /// In en, this message translates to:
  /// **'Test Print'**
  String get testPrint;

  /// No description provided for @printLabels.
  ///
  /// In en, this message translates to:
  /// **'Print Labels'**
  String get printLabels;

  /// No description provided for @printingLabels.
  ///
  /// In en, this message translates to:
  /// **'Printing labels...'**
  String get printingLabels;

  /// No description provided for @printProgress.
  ///
  /// In en, this message translates to:
  /// **'Printing {current} of {total}'**
  String printProgress(int current, int total);

  /// No description provided for @printSuccess.
  ///
  /// In en, this message translates to:
  /// **'Printed {count} labels'**
  String printSuccess(int count);

  /// No description provided for @printFailed.
  ///
  /// In en, this message translates to:
  /// **'Print failed: {error}'**
  String printFailed(String error);

  /// No description provided for @printFailedRetryHint.
  ///
  /// In en, this message translates to:
  /// **'Use Manage → Print to try again'**
  String get printFailedRetryHint;

  /// No description provided for @noSlotsToPrint.
  ///
  /// In en, this message translates to:
  /// **'No slots to print'**
  String get noSlotsToPrint;

  /// No description provided for @printerNotReady.
  ///
  /// In en, this message translates to:
  /// **'Printer is not ready'**
  String get printerNotReady;

  /// No description provided for @bluetoothPermissionRequired.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth permissions are required for printing'**
  String get bluetoothPermissionRequired;

  /// No description provided for @cartonBarcodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Carton Barcode'**
  String get cartonBarcodeLabel;

  /// No description provided for @printerSetupHelp.
  ///
  /// In en, this message translates to:
  /// **'Configure your ZQ521 with the Zebra Printer Setup app. Use Bluetooth Classic for Bluetooth printing, or join the printer to your Wi-Fi network and use Discover Wi-Fi or enter its IP address.'**
  String get printerSetupHelp;

  /// No description provided for @printerSaved.
  ///
  /// In en, this message translates to:
  /// **'Printer saved: {name}'**
  String printerSaved(String name);

  /// No description provided for @noPrintersFound.
  ///
  /// In en, this message translates to:
  /// **'No printers found'**
  String get noPrintersFound;

  /// No description provided for @checkForUpdate.
  ///
  /// In en, this message translates to:
  /// **'Check for Update'**
  String get checkForUpdate;

  /// No description provided for @checkForUpdateSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Download the latest APK from your update server'**
  String get checkForUpdateSubtitle;

  /// No description provided for @updateUpToDate.
  ///
  /// In en, this message translates to:
  /// **'You are on the latest version'**
  String get updateUpToDate;

  /// No description provided for @updateUrlNotConfigured.
  ///
  /// In en, this message translates to:
  /// **'Set the update server URL in Advanced settings first'**
  String get updateUrlNotConfigured;

  /// No description provided for @updateCheckFailed.
  ///
  /// In en, this message translates to:
  /// **'Update check failed: {error}'**
  String updateCheckFailed(String error);

  /// No description provided for @updateAvailableTitle.
  ///
  /// In en, this message translates to:
  /// **'Update available'**
  String get updateAvailableTitle;

  /// No description provided for @updateAvailableContent.
  ///
  /// In en, this message translates to:
  /// **'Current: {currentVersion}\nNew: {newVersion}'**
  String updateAvailableContent(String currentVersion, String newVersion);

  /// No description provided for @downloadAndInstall.
  ///
  /// In en, this message translates to:
  /// **'Download & Install'**
  String get downloadAndInstall;

  /// No description provided for @updateDownloading.
  ///
  /// In en, this message translates to:
  /// **'Downloading update...'**
  String get updateDownloading;

  /// No description provided for @updateDownloadProgress.
  ///
  /// In en, this message translates to:
  /// **'Downloading… {percent}%'**
  String updateDownloadProgress(int percent);

  /// No description provided for @updateInstallPrompt.
  ///
  /// In en, this message translates to:
  /// **'Opening installer. Allow install if prompted.'**
  String get updateInstallPrompt;

  /// No description provided for @updateInstallFailed.
  ///
  /// In en, this message translates to:
  /// **'Install failed: {error}'**
  String updateInstallFailed(String error);

  /// No description provided for @updateServerUrl.
  ///
  /// In en, this message translates to:
  /// **'Update server URL'**
  String get updateServerUrl;

  /// No description provided for @updateServerUrlHint.
  ///
  /// In en, this message translates to:
  /// **'HTTPS URL of version.json hosted with your release APK.'**
  String get updateServerUrlHint;

  /// No description provided for @updateServerUrlExample.
  ///
  /// In en, this message translates to:
  /// **'https://example.com/nyc3-inbound/version.json'**
  String get updateServerUrlExample;

  /// No description provided for @saveUpdateUrl.
  ///
  /// In en, this message translates to:
  /// **'Save URL'**
  String get saveUpdateUrl;

  /// No description provided for @updateUrlSaved.
  ///
  /// In en, this message translates to:
  /// **'Update server URL saved'**
  String get updateUrlSaved;

  /// No description provided for @invalidUpdateUrl.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid HTTPS URL'**
  String get invalidUpdateUrl;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'fr', 'id', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'en':
      {
        switch (locale.countryCode) {
          case 'US':
            return AppLocalizationsEnUs();
        }
        break;
      }
    case 'es':
      {
        switch (locale.countryCode) {
          case '419':
            return AppLocalizationsEs419();
        }
        break;
      }
    case 'fr':
      {
        switch (locale.countryCode) {
          case 'FR':
            return AppLocalizationsFrFr();
        }
        break;
      }
    case 'id':
      {
        switch (locale.countryCode) {
          case 'ID':
            return AppLocalizationsIdId();
        }
        break;
      }
    case 'zh':
      {
        switch (locale.countryCode) {
          case 'CN':
            return AppLocalizationsZhCn();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'id':
      return AppLocalizationsId();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
