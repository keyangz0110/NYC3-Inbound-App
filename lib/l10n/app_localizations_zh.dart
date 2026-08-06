// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => '分拣';

  @override
  String get sortTab => '分拣';

  @override
  String get manageTab => '管理';

  @override
  String get scanBoxCartonBarcode => '扫描箱唛条码';

  @override
  String get scanProductBarcode => '扫描产品条码';

  @override
  String get readyToScan => '准备扫描...';

  @override
  String get slotLabel => '槽位';

  @override
  String get quantityLabel => '数量';

  @override
  String get displayQuantityOnSortScreen => '在分拣界面显示数量';

  @override
  String get totalQuantityLabel => '总数量';

  @override
  String cartonTotalQuantity(int count) {
    return '总数量：$count';
  }

  @override
  String get productBarcodeLabel => '产品条码';

  @override
  String get newSlotAssigned => '已分配新槽位';

  @override
  String get existingSlot => '已有槽位';

  @override
  String get cartonOpened => '箱子已打开';

  @override
  String get invalidIbrBarcode => '条码必须以 IBR 开头';

  @override
  String get activeCartonExists => '请先完成或清除当前箱子';

  @override
  String get noActiveCarton => '没有活动箱子';

  @override
  String get closeSlot => '关闭槽位';

  @override
  String get finishSorting => '完成分拣';

  @override
  String get closeSlotTitle => '关闭槽位？';

  @override
  String closeSlotContent(String slot) {
    return '关闭槽位 $slot？下次扫描此产品将打开新槽位。';
  }

  @override
  String get finishSortingTitle => '完成分拣？';

  @override
  String finishSortingContent(String ibr) {
    return '将箱子 $ibr 标记为已完成？';
  }

  @override
  String errorMessage(String error) {
    return '错误：$error';
  }

  @override
  String get searchCartons => '搜索 IBR 编号';

  @override
  String get searchSlots => '条码或槽位号';

  @override
  String get noCartonsYet => '暂无箱子';

  @override
  String get noSearchResults => '无匹配结果';

  @override
  String get clearSearch => '清除搜索';

  @override
  String get activeCarton => '进行中';

  @override
  String get finishedCarton => '已完成';

  @override
  String get reopenCarton => '重新打开箱子';

  @override
  String get deleteCarton => '删除箱子';

  @override
  String get reopenCartonTitle => '重新打开箱子？';

  @override
  String reopenCartonContent(String ibr) {
    return '重新打开箱子 $ibr 进行分拣？';
  }

  @override
  String get deleteCartonTitle => '删除箱子？';

  @override
  String deleteCartonContent(String ibr) {
    return '删除箱子 $ibr 及其所有槽位？';
  }

  @override
  String get slotClosedLabel => '已关闭';

  @override
  String get undoProduct => '撤销';

  @override
  String get deleteProduct => '删除';

  @override
  String get undoProductTitle => '撤销上次扫描？';

  @override
  String undoProductContent(String slot) {
    return '将槽位 $slot 的数量减 1？';
  }

  @override
  String get deleteProductTitle => '删除产品？';

  @override
  String deleteProductContent(String slot) {
    return '从槽位 $slot 移除产品并释放槽位号？';
  }

  @override
  String get cancel => '取消';

  @override
  String get delete => '删除';

  @override
  String get confirm => '确认';

  @override
  String get clearAllHistoryTitle => '清除所有记录？';

  @override
  String get clearAllHistoryContent => '这将把所有箱子归档到历史记录并清除屏幕。归档数据可在设置中导出。';

  @override
  String get clearAll => '全部清空';

  @override
  String get settings => '设置';

  @override
  String get advanced => '高级';

  @override
  String get exportHistory => '导出历史';

  @override
  String exportHistorySuccess(String path) {
    return '已导出到 $path';
  }

  @override
  String get exportHistoryEmpty => '没有可导出的历史记录。请先在管理中点击全部清空。';

  @override
  String exportHistoryFailed(String error) {
    return '导出失败：$error';
  }

  @override
  String get theme => '主题';

  @override
  String get themeSystem => '跟随系统';

  @override
  String get themeLight => '浅色';

  @override
  String get themeDark => '深色';

  @override
  String get about => '关于';

  @override
  String get versionLabel => '版本';

  @override
  String get authorLabel => '作者';

  @override
  String get language => '语言';

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
  String get printer => '打印机';

  @override
  String get printerSettings => '打印机设置';

  @override
  String get discoverPrinters => '搜索打印机';

  @override
  String get discoverBluetoothPrinters => '搜索蓝牙打印机';

  @override
  String get discoverWifiPrinters => '搜索 Wi-Fi 打印机';

  @override
  String get discoveringPrinters => '正在搜索打印机...';

  @override
  String get noPrinterConfigured => '未配置打印机';

  @override
  String get selectPrinter => '选择打印机';

  @override
  String get connectionType => '连接方式';

  @override
  String get connectionBluetooth => '蓝牙';

  @override
  String get connectionWifi => 'Wi-Fi';

  @override
  String get enterPrinterIp => '输入打印机 IP 地址';

  @override
  String get enterPrinterIpHint => '搜索失败时使用。PDA 与打印机须在同一 Wi-Fi 网络。';

  @override
  String get printerIpHint => '192.168.1.50';

  @override
  String get savePrinterIp => '保存';

  @override
  String get invalidPrinterIp => '请输入有效的 IPv4 地址（例如 192.168.1.50）';

  @override
  String get testPrint => '测试打印';

  @override
  String get printLabels => '打印标签';

  @override
  String get printingLabels => '正在打印标签...';

  @override
  String printProgress(int current, int total) {
    return '正在打印 $current/$total';
  }

  @override
  String printSuccess(int count) {
    return '已打印 $count 张标签';
  }

  @override
  String printFailed(String error) {
    return '打印失败：$error';
  }

  @override
  String get printFailedRetryHint => '请使用管理 → 打印重试';

  @override
  String get noSlotsToPrint => '没有可打印的槽位';

  @override
  String get printerNotReady => '打印机未就绪';

  @override
  String get bluetoothPermissionRequired => '打印需要蓝牙权限';

  @override
  String get cartonBarcodeLabel => '纸箱条码';

  @override
  String get printerSetupHelp =>
      '请使用 Zebra Printer Setup 应用配置 ZQ521。蓝牙打印请使用 Bluetooth Classic；或将打印机加入 Wi-Fi，使用“搜索 Wi-Fi”或输入其 IP 地址。';

  @override
  String printerSaved(String name) {
    return '已保存打印机：$name';
  }

  @override
  String get noPrintersFound => '未找到打印机';

  @override
  String get checkForUpdate => '检查更新';

  @override
  String get checkForUpdateSubtitle => '从更新服务器下载最新 APK';

  @override
  String get updateUpToDate => '已是最新版本';

  @override
  String get updateUrlNotConfigured => '请先在高级设置中配置更新服务器 URL';

  @override
  String updateCheckFailed(String error) {
    return '检查更新失败：$error';
  }

  @override
  String get updateAvailableTitle => '有可用更新';

  @override
  String updateAvailableContent(String currentVersion, String newVersion) {
    return '当前：$currentVersion\n新版本：$newVersion';
  }

  @override
  String get downloadAndInstall => '下载并安装';

  @override
  String get updateDownloading => '正在下载更新...';

  @override
  String updateDownloadProgress(int percent) {
    return '下载中… $percent%';
  }

  @override
  String get updateInstallPrompt => '正在打开安装程序。如有提示请允许安装。';

  @override
  String updateInstallFailed(String error) {
    return '安装失败：$error';
  }

  @override
  String get updateServerUrl => '更新服务器 URL';

  @override
  String get updateServerUrlHint => '与发布 APK 一同托管的 version.json 的 HTTPS 地址。';

  @override
  String get updateServerUrlExample =>
      'https://example.com/nyc3-inbound/version.json';

  @override
  String get saveUpdateUrl => '保存 URL';

  @override
  String get updateUrlSaved => '更新服务器 URL 已保存';

  @override
  String get invalidUpdateUrl => '请输入有效的 HTTPS URL';
}

/// The translations for Chinese, as used in China (`zh_CN`).
class AppLocalizationsZhCn extends AppLocalizationsZh {
  AppLocalizationsZhCn() : super('zh_CN');

  @override
  String get appTitle => '分拣';

  @override
  String get sortTab => '分拣';

  @override
  String get manageTab => '管理';

  @override
  String get scanBoxCartonBarcode => '扫描箱唛条码';

  @override
  String get scanProductBarcode => '扫描产品条码';

  @override
  String get readyToScan => '准备扫描...';

  @override
  String get slotLabel => '槽位';

  @override
  String get quantityLabel => '数量';

  @override
  String get displayQuantityOnSortScreen => '在分拣界面显示数量';

  @override
  String get totalQuantityLabel => '总数量';

  @override
  String cartonTotalQuantity(int count) {
    return '总数量：$count';
  }

  @override
  String get productBarcodeLabel => '产品条码';

  @override
  String get newSlotAssigned => '已分配新槽位';

  @override
  String get existingSlot => '已有槽位';

  @override
  String get cartonOpened => '箱子已打开';

  @override
  String get invalidIbrBarcode => '条码必须以 IBR 开头';

  @override
  String get activeCartonExists => '请先完成或清除当前箱子';

  @override
  String get noActiveCarton => '没有活动箱子';

  @override
  String get closeSlot => '关闭槽位';

  @override
  String get finishSorting => '完成分拣';

  @override
  String get closeSlotTitle => '关闭槽位？';

  @override
  String closeSlotContent(String slot) {
    return '关闭槽位 $slot？下次扫描此产品将打开新槽位。';
  }

  @override
  String get finishSortingTitle => '完成分拣？';

  @override
  String finishSortingContent(String ibr) {
    return '将箱子 $ibr 标记为已完成？';
  }

  @override
  String errorMessage(String error) {
    return '错误：$error';
  }

  @override
  String get searchCartons => '搜索 IBR 编号';

  @override
  String get searchSlots => '条码或槽位号';

  @override
  String get noCartonsYet => '暂无箱子';

  @override
  String get noSearchResults => '无匹配结果';

  @override
  String get clearSearch => '清除搜索';

  @override
  String get activeCarton => '进行中';

  @override
  String get finishedCarton => '已完成';

  @override
  String get reopenCarton => '重新打开箱子';

  @override
  String get deleteCarton => '删除箱子';

  @override
  String get reopenCartonTitle => '重新打开箱子？';

  @override
  String reopenCartonContent(String ibr) {
    return '重新打开箱子 $ibr 进行分拣？';
  }

  @override
  String get deleteCartonTitle => '删除箱子？';

  @override
  String deleteCartonContent(String ibr) {
    return '删除箱子 $ibr 及其所有槽位？';
  }

  @override
  String get slotClosedLabel => '已关闭';

  @override
  String get undoProduct => '撤销';

  @override
  String get deleteProduct => '删除';

  @override
  String get undoProductTitle => '撤销上次扫描？';

  @override
  String undoProductContent(String slot) {
    return '将槽位 $slot 的数量减 1？';
  }

  @override
  String get deleteProductTitle => '删除产品？';

  @override
  String deleteProductContent(String slot) {
    return '从槽位 $slot 移除产品并释放槽位号？';
  }

  @override
  String get cancel => '取消';

  @override
  String get delete => '删除';

  @override
  String get confirm => '确认';

  @override
  String get clearAllHistoryTitle => '清除所有记录？';

  @override
  String get clearAllHistoryContent => '这将把所有箱子归档到历史记录并清除屏幕。归档数据可在设置中导出。';

  @override
  String get clearAll => '全部清空';

  @override
  String get settings => '设置';

  @override
  String get advanced => '高级';

  @override
  String get exportHistory => '导出历史';

  @override
  String exportHistorySuccess(String path) {
    return '已导出到 $path';
  }

  @override
  String get exportHistoryEmpty => '没有可导出的历史记录。请先在管理中点击全部清空。';

  @override
  String exportHistoryFailed(String error) {
    return '导出失败：$error';
  }

  @override
  String get theme => '主题';

  @override
  String get themeSystem => '跟随系统';

  @override
  String get themeLight => '浅色';

  @override
  String get themeDark => '深色';

  @override
  String get about => '关于';

  @override
  String get versionLabel => '版本';

  @override
  String get authorLabel => '作者';

  @override
  String get language => '语言';

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
  String get printer => '打印机';

  @override
  String get printerSettings => '打印机设置';

  @override
  String get discoverPrinters => '搜索打印机';

  @override
  String get discoverBluetoothPrinters => '搜索蓝牙打印机';

  @override
  String get discoverWifiPrinters => '搜索 Wi-Fi 打印机';

  @override
  String get discoveringPrinters => '正在搜索打印机...';

  @override
  String get noPrinterConfigured => '未配置打印机';

  @override
  String get selectPrinter => '选择打印机';

  @override
  String get connectionType => '连接方式';

  @override
  String get connectionBluetooth => '蓝牙';

  @override
  String get connectionWifi => 'Wi-Fi';

  @override
  String get enterPrinterIp => '输入打印机 IP 地址';

  @override
  String get enterPrinterIpHint => '搜索失败时使用。PDA 与打印机须在同一 Wi-Fi 网络。';

  @override
  String get printerIpHint => '192.168.1.50';

  @override
  String get savePrinterIp => '保存';

  @override
  String get invalidPrinterIp => '请输入有效的 IPv4 地址（例如 192.168.1.50）';

  @override
  String get testPrint => '测试打印';

  @override
  String get printLabels => '打印标签';

  @override
  String get printingLabels => '正在打印标签...';

  @override
  String printProgress(int current, int total) {
    return '正在打印 $current/$total';
  }

  @override
  String printSuccess(int count) {
    return '已打印 $count 张标签';
  }

  @override
  String printFailed(String error) {
    return '打印失败：$error';
  }

  @override
  String get printFailedRetryHint => '请使用管理 → 打印重试';

  @override
  String get noSlotsToPrint => '没有可打印的槽位';

  @override
  String get printerNotReady => '打印机未就绪';

  @override
  String get bluetoothPermissionRequired => '打印需要蓝牙权限';

  @override
  String get cartonBarcodeLabel => '纸箱条码';

  @override
  String get printerSetupHelp =>
      '请使用 Zebra Printer Setup 应用配置 ZQ521。蓝牙打印请使用 Bluetooth Classic；或将打印机加入 Wi-Fi，使用“搜索 Wi-Fi”或输入其 IP 地址。';

  @override
  String printerSaved(String name) {
    return '已保存打印机：$name';
  }

  @override
  String get noPrintersFound => '未找到打印机';

  @override
  String get checkForUpdate => '检查更新';

  @override
  String get checkForUpdateSubtitle => '从更新服务器下载最新 APK';

  @override
  String get updateUpToDate => '已是最新版本';

  @override
  String get updateUrlNotConfigured => '请先在高级设置中配置更新服务器 URL';

  @override
  String updateCheckFailed(String error) {
    return '检查更新失败：$error';
  }

  @override
  String get updateAvailableTitle => '有可用更新';

  @override
  String updateAvailableContent(String currentVersion, String newVersion) {
    return '当前：$currentVersion\n新版本：$newVersion';
  }

  @override
  String get downloadAndInstall => '下载并安装';

  @override
  String get updateDownloading => '正在下载更新...';

  @override
  String updateDownloadProgress(int percent) {
    return '下载中… $percent%';
  }

  @override
  String get updateInstallPrompt => '正在打开安装程序。如有提示请允许安装。';

  @override
  String updateInstallFailed(String error) {
    return '安装失败：$error';
  }

  @override
  String get updateServerUrl => '更新服务器 URL';

  @override
  String get updateServerUrlHint => '与发布 APK 一同托管的 version.json 的 HTTPS 地址。';

  @override
  String get updateServerUrlExample =>
      'https://example.com/nyc3-inbound/version.json';

  @override
  String get saveUpdateUrl => '保存 URL';

  @override
  String get updateUrlSaved => '更新服务器 URL 已保存';

  @override
  String get invalidUpdateUrl => '请输入有效的 HTTPS URL';
}
