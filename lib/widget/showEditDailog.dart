import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pharmacy_app/db/notes.dart';

import '../boxes.dart';
import '../constant.dart';
import 'dart:ui' as ui;

class ShowEditDailogNote extends StatefulWidget {
  ShowEditDailogNote(
      {Key? key,required this.noteIndex,
      required this.height,
      required this.width,
 })
      : super(key: key);

  double height;
  double width;


  int noteIndex;



  @override
  _ShowEditDailogNoteState createState() => _ShowEditDailogNoteState();
}

class _ShowEditDailogNoteState extends State<ShowEditDailogNote> {

  TextEditingController noteTitleController = TextEditingController();
  TextEditingController noteContentController = TextEditingController();

  String dropdownValue = 'Weak';
  var data = Boxes.getNotes();
  var fireData = Firestore.instance.collection("Notes");

  void editNote(String title, String content, var strong) async {
    print(data.getAt(widget.noteIndex)!.key);
    setState(() {
      
    });
    var date = DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());
    Notes mynote = Notes(
        noteTitle: noteTitleController.text,
        noteContent: noteContentController.text,
        noteDate: date,
        noteStrong:dropdownValue);
    data.put(data.getAt(widget.noteIndex)!.key,mynote);
    var connectivityResult =
                    await (Connectivity().checkConnectivity());
      if (connectivityResult != ConnectivityResult.none) {
        print("hjhhhkkhkkhk");
        await fireData
            .document((data.getAt(widget.noteIndex)!.key).toString())
            .set({
          "noteTitle":noteTitleController.text,
          "noteContent": noteContentController.text,
          "noteStrong": dropdownValue,
          "noteDate": date
        });
        // I am connected to a mobile network.
      } else {
        // I am connected to a wifi network.
        AlertDialog(
          title: Text(
            "تنبيه",
            style: TextStyle(
              fontFamily: 'Tajawal',
              fontSize: 20,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.italic,
              color: fontColor,
            ),
          ),
          content: Text(
            "تم حفظ البيانات بدون الرفع الى الانترنت لعدم وجود الاتصال !!!",
            style: TextStyle(
              fontFamily: 'Tajawal',
              fontSize: 20,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.italic,
              color: fontColor,
            ),
          ),
        );
      }

  }





  @override
  void initState() {
    // TODO: implement initState
    noteContentController.text=data.get(data.getAt(widget.noteIndex)!.key)!.noteContent.toString();
    noteTitleController.text=data.get(data.getAt(widget.noteIndex)!.key)!.noteTitle.toString();
   dropdownValue=data.get(data.getAt(widget.noteIndex)!.key)!.noteStrong.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text('Add New Note')),
      content: Container(
        width: widget.width * 0.4,
        height: widget.height * 0.7,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.width * 0.02),
                color: Colors.white70,
                boxShadow: [
                  BoxShadow(
                    color: fontColor,
                    offset: const Offset(1, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
              width: widget.width * 0.35,
              child: TextField(textDirection:ui.TextDirection.rtl,
                controller: noteTitleController,
                maxLines: 1,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white70,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(widget.width * 0.02)),
                ),
              ),
            ),
            SizedBox(
              height: 60,
              width: widget.width * 0.35,
              child: DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                borderRadius: BorderRadius.circular(25),
                style: TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                  color: fontColor,
                ),
                underline: Container(
                  height: 1,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    print("newValue $newValue");
                    dropdownValue = newValue!;
                  });
                },
                items: <String>['Weak', 'Strong', 'Semi-Strong']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.width * 0.02),
                color: Colors.white70,
                boxShadow: [
                  BoxShadow(
                    color: fontColor,
                    offset: Offset(1, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
              width: widget.width * 0.35,
              child: TextField(textDirection:ui.TextDirection.rtl,
                controller:noteContentController,
                maxLines: 20,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white70,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(widget.width * 0.02)),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: widget.height * 0.05,
                  width: widget.width * 0.08,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(buttonColor)),
                      onPressed: ()async{
                         var connectivityResult =
                    await (Connectivity().checkConnectivity());

                if (connectivityResult != ConnectivityResult.none) {
                  await fireData
                      .document(data.getAt(widget.noteIndex)!.key.toString())
                      .delete();
                  data.delete(data.getAt(widget.noteIndex)!.key);

                  // I am connected to a mobile network.
                } else {
                  // I am connected to a wifi network.
                  AlertDialog(
                    title: Text(
                      "تنبيه",
                      style: TextStyle(
                        fontFamily: 'Tajawal',
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.italic,
                        color: fontColor,
                      ),
                    ),
                    content: Text(
                      "لم يتم حذف العنصر لعدم الاتصال بالانترنت حاول مرة اخرى عند الاتصال.",
                      style: TextStyle(
                        fontFamily: 'Tajawal',
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.italic,
                        color: fontColor,
                      ),
                    ),
                  );
                }

               Navigator.pop(context, null);
                      }
                      
                      
                    ,
                      child: Text(
                        "Delete",
                        style: TextStyle(
                          fontFamily: 'Tajawal',
                          fontSize: widget.height * 0.023,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                          color: fontColor,
                        ),
                      )),
                ),
                const SizedBox(
                  width: 25,
                ),
                SizedBox(
                  height: widget.height * 0.05,
                  width: widget.width * 0.08,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(buttonColor)),
                      onPressed: () => editNote(noteTitleController.text,
                          noteContentController.text, dropdownValue),
                      child: Text(
                         "Edit",
                        style: TextStyle(
                          fontFamily: 'Tajawal',
                          fontSize: widget.height * 0.023,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                          color: fontColor,
                        ),
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
