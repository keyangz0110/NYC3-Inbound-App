// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appTitle => 'Sortir';

  @override
  String get sortTab => 'Sortir';

  @override
  String get manageTab => 'Kelola';

  @override
  String get scanBoxCartonBarcode => 'Pindai barcode karton';

  @override
  String get scanProductBarcode => 'Pindai barcode produk';

  @override
  String get readyToScan => 'Siap memindai...';

  @override
  String get slotLabel => 'Slot';

  @override
  String get quantityLabel => 'Jumlah';

  @override
  String get displayQuantityOnSortScreen => 'Tampilkan jumlah di layar Sortir';

  @override
  String get totalQuantityLabel => 'Jumlah total';

  @override
  String cartonTotalQuantity(int count) {
    return 'Jumlah total: $count';
  }

  @override
  String get productBarcodeLabel => 'Barcode produk';

  @override
  String get newSlotAssigned => 'Slot baru ditetapkan';

  @override
  String get existingSlot => 'Slot sudah ada';

  @override
  String get cartonOpened => 'Karton dibuka';

  @override
  String get invalidIbrBarcode => 'Barcode harus diawali IBR';

  @override
  String get activeCartonExists =>
      'Selesaikan atau hapus karton saat ini terlebih dahulu';

  @override
  String get noActiveCarton => 'Tidak ada karton aktif';

  @override
  String get closeSlot => 'Tutup slot';

  @override
  String get finishSorting => 'Selesai sortir';

  @override
  String get closeSlotTitle => 'Tutup slot?';

  @override
  String closeSlotContent(String slot) {
    return 'Tutup slot $slot? Pemindaian produk berikutnya akan membuka slot baru.';
  }

  @override
  String get finishSortingTitle => 'Selesai sortir?';

  @override
  String finishSortingContent(String ibr) {
    return 'Tandai karton $ibr sebagai selesai?';
  }

  @override
  String errorMessage(String error) {
    return 'Kesalahan: $error';
  }

  @override
  String get searchCartons => 'Cari nomor IBR';

  @override
  String get searchSlots => 'Barcode atau nomor slot';

  @override
  String get noCartonsYet => 'Belum ada karton';

  @override
  String get noSearchResults => 'Tidak ada hasil';

  @override
  String get clearSearch => 'Hapus pencarian';

  @override
  String get activeCarton => 'Aktif';

  @override
  String get finishedCarton => 'Selesai';

  @override
  String get reopenCarton => 'Buka kembali karton';

  @override
  String get deleteCarton => 'Hapus karton';

  @override
  String get reopenCartonTitle => 'Buka kembali karton?';

  @override
  String reopenCartonContent(String ibr) {
    return 'Buka kembali karton $ibr untuk sortir?';
  }

  @override
  String get deleteCartonTitle => 'Hapus karton?';

  @override
  String deleteCartonContent(String ibr) {
    return 'Hapus karton $ibr dan semua slotnya?';
  }

  @override
  String get slotClosedLabel => 'Ditutup';

  @override
  String get undoProduct => 'Urungkan';

  @override
  String get deleteProduct => 'Hapus';

  @override
  String get undoProductTitle => 'Urungkan pemindaian terakhir?';

  @override
  String undoProductContent(String slot) {
    return 'Kurangi jumlah slot $slot sebanyak 1?';
  }

  @override
  String get deleteProductTitle => 'Hapus produk?';

  @override
  String deleteProductContent(String slot) {
    return 'Hapus produk dari slot $slot dan lepaskan nomor slot?';
  }

  @override
  String get cancel => 'Batal';

  @override
  String get delete => 'Hapus';

  @override
  String get confirm => 'Konfirmasi';

  @override
  String get clearAllHistoryTitle => 'Hapus semua catatan?';

  @override
  String get clearAllHistoryContent =>
      'Ini mengarsipkan semua karton ke riwayat dan membersihkan layar. Data arsip dapat diekspor dari Pengaturan.';

  @override
  String get clearAll => 'Hapus Semua';

  @override
  String get settings => 'Pengaturan';

  @override
  String get advanced => 'Lanjutan';

  @override
  String get exportHistory => 'Ekspor riwayat';

  @override
  String exportHistorySuccess(String path) {
    return 'Diekspor ke $path';
  }

  @override
  String get exportHistoryEmpty =>
      'Tidak ada riwayat untuk diekspor. Gunakan Hapus Semua di Kelola terlebih dahulu.';

  @override
  String exportHistoryFailed(String error) {
    return 'Ekspor gagal: $error';
  }

  @override
  String get theme => 'Tema';

  @override
  String get themeSystem => 'Default sistem';

  @override
  String get themeLight => 'Terang';

  @override
  String get themeDark => 'Gelap';

  @override
  String get about => 'Tentang';

  @override
  String get versionLabel => 'Versi';

  @override
  String get authorLabel => 'Penulis';

  @override
  String get language => 'Bahasa';

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
  String get printerSettings => 'Pengaturan Printer';

  @override
  String get discoverPrinters => 'Cari Printer';

  @override
  String get discoverBluetoothPrinters => 'Cari Printer Bluetooth';

  @override
  String get discoverWifiPrinters => 'Cari Printer Wi-Fi';

  @override
  String get discoveringPrinters => 'Mencari printer...';

  @override
  String get noPrinterConfigured => 'Printer belum dikonfigurasi';

  @override
  String get selectPrinter => 'Pilih printer';

  @override
  String get connectionType => 'Jenis koneksi';

  @override
  String get connectionBluetooth => 'Bluetooth';

  @override
  String get connectionWifi => 'Wi-Fi';

  @override
  String get enterPrinterIp => 'Masukkan alamat IP printer';

  @override
  String get enterPrinterIpHint =>
      'Gunakan jika pencarian gagal. PDA dan printer harus di jaringan Wi-Fi yang sama.';

  @override
  String get printerIpHint => '192.168.1.50';

  @override
  String get savePrinterIp => 'Simpan';

  @override
  String get invalidPrinterIp =>
      'Masukkan alamat IPv4 yang valid (mis. 192.168.1.50)';

  @override
  String get testPrint => 'Cetak Uji';

  @override
  String get printLabels => 'Cetak Label';

  @override
  String get printingLabels => 'Mencetak label...';

  @override
  String printProgress(int current, int total) {
    return 'Mencetak $current dari $total';
  }

  @override
  String printSuccess(int count) {
    return 'Berhasil mencetak $count label';
  }

  @override
  String printFailed(String error) {
    return 'Cetak gagal: $error';
  }

  @override
  String get printFailedRetryHint =>
      'Gunakan Kelola → Cetak untuk mencoba lagi';

  @override
  String get noSlotsToPrint => 'Tidak ada slot untuk dicetak';

  @override
  String get printerNotReady => 'Printer belum siap';

  @override
  String get bluetoothPermissionRequired =>
      'Izin Bluetooth diperlukan untuk mencetak';

  @override
  String get cartonBarcodeLabel => 'Barcode Karton';

  @override
  String get printerSetupHelp =>
      'Konfigurasikan ZQ521 dengan aplikasi Zebra Printer Setup. Gunakan Bluetooth Classic untuk Bluetooth, atau hubungkan printer ke Wi-Fi lalu gunakan Cari Wi-Fi atau masukkan alamat IP-nya.';

  @override
  String printerSaved(String name) {
    return 'Printer disimpan: $name';
  }

  @override
  String get noPrintersFound => 'Tidak ada printer ditemukan';

  @override
  String get checkForUpdate => 'Periksa Pembaruan';

  @override
  String get checkForUpdateSubtitle =>
      'Unduh APK terbaru dari server pembaruan';

  @override
  String get updateUpToDate => 'Anda sudah memakai versi terbaru';

  @override
  String get updateUrlNotConfigured =>
      'Atur URL server pembaruan di Advanced terlebih dahulu';

  @override
  String updateCheckFailed(String error) {
    return 'Gagal memeriksa pembaruan: $error';
  }

  @override
  String get updateAvailableTitle => 'Pembaruan tersedia';

  @override
  String updateAvailableContent(String currentVersion, String newVersion) {
    return 'Saat ini: $currentVersion\nBaru: $newVersion';
  }

  @override
  String get downloadAndInstall => 'Unduh & Instal';

  @override
  String get updateDownloading => 'Mengunduh pembaruan...';

  @override
  String updateDownloadProgress(int percent) {
    return 'Mengunduh… $percent%';
  }

  @override
  String get updateInstallPrompt =>
      'Membuka penginstal. Izinkan instal jika diminta.';

  @override
  String updateInstallFailed(String error) {
    return 'Instal gagal: $error';
  }

  @override
  String get updateServerUrl => 'URL server pembaruan';

  @override
  String get updateServerUrlHint =>
      'URL HTTPS version.json yang dihosting bersama APK rilis.';

  @override
  String get updateServerUrlExample =>
      'https://example.com/nyc3-inbound/version.json';

  @override
  String get saveUpdateUrl => 'Simpan URL';

  @override
  String get updateUrlSaved => 'URL server pembaruan disimpan';

  @override
  String get invalidUpdateUrl => 'Masukkan URL HTTPS yang valid';
}

/// The translations for Indonesian, as used in Indonesia (`id_ID`).
class AppLocalizationsIdId extends AppLocalizationsId {
  AppLocalizationsIdId() : super('id_ID');

  @override
  String get appTitle => 'Sortir';

  @override
  String get sortTab => 'Sortir';

  @override
  String get manageTab => 'Kelola';

  @override
  String get scanBoxCartonBarcode => 'Pindai barcode karton';

  @override
  String get scanProductBarcode => 'Pindai barcode produk';

  @override
  String get readyToScan => 'Siap memindai...';

  @override
  String get slotLabel => 'Slot';

  @override
  String get quantityLabel => 'Jumlah';

  @override
  String get displayQuantityOnSortScreen => 'Tampilkan jumlah di layar Sortir';

  @override
  String get totalQuantityLabel => 'Jumlah total';

  @override
  String cartonTotalQuantity(int count) {
    return 'Jumlah total: $count';
  }

  @override
  String get productBarcodeLabel => 'Barcode produk';

  @override
  String get newSlotAssigned => 'Slot baru ditetapkan';

  @override
  String get existingSlot => 'Slot sudah ada';

  @override
  String get cartonOpened => 'Karton dibuka';

  @override
  String get invalidIbrBarcode => 'Barcode harus diawali IBR';

  @override
  String get activeCartonExists =>
      'Selesaikan atau hapus karton saat ini terlebih dahulu';

  @override
  String get noActiveCarton => 'Tidak ada karton aktif';

  @override
  String get closeSlot => 'Tutup slot';

  @override
  String get finishSorting => 'Selesai sortir';

  @override
  String get closeSlotTitle => 'Tutup slot?';

  @override
  String closeSlotContent(String slot) {
    return 'Tutup slot $slot? Pemindaian produk berikutnya akan membuka slot baru.';
  }

  @override
  String get finishSortingTitle => 'Selesai sortir?';

  @override
  String finishSortingContent(String ibr) {
    return 'Tandai karton $ibr sebagai selesai?';
  }

  @override
  String errorMessage(String error) {
    return 'Kesalahan: $error';
  }

  @override
  String get searchCartons => 'Cari nomor IBR';

  @override
  String get searchSlots => 'Barcode atau nomor slot';

  @override
  String get noCartonsYet => 'Belum ada karton';

  @override
  String get noSearchResults => 'Tidak ada hasil';

  @override
  String get clearSearch => 'Hapus pencarian';

  @override
  String get activeCarton => 'Aktif';

  @override
  String get finishedCarton => 'Selesai';

  @override
  String get reopenCarton => 'Buka kembali karton';

  @override
  String get deleteCarton => 'Hapus karton';

  @override
  String get reopenCartonTitle => 'Buka kembali karton?';

  @override
  String reopenCartonContent(String ibr) {
    return 'Buka kembali karton $ibr untuk sortir?';
  }

  @override
  String get deleteCartonTitle => 'Hapus karton?';

  @override
  String deleteCartonContent(String ibr) {
    return 'Hapus karton $ibr dan semua slotnya?';
  }

  @override
  String get slotClosedLabel => 'Ditutup';

  @override
  String get undoProduct => 'Urungkan';

  @override
  String get deleteProduct => 'Hapus';

  @override
  String get undoProductTitle => 'Urungkan pemindaian terakhir?';

  @override
  String undoProductContent(String slot) {
    return 'Kurangi jumlah slot $slot sebanyak 1?';
  }

  @override
  String get deleteProductTitle => 'Hapus produk?';

  @override
  String deleteProductContent(String slot) {
    return 'Hapus produk dari slot $slot dan lepaskan nomor slot?';
  }

  @override
  String get cancel => 'Batal';

  @override
  String get delete => 'Hapus';

  @override
  String get confirm => 'Konfirmasi';

  @override
  String get clearAllHistoryTitle => 'Hapus semua catatan?';

  @override
  String get clearAllHistoryContent =>
      'Ini mengarsipkan semua karton ke riwayat dan membersihkan layar. Data arsip dapat diekspor dari Pengaturan.';

  @override
  String get clearAll => 'Hapus Semua';

  @override
  String get settings => 'Pengaturan';

  @override
  String get advanced => 'Lanjutan';

  @override
  String get exportHistory => 'Ekspor riwayat';

  @override
  String exportHistorySuccess(String path) {
    return 'Diekspor ke $path';
  }

  @override
  String get exportHistoryEmpty =>
      'Tidak ada riwayat untuk diekspor. Gunakan Hapus Semua di Kelola terlebih dahulu.';

  @override
  String exportHistoryFailed(String error) {
    return 'Ekspor gagal: $error';
  }

  @override
  String get theme => 'Tema';

  @override
  String get themeSystem => 'Default sistem';

  @override
  String get themeLight => 'Terang';

  @override
  String get themeDark => 'Gelap';

  @override
  String get about => 'Tentang';

  @override
  String get versionLabel => 'Versi';

  @override
  String get authorLabel => 'Penulis';

  @override
  String get language => 'Bahasa';

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
  String get printerSettings => 'Pengaturan Printer';

  @override
  String get discoverPrinters => 'Cari Printer';

  @override
  String get discoverBluetoothPrinters => 'Cari Printer Bluetooth';

  @override
  String get discoverWifiPrinters => 'Cari Printer Wi-Fi';

  @override
  String get discoveringPrinters => 'Mencari printer...';

  @override
  String get noPrinterConfigured => 'Printer belum dikonfigurasi';

  @override
  String get selectPrinter => 'Pilih printer';

  @override
  String get connectionType => 'Jenis koneksi';

  @override
  String get connectionBluetooth => 'Bluetooth';

  @override
  String get connectionWifi => 'Wi-Fi';

  @override
  String get enterPrinterIp => 'Masukkan alamat IP printer';

  @override
  String get enterPrinterIpHint =>
      'Gunakan jika pencarian gagal. PDA dan printer harus di jaringan Wi-Fi yang sama.';

  @override
  String get printerIpHint => '192.168.1.50';

  @override
  String get savePrinterIp => 'Simpan';

  @override
  String get invalidPrinterIp =>
      'Masukkan alamat IPv4 yang valid (mis. 192.168.1.50)';

  @override
  String get testPrint => 'Cetak Uji';

  @override
  String get printLabels => 'Cetak Label';

  @override
  String get printingLabels => 'Mencetak label...';

  @override
  String printProgress(int current, int total) {
    return 'Mencetak $current dari $total';
  }

  @override
  String printSuccess(int count) {
    return 'Berhasil mencetak $count label';
  }

  @override
  String printFailed(String error) {
    return 'Cetak gagal: $error';
  }

  @override
  String get printFailedRetryHint =>
      'Gunakan Kelola → Cetak untuk mencoba lagi';

  @override
  String get noSlotsToPrint => 'Tidak ada slot untuk dicetak';

  @override
  String get printerNotReady => 'Printer belum siap';

  @override
  String get bluetoothPermissionRequired =>
      'Izin Bluetooth diperlukan untuk mencetak';

  @override
  String get cartonBarcodeLabel => 'Barcode Karton';

  @override
  String get printerSetupHelp =>
      'Konfigurasikan ZQ521 dengan aplikasi Zebra Printer Setup. Gunakan Bluetooth Classic untuk Bluetooth, atau hubungkan printer ke Wi-Fi lalu gunakan Cari Wi-Fi atau masukkan alamat IP-nya.';

  @override
  String printerSaved(String name) {
    return 'Printer disimpan: $name';
  }

  @override
  String get noPrintersFound => 'Tidak ada printer ditemukan';

  @override
  String get checkForUpdate => 'Periksa Pembaruan';

  @override
  String get checkForUpdateSubtitle =>
      'Unduh APK terbaru dari server pembaruan';

  @override
  String get updateUpToDate => 'Anda sudah memakai versi terbaru';

  @override
  String get updateUrlNotConfigured =>
      'Atur URL server pembaruan di Advanced terlebih dahulu';

  @override
  String updateCheckFailed(String error) {
    return 'Gagal memeriksa pembaruan: $error';
  }

  @override
  String get updateAvailableTitle => 'Pembaruan tersedia';

  @override
  String updateAvailableContent(String currentVersion, String newVersion) {
    return 'Saat ini: $currentVersion\nBaru: $newVersion';
  }

  @override
  String get downloadAndInstall => 'Unduh & Instal';

  @override
  String get updateDownloading => 'Mengunduh pembaruan...';

  @override
  String updateDownloadProgress(int percent) {
    return 'Mengunduh… $percent%';
  }

  @override
  String get updateInstallPrompt =>
      'Membuka penginstal. Izinkan instal jika diminta.';

  @override
  String updateInstallFailed(String error) {
    return 'Instal gagal: $error';
  }

  @override
  String get updateServerUrl => 'URL server pembaruan';

  @override
  String get updateServerUrlHint =>
      'URL HTTPS version.json yang dihosting bersama APK rilis.';

  @override
  String get updateServerUrlExample =>
      'https://example.com/nyc3-inbound/version.json';

  @override
  String get saveUpdateUrl => 'Simpan URL';

  @override
  String get updateUrlSaved => 'URL server pembaruan disimpan';

  @override
  String get invalidUpdateUrl => 'Masukkan URL HTTPS yang valid';
}
