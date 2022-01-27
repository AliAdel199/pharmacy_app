import 'package:hive/hive.dart';

import 'db/invoice.dart';
import 'db/item_for_sell.dart';
import 'db/medicine.dart';

class Boxes {
  static Box<Medicine> getMedicine() => Hive.box<Medicine>('medicine');

  static Box<Invoice> getInvoice() => Hive.box<Invoice>('invoice');

  static Box<ItemForSell> getItemForSell(String boxName) =>
      Hive.box<ItemForSell>(boxName);

  static Box test() => Hive.box('test');
}
