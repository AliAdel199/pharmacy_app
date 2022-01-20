import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pharmacy_app/db/item_for_sell.dart';

part 'invoice.g.dart';

@HiveType(typeId: 2)
class Invoice extends HiveObject {
  @HiveField(0)
  int? invID;
  @HiveField(1)
  DateTime? invDate;
  @HiveField(2)
  int? invTotal;
  @HiveField(3)
  List<ItemForSell>? invItems;
  @HiveField(4)
  DateTime? invTime;


  Invoice({this.invID, this.invDate, this.invItems,this.invTotal,this.invTime});
}

