import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'item_for_sell.g.dart';

@HiveType(typeId: 3)
class ItemForSell extends HiveObject {
  @HiveField(0)
  String? medName;
  @HiveField(1)
  String? sicNote;
  @HiveField(2)
  int? selPrice;
  @HiveField(3)
  int? itemCount;
  @HiveField(4)
  int? itemTotal;
  @HiveField(5)
  String? docNote;
  @HiveField(6)
  String? barcode;

  ItemForSell(
      {this.medName,
      this.sicNote,
      this.selPrice,
      this.itemCount,
      this.docNote,
      this.barcode});

  String getIndex(int index) {
    switch (index) {
      case 0:
        return sicNote.toString();
      case 1:
        return itemTotal.toString();
      case 2:
        return selPrice.toString();
      case 3:
        return itemCount.toString();
      case 4:
        return medName.toString();
    }
    return '';
  }
}
