import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'medicine.g.dart';

@HiveType(typeId: 1)
class Medicine extends HiveObject {
  @HiveField(0)
  String? medName;
  @HiveField(1)
  String? docNote;
  @HiveField(2)
  String? sicNote;
  @HiveField(3)
  int? boxPrice;
  @HiveField(4)
  int? selPrice;

  Medicine(
      {this.medName, this.docNote, this.sicNote, this.boxPrice, this.selPrice});
}
