import 'package:flutter_test/flutter_test.dart';
import 'package:sorting/services/sort_storage_service.dart';

void main() {
  test('formatSlot pads to two digits', () {
    expect(SortStorageService.formatSlot(1), '01');
    expect(SortStorageService.formatSlot(9), '09');
    expect(SortStorageService.formatSlot(42), '42');
    expect(SortStorageService.formatSlot(99), '99');
  });
}
