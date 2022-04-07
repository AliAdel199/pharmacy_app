import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pharmacy_app/db/notes.dart';

import '../boxes.dart';
import '../constant.dart';
import 'dart:ui' as ui;

class ShowAlertDailogNote extends StatefulWidget {
  ShowAlertDailogNote(
      {Key? key,
      required this.height,
      required this.width,
 })
      : super(key: key);

  double height;
  double width;



  @override
  _ShowAlertDailogNoteState createState() => _ShowAlertDailogNoteState();
}

class _ShowAlertDailogNoteState extends State<ShowAlertDailogNote> {

  TextEditingController noteTitleController = TextEditingController();
  TextEditingController noteContentController = TextEditingController();
  String dropdownValue = 'Weak';
  var data = Boxes.getNotes();
  var fireData = Firestore.instance.collection("Notes");

  void addNote(String title, String content, var strong) async {
    var date = DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());

    var connectivityResult = await (Connectivity().checkConnectivity());
    Notes mynote = Notes(
        noteTitle: noteTitleController.text,
        noteContent: noteContentController.text,
        noteDate: date,
        noteStrong: dropdownValue);
    data.add(mynote);

    if (connectivityResult != ConnectivityResult.none) {
      await fireData.document((data.getAt(data.length-1)!.key).toString()).set({
        "noteTitle": noteTitleController.text,
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
    

   noteTitleController.clear();
   noteContentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    var rtl;
    return AlertDialog(elevation: 50,
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
                    offset: Offset(1, 2),
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
            // SizedBox(
            //   height: 60,
            //   width: widget.width * 0.35,
            //   child: DropdownButton<String>(
            //     value: dropdownValue,
            //     icon: const Icon(Icons.arrow_downward),
            //     elevation: 16,
            //     borderRadius: BorderRadius.circular(25),
            //     style: TextStyle(
            //       fontFamily: 'Tajawal',
            //       fontSize: 20,
            //       fontWeight: FontWeight.w700,
            //       fontStyle: FontStyle.italic,
            //       color: fontColor,
            //     ),
            //     underline: Container(
            //       height: 1,
            //       color: Colors.deepPurpleAccent,
            //     ),
            //     onChanged: (String? newValue) {
            //       setState(() {
            //         print("newValue $newValue");
            //         dropdownValue = newValue!;
            //       });
            //     },
            //     items: <String>['Weak', 'Strong', 'Semi-Strong']
            //         .map<DropdownMenuItem<String>>((String value) {
            //       return DropdownMenuItem<String>(
            //         value: value,
            //         child: Text(value),
            //       );
            //     }).toList(),
            //   ),
            // ),
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
                      onPressed: () => Navigator.pop(context, null),
                      child: Text(
                        "cancel",
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
                      onPressed: () => addNote(noteTitleController.text,
                         noteContentController.text, dropdownValue),
                      child: Text(
                         "Add",
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
