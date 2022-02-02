import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'expireItems.g.dart';

@HiveType(typeId: 2)
class ExpireItems extends HiveObject {
  @HiveField(0)
  String? barcode;
  @HiveField(1)
  List<DateTime>? expired;



  ExpireItems({this.barcode,this.expired});
}

