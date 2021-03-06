import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'expireItems.g.dart';

@HiveType(typeId: 5)
class ExpireItems extends HiveObject {
  @HiveField(0)
  String? barcode;
    @HiveField(1)
  String? itemName;
  @HiveField(2)
  DateTime? expired;



  ExpireItems({this.barcode,this.expired,this.itemName});
}

