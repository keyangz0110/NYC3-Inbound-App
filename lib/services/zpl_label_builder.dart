class SlotLabelData {
  const SlotLabelData({
    required this.slotNumber,
    required this.cartonBarcode,
    required this.productBarcode,
    required this.quantity,
  });

  final String slotNumber;
  final String cartonBarcode;
  final String productBarcode;
  final int quantity;
}

class ZplLabelCaptions {
  const ZplLabelCaptions({
    required this.slot,
    required this.carton,
    required this.product,
    required this.quantity,
  });

  final String slot;
  final String carton;
  final String product;
  final String quantity;
}

class ZplLabelBuilder {
  ZplLabelBuilder._();

  // 4 x 6 in label at 203 dpi.
  static const int _labelWidth = 812;
  static const int _labelLength = 1218;
  static const int _margin = 20;
  static const int _contentWidth = _labelWidth - (_margin * 2);

  static String escapeZpl(String value) {
    return value
        .replaceAll('\\', '\\\\')
        .replaceAll('^', '^^')
        .replaceAll('~', '~~');
  }

  /// Approximate Code 128 width in dots for a given module width.
  static int _code128WidthDots(String data, int moduleWidth) {
    final modules = 35 + (11 * data.length);
    return modules * moduleWidth;
  }

  /// Pick the widest module width that still fits within [maxWidthDots].
  static int _barcodeModuleWidth(String data, int maxWidthDots) {
    for (var moduleWidth = 12; moduleWidth >= 2; moduleWidth--) {
      if (_code128WidthDots(data, moduleWidth) <= maxWidthDots) {
        return moduleWidth;
      }
    }
    return 2;
  }

  static int _centeredBarcodeX(String data, int moduleWidth) {
    final barcodeWidth = _code128WidthDots(data, moduleWidth);
    return _margin + ((_contentWidth - barcodeWidth) ~/ 2);
  }

  static String _centeredText({
    required int y,
    required int fontHeight,
    required int fontWidth,
    required String text,
  }) {
    return '''
^FO$_margin,$y^A0N,$fontHeight,$fontWidth^FB$_contentWidth,1,0,C,0^FD$text^FS''';
  }

  static String buildSlotLabel({
    required SlotLabelData data,
    required ZplLabelCaptions captions,
  }) {
    final slotText = escapeZpl('${captions.slot}: ${data.slotNumber}');
    final cartonText = escapeZpl(data.cartonBarcode);
    final productText = escapeZpl(data.productBarcode);
    final quantityText = escapeZpl('${captions.quantity}: ${data.quantity}');
    final cartonCaption = escapeZpl(captions.carton);
    final productCaption = escapeZpl(captions.product);
    final cartonBarcodeData = escapeZpl(data.cartonBarcode);
    final productBarcodeData = escapeZpl(data.productBarcode);

    final cartonModule = _barcodeModuleWidth(data.cartonBarcode, _contentWidth);
    final productModule = _barcodeModuleWidth(data.productBarcode, _contentWidth);
    final cartonX = _centeredBarcodeX(data.cartonBarcode, cartonModule);
    final productX = _centeredBarcodeX(data.productBarcode, productModule);

    return '''
^XA
^PW$_labelWidth
^LL$_labelLength
^LH0,0
^CI28
${_centeredText(y: 40, fontHeight: 110, fontWidth: 110, text: slotText)}
${_centeredText(y: 190, fontHeight: 42, fontWidth: 42, text: cartonCaption)}
${_centeredText(y: 240, fontHeight: 38, fontWidth: 38, text: cartonText)}
^FO$cartonX,300^BY$cartonModule,3,180^BCN,180,Y,N,N^FD$cartonBarcodeData^FS
${_centeredText(y: 560, fontHeight: 42, fontWidth: 42, text: productCaption)}
${_centeredText(y: 610, fontHeight: 38, fontWidth: 38, text: productText)}
^FO$productX,670^BY$productModule,3,180^BCN,180,Y,N,N^FD$productBarcodeData^FS
${_centeredText(y: 930, fontHeight: 72, fontWidth: 72, text: quantityText)}
^PQ1,0,1,Y
^XZ''';
  }

  static String buildTestLabel() {
    const testData = 'TEST123';
    final module = _barcodeModuleWidth(testData, _contentWidth);
    final barcodeX = _centeredBarcodeX(testData, module);

    return '''
^XA
^PW$_labelWidth
^LL$_labelLength
^LH0,0
^CI28
${_centeredText(y: 80, fontHeight: 64, fontWidth: 64, text: 'NYC3 Inbound Test')}
${_centeredText(y: 180, fontHeight: 40, fontWidth: 40, text: '4 x 6 inch label')}
^FO$barcodeX,280^BY$module,3,180^BCN,180,Y,N,N^FD$testData^FS
^PQ1,0,1,Y
^XZ''';
  }
}
