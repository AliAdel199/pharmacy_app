import 'package:hive/hive.dart';
import 'package:pharmacy_app/db/expireItems.dart';
import 'package:pharmacy_app/db/expiresoon.dart';

import 'db/invoice.dart';
import 'db/item_for_sell.dart';
import 'db/medicine.dart';
import 'db/notes.dart';

class Boxes {
  static Box<Medicine> getMedicine() => Hive.box<Medicine>('medicine');

  static Box<Invoice> getInvoice() => Hive.box<Invoice>('invoice');

  static Box<ItemForSell> getItemForSell(String boxName) =>
      Hive.box<ItemForSell>(boxName);
  static Box<Notes> getNotes() => Hive.box<Notes>("notes");
  static Box<ExpireItems> getExpires() => Hive.box<ExpireItems>("expire");
  static Box<ExpireItemSoon> getExpiresSoon() => Hive.box<ExpireItemSoon>("expireSoon");

  static Box test() => Hive.box('test');
}
