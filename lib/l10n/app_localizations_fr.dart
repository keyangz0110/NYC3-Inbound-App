// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Tri';

  @override
  String get sortTab => 'Trier';

  @override
  String get manageTab => 'Gérer';

  @override
  String get scanBoxCartonBarcode => 'Scanner le code carton';

  @override
  String get scanProductBarcode => 'Scanner le code produit';

  @override
  String get readyToScan => 'Prêt à scanner...';

  @override
  String get slotLabel => 'Emplacement';

  @override
  String get quantityLabel => 'Quantité';

  @override
  String get displayQuantityOnSortScreen =>
      'Afficher la quantité sur l\'écran Trier';

  @override
  String get totalQuantityLabel => 'Quantité totale';

  @override
  String cartonTotalQuantity(int count) {
    return 'Quantité totale : $count';
  }

  @override
  String get productBarcodeLabel => 'Code produit';

  @override
  String get newSlotAssigned => 'Nouvel emplacement attribué';

  @override
  String get existingSlot => 'Emplacement existant';

  @override
  String get cartonOpened => 'Carton ouvert';

  @override
  String get invalidIbrBarcode => 'Le code doit commencer par IBR';

  @override
  String get activeCartonExists =>
      'Terminez ou effacez le carton actuel d\'abord';

  @override
  String get noActiveCarton => 'Aucun carton actif';

  @override
  String get closeSlot => 'Fermer l\'emplacement';

  @override
  String get finishSorting => 'Terminer le tri';

  @override
  String get closeSlotTitle => 'Fermer l\'emplacement ?';

  @override
  String closeSlotContent(String slot) {
    return 'Fermer l\'emplacement $slot ? Le prochain scan de ce produit ouvrira un nouvel emplacement.';
  }

  @override
  String get finishSortingTitle => 'Terminer le tri ?';

  @override
  String finishSortingContent(String ibr) {
    return 'Marquer le carton $ibr comme terminé ?';
  }

  @override
  String errorMessage(String error) {
    return 'Erreur : $error';
  }

  @override
  String get searchCartons => 'Rechercher numéro IBR';

  @override
  String get searchSlots => 'Code ou numéro d\'emplacement';

  @override
  String get noCartonsYet => 'Aucun carton pour l\'instant';

  @override
  String get noSearchResults => 'Aucun résultat';

  @override
  String get clearSearch => 'Effacer la recherche';

  @override
  String get activeCarton => 'Actif';

  @override
  String get finishedCarton => 'Terminé';

  @override
  String get reopenCarton => 'Rouvrir le carton';

  @override
  String get deleteCarton => 'Supprimer le carton';

  @override
  String get reopenCartonTitle => 'Rouvrir le carton ?';

  @override
  String reopenCartonContent(String ibr) {
    return 'Rouvrir le carton $ibr pour le tri ?';
  }

  @override
  String get deleteCartonTitle => 'Supprimer le carton ?';

  @override
  String deleteCartonContent(String ibr) {
    return 'Supprimer le carton $ibr et tous ses emplacements ?';
  }

  @override
  String get slotClosedLabel => 'Fermé';

  @override
  String get undoProduct => 'Annuler';

  @override
  String get deleteProduct => 'Supprimer';

  @override
  String get undoProductTitle => 'Annuler le dernier scan ?';

  @override
  String undoProductContent(String slot) {
    return 'Réduire la quantité de l\'emplacement $slot de 1 ?';
  }

  @override
  String get deleteProductTitle => 'Supprimer le produit ?';

  @override
  String deleteProductContent(String slot) {
    return 'Retirer le produit de l\'emplacement $slot et libérer le numéro ?';
  }

  @override
  String get cancel => 'Annuler';

  @override
  String get delete => 'Supprimer';

  @override
  String get confirm => 'Confirmer';

  @override
  String get clearAllHistoryTitle => 'Effacer tous les enregistrements ?';

  @override
  String get clearAllHistoryContent =>
      'Cela archive tous les cartons dans l\'historique et efface l\'écran. Les données archivées peuvent être exportées depuis les paramètres.';

  @override
  String get clearAll => 'Tout effacer';

  @override
  String get settings => 'Paramètres';

  @override
  String get advanced => 'Avancé';

  @override
  String get exportHistory => 'Exporter l\'historique';

  @override
  String exportHistorySuccess(String path) {
    return 'Exporté vers $path';
  }

  @override
  String get exportHistoryEmpty =>
      'Aucun historique à exporter. Utilisez Tout effacer dans Gérer d\'abord.';

  @override
  String exportHistoryFailed(String error) {
    return 'Échec de l\'export : $error';
  }

  @override
  String get theme => 'Thème';

  @override
  String get themeSystem => 'Par défaut du système';

  @override
  String get themeLight => 'Clair';

  @override
  String get themeDark => 'Sombre';

  @override
  String get about => 'À propos';

  @override
  String get versionLabel => 'Version';

  @override
  String get authorLabel => 'Auteur';

  @override
  String get language => 'Langue';

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
  String get printer => 'Imprimante';

  @override
  String get printerSettings => 'Paramètres de l\'imprimante';

  @override
  String get discoverPrinters => 'Rechercher des imprimantes';

  @override
  String get discoverBluetoothPrinters =>
      'Rechercher des imprimantes Bluetooth';

  @override
  String get discoverWifiPrinters => 'Rechercher des imprimantes Wi-Fi';

  @override
  String get discoveringPrinters => 'Recherche d\'imprimantes...';

  @override
  String get noPrinterConfigured => 'Aucune imprimante configurée';

  @override
  String get selectPrinter => 'Sélectionner une imprimante';

  @override
  String get connectionType => 'Type de connexion';

  @override
  String get connectionBluetooth => 'Bluetooth';

  @override
  String get connectionWifi => 'Wi-Fi';

  @override
  String get enterPrinterIp => 'Saisir l\'adresse IP de l\'imprimante';

  @override
  String get enterPrinterIpHint =>
      'À utiliser si la recherche échoue. La PDA et l\'imprimante doivent être sur le même réseau Wi-Fi.';

  @override
  String get printerIpHint => '192.168.1.50';

  @override
  String get savePrinterIp => 'Enregistrer';

  @override
  String get invalidPrinterIp =>
      'Saisissez une adresse IPv4 valide (ex. 192.168.1.50)';

  @override
  String get testPrint => 'Impression test';

  @override
  String get printLabels => 'Imprimer les étiquettes';

  @override
  String get printingLabels => 'Impression des étiquettes...';

  @override
  String printProgress(int current, int total) {
    return 'Impression $current sur $total';
  }

  @override
  String printSuccess(int count) {
    return '$count étiquettes imprimées';
  }

  @override
  String printFailed(String error) {
    return 'Échec de l\'impression : $error';
  }

  @override
  String get printFailedRetryHint => 'Utilisez Gérer → Imprimer pour réessayer';

  @override
  String get noSlotsToPrint => 'Aucune ranure à imprimer';

  @override
  String get printerNotReady => 'L\'imprimante n\'est pas prête';

  @override
  String get bluetoothPermissionRequired =>
      'Les autorisations Bluetooth sont requises pour imprimer';

  @override
  String get cartonBarcodeLabel => 'Code-barres du carton';

  @override
  String get printerSetupHelp =>
      'Configurez votre ZQ521 avec l\'application Zebra Printer Setup. Utilisez Bluetooth Classic pour le Bluetooth, ou connectez l\'imprimante au Wi-Fi puis utilisez Rechercher Wi-Fi ou saisissez son adresse IP.';

  @override
  String printerSaved(String name) {
    return 'Imprimante enregistrée : $name';
  }

  @override
  String get noPrintersFound => 'Aucune imprimante trouvée';

  @override
  String get checkForUpdate => 'Rechercher une mise à jour';

  @override
  String get checkForUpdateSubtitle =>
      'Télécharger le dernier APK depuis votre serveur';

  @override
  String get updateUpToDate => 'Vous avez la dernière version';

  @override
  String get updateUrlNotConfigured =>
      'Définissez d\'abord l\'URL du serveur dans Avancé';

  @override
  String updateCheckFailed(String error) {
    return 'Échec de la vérification : $error';
  }

  @override
  String get updateAvailableTitle => 'Mise à jour disponible';

  @override
  String updateAvailableContent(String currentVersion, String newVersion) {
    return 'Actuelle : $currentVersion\nNouvelle : $newVersion';
  }

  @override
  String get downloadAndInstall => 'Télécharger et installer';

  @override
  String get updateDownloading => 'Téléchargement de la mise à jour...';

  @override
  String updateDownloadProgress(int percent) {
    return 'Téléchargement… $percent%';
  }

  @override
  String get updateInstallPrompt =>
      'Ouverture de l\'installateur. Autorisez l\'installation si demandé.';

  @override
  String updateInstallFailed(String error) {
    return 'Échec de l\'installation : $error';
  }

  @override
  String get updateServerUrl => 'URL du serveur de mise à jour';

  @override
  String get updateServerUrlHint =>
      'URL HTTPS de version.json hébergé avec votre APK.';

  @override
  String get updateServerUrlExample =>
      'https://example.com/nyc3-inbound/version.json';

  @override
  String get saveUpdateUrl => 'Enregistrer l\'URL';

  @override
  String get updateUrlSaved => 'URL du serveur enregistrée';

  @override
  String get invalidUpdateUrl => 'Saisissez une URL HTTPS valide';
}

/// The translations for French, as used in France (`fr_FR`).
class AppLocalizationsFrFr extends AppLocalizationsFr {
  AppLocalizationsFrFr() : super('fr_FR');

  @override
  String get appTitle => 'Tri';

  @override
  String get sortTab => 'Trier';

  @override
  String get manageTab => 'Gérer';

  @override
  String get scanBoxCartonBarcode => 'Scanner le code carton';

  @override
  String get scanProductBarcode => 'Scanner le code produit';

  @override
  String get readyToScan => 'Prêt à scanner...';

  @override
  String get slotLabel => 'Emplacement';

  @override
  String get quantityLabel => 'Quantité';

  @override
  String get displayQuantityOnSortScreen =>
      'Afficher la quantité sur l\'écran Trier';

  @override
  String get totalQuantityLabel => 'Quantité totale';

  @override
  String cartonTotalQuantity(int count) {
    return 'Quantité totale : $count';
  }

  @override
  String get productBarcodeLabel => 'Code produit';

  @override
  String get newSlotAssigned => 'Nouvel emplacement attribué';

  @override
  String get existingSlot => 'Emplacement existant';

  @override
  String get cartonOpened => 'Carton ouvert';

  @override
  String get invalidIbrBarcode => 'Le code doit commencer par IBR';

  @override
  String get activeCartonExists =>
      'Terminez ou effacez le carton actuel d\'abord';

  @override
  String get noActiveCarton => 'Aucun carton actif';

  @override
  String get closeSlot => 'Fermer l\'emplacement';

  @override
  String get finishSorting => 'Terminer le tri';

  @override
  String get closeSlotTitle => 'Fermer l\'emplacement ?';

  @override
  String closeSlotContent(String slot) {
    return 'Fermer l\'emplacement $slot ? Le prochain scan de ce produit ouvrira un nouvel emplacement.';
  }

  @override
  String get finishSortingTitle => 'Terminer le tri ?';

  @override
  String finishSortingContent(String ibr) {
    return 'Marquer le carton $ibr comme terminé ?';
  }

  @override
  String errorMessage(String error) {
    return 'Erreur : $error';
  }

  @override
  String get searchCartons => 'Rechercher numéro IBR';

  @override
  String get searchSlots => 'Code ou numéro d\'emplacement';

  @override
  String get noCartonsYet => 'Aucun carton pour l\'instant';

  @override
  String get noSearchResults => 'Aucun résultat';

  @override
  String get clearSearch => 'Effacer la recherche';

  @override
  String get activeCarton => 'Actif';

  @override
  String get finishedCarton => 'Terminé';

  @override
  String get reopenCarton => 'Rouvrir le carton';

  @override
  String get deleteCarton => 'Supprimer le carton';

  @override
  String get reopenCartonTitle => 'Rouvrir le carton ?';

  @override
  String reopenCartonContent(String ibr) {
    return 'Rouvrir le carton $ibr pour le tri ?';
  }

  @override
  String get deleteCartonTitle => 'Supprimer le carton ?';

  @override
  String deleteCartonContent(String ibr) {
    return 'Supprimer le carton $ibr et tous ses emplacements ?';
  }

  @override
  String get slotClosedLabel => 'Fermé';

  @override
  String get undoProduct => 'Annuler';

  @override
  String get deleteProduct => 'Supprimer';

  @override
  String get undoProductTitle => 'Annuler le dernier scan ?';

  @override
  String undoProductContent(String slot) {
    return 'Réduire la quantité de l\'emplacement $slot de 1 ?';
  }

  @override
  String get deleteProductTitle => 'Supprimer le produit ?';

  @override
  String deleteProductContent(String slot) {
    return 'Retirer le produit de l\'emplacement $slot et libérer le numéro ?';
  }

  @override
  String get cancel => 'Annuler';

  @override
  String get delete => 'Supprimer';

  @override
  String get confirm => 'Confirmer';

  @override
  String get clearAllHistoryTitle => 'Effacer tous les enregistrements ?';

  @override
  String get clearAllHistoryContent =>
      'Cela archive tous les cartons dans l\'historique et efface l\'écran. Les données archivées peuvent être exportées depuis les paramètres.';

  @override
  String get clearAll => 'Tout effacer';

  @override
  String get settings => 'Paramètres';

  @override
  String get advanced => 'Avancé';

  @override
  String get exportHistory => 'Exporter l\'historique';

  @override
  String exportHistorySuccess(String path) {
    return 'Exporté vers $path';
  }

  @override
  String get exportHistoryEmpty =>
      'Aucun historique à exporter. Utilisez Tout effacer dans Gérer d\'abord.';

  @override
  String exportHistoryFailed(String error) {
    return 'Échec de l\'export : $error';
  }

  @override
  String get theme => 'Thème';

  @override
  String get themeSystem => 'Par défaut du système';

  @override
  String get themeLight => 'Clair';

  @override
  String get themeDark => 'Sombre';

  @override
  String get about => 'À propos';

  @override
  String get versionLabel => 'Version';

  @override
  String get authorLabel => 'Auteur';

  @override
  String get language => 'Langue';

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
  String get printer => 'Imprimante';

  @override
  String get printerSettings => 'Paramètres de l\'imprimante';

  @override
  String get discoverPrinters => 'Rechercher des imprimantes';

  @override
  String get discoverBluetoothPrinters =>
      'Rechercher des imprimantes Bluetooth';

  @override
  String get discoverWifiPrinters => 'Rechercher des imprimantes Wi-Fi';

  @override
  String get discoveringPrinters => 'Recherche d\'imprimantes...';

  @override
  String get noPrinterConfigured => 'Aucune imprimante configurée';

  @override
  String get selectPrinter => 'Sélectionner une imprimante';

  @override
  String get connectionType => 'Type de connexion';

  @override
  String get connectionBluetooth => 'Bluetooth';

  @override
  String get connectionWifi => 'Wi-Fi';

  @override
  String get enterPrinterIp => 'Saisir l\'adresse IP de l\'imprimante';

  @override
  String get enterPrinterIpHint =>
      'À utiliser si la recherche échoue. La PDA et l\'imprimante doivent être sur le même réseau Wi-Fi.';

  @override
  String get printerIpHint => '192.168.1.50';

  @override
  String get savePrinterIp => 'Enregistrer';

  @override
  String get invalidPrinterIp =>
      'Saisissez une adresse IPv4 valide (ex. 192.168.1.50)';

  @override
  String get testPrint => 'Impression test';

  @override
  String get printLabels => 'Imprimer les étiquettes';

  @override
  String get printingLabels => 'Impression des étiquettes...';

  @override
  String printProgress(int current, int total) {
    return 'Impression $current sur $total';
  }

  @override
  String printSuccess(int count) {
    return '$count étiquettes imprimées';
  }

  @override
  String printFailed(String error) {
    return 'Échec de l\'impression : $error';
  }

  @override
  String get printFailedRetryHint => 'Utilisez Gérer → Imprimer pour réessayer';

  @override
  String get noSlotsToPrint => 'Aucune ranure à imprimer';

  @override
  String get printerNotReady => 'L\'imprimante n\'est pas prête';

  @override
  String get bluetoothPermissionRequired =>
      'Les autorisations Bluetooth sont requises pour imprimer';

  @override
  String get cartonBarcodeLabel => 'Code-barres du carton';

  @override
  String get printerSetupHelp =>
      'Configurez votre ZQ521 avec l\'application Zebra Printer Setup. Utilisez Bluetooth Classic pour le Bluetooth, ou connectez l\'imprimante au Wi-Fi puis utilisez Rechercher Wi-Fi ou saisissez son adresse IP.';

  @override
  String printerSaved(String name) {
    return 'Imprimante enregistrée : $name';
  }

  @override
  String get noPrintersFound => 'Aucune imprimante trouvée';

  @override
  String get checkForUpdate => 'Rechercher une mise à jour';

  @override
  String get checkForUpdateSubtitle =>
      'Télécharger le dernier APK depuis votre serveur';

  @override
  String get updateUpToDate => 'Vous avez la dernière version';

  @override
  String get updateUrlNotConfigured =>
      'Définissez d\'abord l\'URL du serveur dans Avancé';

  @override
  String updateCheckFailed(String error) {
    return 'Échec de la vérification : $error';
  }

  @override
  String get updateAvailableTitle => 'Mise à jour disponible';

  @override
  String updateAvailableContent(String currentVersion, String newVersion) {
    return 'Actuelle : $currentVersion\nNouvelle : $newVersion';
  }

  @override
  String get downloadAndInstall => 'Télécharger et installer';

  @override
  String get updateDownloading => 'Téléchargement de la mise à jour...';

  @override
  String updateDownloadProgress(int percent) {
    return 'Téléchargement… $percent%';
  }

  @override
  String get updateInstallPrompt =>
      'Ouverture de l\'installateur. Autorisez l\'installation si demandé.';

  @override
  String updateInstallFailed(String error) {
    return 'Échec de l\'installation : $error';
  }

  @override
  String get updateServerUrl => 'URL du serveur de mise à jour';

  @override
  String get updateServerUrlHint =>
      'URL HTTPS de version.json hébergé avec votre APK.';

  @override
  String get updateServerUrlExample =>
      'https://example.com/nyc3-inbound/version.json';

  @override
  String get saveUpdateUrl => 'Enregistrer l\'URL';

  @override
  String get updateUrlSaved => 'URL du serveur enregistrée';

  @override
  String get invalidUpdateUrl => 'Saisissez une URL HTTPS valide';
}
