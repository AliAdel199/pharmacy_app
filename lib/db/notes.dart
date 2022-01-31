
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';


part 'notes.g.dart';

@HiveType(typeId: 4)
class Notes extends HiveObject {

 @HiveField(0)
 String? noteTitle;
@HiveField(1)
String? noteContent;
@HiveField(2)
String? noteStrong;
@HiveField(3)
String? noteDate;

Notes({this.noteTitle,this.noteContent,this.noteDate,this.noteStrong});

}