import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'expiresoon.g.dart';

@HiveType(typeId: 6)
class ExpireItemSoon extends HiveObject {
  @HiveField(0)
  String? barcode;
    @HiveField(1)
  String? itemName;
  @HiveField(2)
  DateTime? expired;



  ExpireItemSoon({this.barcode,this.expired,this.itemName});
}

