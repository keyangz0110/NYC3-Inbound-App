// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Clasificación';

  @override
  String get sortTab => 'Clasificar';

  @override
  String get manageTab => 'Administrar';

  @override
  String get scanBoxCartonBarcode => 'Escanear código de caja';

  @override
  String get scanProductBarcode => 'Escanear código de producto';

  @override
  String get readyToScan => 'Listo para escanear...';

  @override
  String get slotLabel => 'Ranura';

  @override
  String get quantityLabel => 'Cantidad';

  @override
  String get displayQuantityOnSortScreen =>
      'Mostrar cantidad en pantalla Clasificar';

  @override
  String get totalQuantityLabel => 'Cantidad total';

  @override
  String cartonTotalQuantity(int count) {
    return 'Cantidad total: $count';
  }

  @override
  String get productBarcodeLabel => 'Código de producto';

  @override
  String get newSlotAssigned => 'Nueva ranura asignada';

  @override
  String get existingSlot => 'Ranura existente';

  @override
  String get cartonOpened => 'Caja abierta';

  @override
  String get invalidIbrBarcode => 'El código debe comenzar con IBR';

  @override
  String get activeCartonExists => 'Termine o borre la caja actual primero';

  @override
  String get noActiveCarton => 'No hay caja activa';

  @override
  String get closeSlot => 'Cerrar ranura';

  @override
  String get finishSorting => 'Terminar clasificación';

  @override
  String get closeSlotTitle => '¿Cerrar ranura?';

  @override
  String closeSlotContent(String slot) {
    return '¿Cerrar ranura $slot? El próximo escaneo de este producto abrirá una nueva ranura.';
  }

  @override
  String get finishSortingTitle => '¿Terminar clasificación?';

  @override
  String finishSortingContent(String ibr) {
    return '¿Marcar caja $ibr como terminada?';
  }

  @override
  String errorMessage(String error) {
    return 'Error: $error';
  }

  @override
  String get searchCartons => 'Buscar número IBR';

  @override
  String get searchSlots => 'Código o número de ranura';

  @override
  String get noCartonsYet => 'Aún no hay cajas';

  @override
  String get noSearchResults => 'Sin resultados';

  @override
  String get clearSearch => 'Borrar búsqueda';

  @override
  String get activeCarton => 'Activa';

  @override
  String get finishedCarton => 'Terminada';

  @override
  String get reopenCarton => 'Reabrir caja';

  @override
  String get deleteCarton => 'Eliminar caja';

  @override
  String get reopenCartonTitle => '¿Reabrir caja?';

  @override
  String reopenCartonContent(String ibr) {
    return '¿Reabrir caja $ibr para clasificar?';
  }

  @override
  String get deleteCartonTitle => '¿Eliminar caja?';

  @override
  String deleteCartonContent(String ibr) {
    return '¿Eliminar caja $ibr y todas sus ranuras?';
  }

  @override
  String get slotClosedLabel => 'Cerrada';

  @override
  String get undoProduct => 'Deshacer';

  @override
  String get deleteProduct => 'Eliminar';

  @override
  String get undoProductTitle => '¿Deshacer último escaneo?';

  @override
  String undoProductContent(String slot) {
    return '¿Reducir cantidad de ranura $slot en 1?';
  }

  @override
  String get deleteProductTitle => '¿Eliminar producto?';

  @override
  String deleteProductContent(String slot) {
    return '¿Quitar producto de ranura $slot y liberar el número?';
  }

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Eliminar';

  @override
  String get confirm => 'Confirmar';

  @override
  String get clearAllHistoryTitle => '¿Borrar todos los registros?';

  @override
  String get clearAllHistoryContent =>
      'Esto archiva todas las cajas en el historial y limpia la pantalla. Los datos archivados se pueden exportar desde Ajustes.';

  @override
  String get clearAll => 'Borrar todo';

  @override
  String get settings => 'Ajustes';

  @override
  String get advanced => 'Avanzado';

  @override
  String get exportHistory => 'Exportar historial';

  @override
  String exportHistorySuccess(String path) {
    return 'Exportado a $path';
  }

  @override
  String get exportHistoryEmpty =>
      'No hay historial para exportar. Use Borrar todo en Administrar primero.';

  @override
  String exportHistoryFailed(String error) {
    return 'Error al exportar: $error';
  }

  @override
  String get theme => 'Tema';

  @override
  String get themeSystem => 'Predeterminado del sistema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get about => 'Acerca de';

  @override
  String get versionLabel => 'Versión';

  @override
  String get authorLabel => 'Autor';

  @override
  String get language => 'Idioma';

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
  String get printer => 'Impresora';

  @override
  String get printerSettings => 'Configuración de impresora';

  @override
  String get discoverPrinters => 'Buscar impresoras';

  @override
  String get discoverBluetoothPrinters => 'Buscar impresoras Bluetooth';

  @override
  String get discoverWifiPrinters => 'Buscar impresoras Wi-Fi';

  @override
  String get discoveringPrinters => 'Buscando impresoras...';

  @override
  String get noPrinterConfigured => 'No hay impresora configurada';

  @override
  String get selectPrinter => 'Seleccionar impresora';

  @override
  String get connectionType => 'Tipo de conexión';

  @override
  String get connectionBluetooth => 'Bluetooth';

  @override
  String get connectionWifi => 'Wi-Fi';

  @override
  String get enterPrinterIp => 'Ingresar dirección IP de la impresora';

  @override
  String get enterPrinterIpHint =>
      'Úselo si la búsqueda falla. La PDA y la impresora deben estar en la misma red Wi-Fi.';

  @override
  String get printerIpHint => '192.168.1.50';

  @override
  String get savePrinterIp => 'Guardar';

  @override
  String get invalidPrinterIp =>
      'Ingrese una dirección IPv4 válida (p. ej. 192.168.1.50)';

  @override
  String get testPrint => 'Impresión de prueba';

  @override
  String get printLabels => 'Imprimir etiquetas';

  @override
  String get printingLabels => 'Imprimiendo etiquetas...';

  @override
  String printProgress(int current, int total) {
    return 'Imprimiendo $current de $total';
  }

  @override
  String printSuccess(int count) {
    return 'Se imprimieron $count etiquetas';
  }

  @override
  String printFailed(String error) {
    return 'Error de impresión: $error';
  }

  @override
  String get printFailedRetryHint =>
      'Use Administrar → Imprimir para reintentar';

  @override
  String get noSlotsToPrint => 'No hay ranuras para imprimir';

  @override
  String get printerNotReady => 'La impresora no está lista';

  @override
  String get bluetoothPermissionRequired =>
      'Se requieren permisos de Bluetooth para imprimir';

  @override
  String get cartonBarcodeLabel => 'Código de cartón';

  @override
  String get printerSetupHelp =>
      'Configure su ZQ521 con la app Zebra Printer Setup. Use Bluetooth Classic para Bluetooth, o únala a su Wi-Fi y use Buscar Wi-Fi o ingrese su dirección IP.';

  @override
  String printerSaved(String name) {
    return 'Impresora guardada: $name';
  }

  @override
  String get noPrintersFound => 'No se encontraron impresoras';

  @override
  String get checkForUpdate => 'Buscar actualización';

  @override
  String get checkForUpdateSubtitle =>
      'Descargar el APK más reciente desde su servidor';

  @override
  String get updateUpToDate => 'Ya tiene la versión más reciente';

  @override
  String get updateUrlNotConfigured =>
      'Configure primero la URL del servidor en Avanzado';

  @override
  String updateCheckFailed(String error) {
    return 'Error al buscar actualización: $error';
  }

  @override
  String get updateAvailableTitle => 'Actualización disponible';

  @override
  String updateAvailableContent(String currentVersion, String newVersion) {
    return 'Actual: $currentVersion\nNueva: $newVersion';
  }

  @override
  String get downloadAndInstall => 'Descargar e instalar';

  @override
  String get updateDownloading => 'Descargando actualización...';

  @override
  String updateDownloadProgress(int percent) {
    return 'Descargando… $percent%';
  }

  @override
  String get updateInstallPrompt =>
      'Abriendo el instalador. Permita la instalación si se solicita.';

  @override
  String updateInstallFailed(String error) {
    return 'Error de instalación: $error';
  }

  @override
  String get updateServerUrl => 'URL del servidor de actualizaciones';

  @override
  String get updateServerUrlHint =>
      'URL HTTPS de version.json junto con su APK de lanzamiento.';

  @override
  String get updateServerUrlExample =>
      'https://example.com/nyc3-inbound/version.json';

  @override
  String get saveUpdateUrl => 'Guardar URL';

  @override
  String get updateUrlSaved => 'URL del servidor guardada';

  @override
  String get invalidUpdateUrl => 'Ingrese una URL HTTPS válida';
}

/// The translations for Spanish Castilian, as used in Latin America and the Caribbean (`es_419`).
class AppLocalizationsEs419 extends AppLocalizationsEs {
  AppLocalizationsEs419() : super('es_419');

  @override
  String get appTitle => 'Clasificación';

  @override
  String get sortTab => 'Clasificar';

  @override
  String get manageTab => 'Administrar';

  @override
  String get scanBoxCartonBarcode => 'Escanear código de caja';

  @override
  String get scanProductBarcode => 'Escanear código de producto';

  @override
  String get readyToScan => 'Listo para escanear...';

  @override
  String get slotLabel => 'Ranura';

  @override
  String get quantityLabel => 'Cantidad';

  @override
  String get displayQuantityOnSortScreen =>
      'Mostrar cantidad en pantalla Clasificar';

  @override
  String get totalQuantityLabel => 'Cantidad total';

  @override
  String cartonTotalQuantity(int count) {
    return 'Cantidad total: $count';
  }

  @override
  String get productBarcodeLabel => 'Código de producto';

  @override
  String get newSlotAssigned => 'Nueva ranura asignada';

  @override
  String get existingSlot => 'Ranura existente';

  @override
  String get cartonOpened => 'Caja abierta';

  @override
  String get invalidIbrBarcode => 'El código debe comenzar con IBR';

  @override
  String get activeCartonExists => 'Termine o borre la caja actual primero';

  @override
  String get noActiveCarton => 'No hay caja activa';

  @override
  String get closeSlot => 'Cerrar ranura';

  @override
  String get finishSorting => 'Terminar clasificación';

  @override
  String get closeSlotTitle => '¿Cerrar ranura?';

  @override
  String closeSlotContent(String slot) {
    return '¿Cerrar ranura $slot? El próximo escaneo de este producto abrirá una nueva ranura.';
  }

  @override
  String get finishSortingTitle => '¿Terminar clasificación?';

  @override
  String finishSortingContent(String ibr) {
    return '¿Marcar caja $ibr como terminada?';
  }

  @override
  String errorMessage(String error) {
    return 'Error: $error';
  }

  @override
  String get searchCartons => 'Buscar número IBR';

  @override
  String get searchSlots => 'Código o número de ranura';

  @override
  String get noCartonsYet => 'Aún no hay cajas';

  @override
  String get noSearchResults => 'Sin resultados';

  @override
  String get clearSearch => 'Borrar búsqueda';

  @override
  String get activeCarton => 'Activa';

  @override
  String get finishedCarton => 'Terminada';

  @override
  String get reopenCarton => 'Reabrir caja';

  @override
  String get deleteCarton => 'Eliminar caja';

  @override
  String get reopenCartonTitle => '¿Reabrir caja?';

  @override
  String reopenCartonContent(String ibr) {
    return '¿Reabrir caja $ibr para clasificar?';
  }

  @override
  String get deleteCartonTitle => '¿Eliminar caja?';

  @override
  String deleteCartonContent(String ibr) {
    return '¿Eliminar caja $ibr y todas sus ranuras?';
  }

  @override
  String get slotClosedLabel => 'Cerrada';

  @override
  String get undoProduct => 'Deshacer';

  @override
  String get deleteProduct => 'Eliminar';

  @override
  String get undoProductTitle => '¿Deshacer último escaneo?';

  @override
  String undoProductContent(String slot) {
    return '¿Reducir cantidad de ranura $slot en 1?';
  }

  @override
  String get deleteProductTitle => '¿Eliminar producto?';

  @override
  String deleteProductContent(String slot) {
    return '¿Quitar producto de ranura $slot y liberar el número?';
  }

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Eliminar';

  @override
  String get confirm => 'Confirmar';

  @override
  String get clearAllHistoryTitle => '¿Borrar todos los registros?';

  @override
  String get clearAllHistoryContent =>
      'Esto archiva todas las cajas en el historial y limpia la pantalla. Los datos archivados se pueden exportar desde Ajustes.';

  @override
  String get clearAll => 'Borrar todo';

  @override
  String get settings => 'Ajustes';

  @override
  String get advanced => 'Avanzado';

  @override
  String get exportHistory => 'Exportar historial';

  @override
  String exportHistorySuccess(String path) {
    return 'Exportado a $path';
  }

  @override
  String get exportHistoryEmpty =>
      'No hay historial para exportar. Use Borrar todo en Administrar primero.';

  @override
  String exportHistoryFailed(String error) {
    return 'Error al exportar: $error';
  }

  @override
  String get theme => 'Tema';

  @override
  String get themeSystem => 'Predeterminado del sistema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get about => 'Acerca de';

  @override
  String get versionLabel => 'Versión';

  @override
  String get authorLabel => 'Autor';

  @override
  String get language => 'Idioma';

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
  String get printer => 'Impresora';

  @override
  String get printerSettings => 'Configuración de impresora';

  @override
  String get discoverPrinters => 'Buscar impresoras';

  @override
  String get discoverBluetoothPrinters => 'Buscar impresoras Bluetooth';

  @override
  String get discoverWifiPrinters => 'Buscar impresoras Wi-Fi';

  @override
  String get discoveringPrinters => 'Buscando impresoras...';

  @override
  String get noPrinterConfigured => 'No hay impresora configurada';

  @override
  String get selectPrinter => 'Seleccionar impresora';

  @override
  String get connectionType => 'Tipo de conexión';

  @override
  String get connectionBluetooth => 'Bluetooth';

  @override
  String get connectionWifi => 'Wi-Fi';

  @override
  String get enterPrinterIp => 'Ingresar dirección IP de la impresora';

  @override
  String get enterPrinterIpHint =>
      'Úselo si la búsqueda falla. La PDA y la impresora deben estar en la misma red Wi-Fi.';

  @override
  String get printerIpHint => '192.168.1.50';

  @override
  String get savePrinterIp => 'Guardar';

  @override
  String get invalidPrinterIp =>
      'Ingrese una dirección IPv4 válida (p. ej. 192.168.1.50)';

  @override
  String get testPrint => 'Impresión de prueba';

  @override
  String get printLabels => 'Imprimir etiquetas';

  @override
  String get printingLabels => 'Imprimiendo etiquetas...';

  @override
  String printProgress(int current, int total) {
    return 'Imprimiendo $current de $total';
  }

  @override
  String printSuccess(int count) {
    return 'Se imprimieron $count etiquetas';
  }

  @override
  String printFailed(String error) {
    return 'Error de impresión: $error';
  }

  @override
  String get printFailedRetryHint =>
      'Use Administrar → Imprimir para reintentar';

  @override
  String get noSlotsToPrint => 'No hay ranuras para imprimir';

  @override
  String get printerNotReady => 'La impresora no está lista';

  @override
  String get bluetoothPermissionRequired =>
      'Se requieren permisos de Bluetooth para imprimir';

  @override
  String get cartonBarcodeLabel => 'Código de cartón';

  @override
  String get printerSetupHelp =>
      'Configure su ZQ521 con la app Zebra Printer Setup. Use Bluetooth Classic para Bluetooth, o únala a su Wi-Fi y use Buscar Wi-Fi o ingrese su dirección IP.';

  @override
  String printerSaved(String name) {
    return 'Impresora guardada: $name';
  }

  @override
  String get noPrintersFound => 'No se encontraron impresoras';

  @override
  String get checkForUpdate => 'Buscar actualización';

  @override
  String get checkForUpdateSubtitle =>
      'Descargar el APK más reciente desde su servidor';

  @override
  String get updateUpToDate => 'Ya tiene la versión más reciente';

  @override
  String get updateUrlNotConfigured =>
      'Configure primero la URL del servidor en Avanzado';

  @override
  String updateCheckFailed(String error) {
    return 'Error al buscar actualización: $error';
  }

  @override
  String get updateAvailableTitle => 'Actualización disponible';

  @override
  String updateAvailableContent(String currentVersion, String newVersion) {
    return 'Actual: $currentVersion\nNueva: $newVersion';
  }

  @override
  String get downloadAndInstall => 'Descargar e instalar';

  @override
  String get updateDownloading => 'Descargando actualización...';

  @override
  String updateDownloadProgress(int percent) {
    return 'Descargando… $percent%';
  }

  @override
  String get updateInstallPrompt =>
      'Abriendo el instalador. Permita la instalación si se solicita.';

  @override
  String updateInstallFailed(String error) {
    return 'Error de instalación: $error';
  }

  @override
  String get updateServerUrl => 'URL del servidor de actualizaciones';

  @override
  String get updateServerUrlHint =>
      'URL HTTPS de version.json junto con su APK de lanzamiento.';

  @override
  String get updateServerUrlExample =>
      'https://example.com/nyc3-inbound/version.json';

  @override
  String get saveUpdateUrl => 'Guardar URL';

  @override
  String get updateUrlSaved => 'URL del servidor guardada';

  @override
  String get invalidUpdateUrl => 'Ingrese una URL HTTPS válida';
}
