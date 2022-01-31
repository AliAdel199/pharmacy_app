// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:firedart/firedart.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:pharmacy_app/widget/costomTextField.dart';
// import '/db/notes.dart';

// import '../boxes.dart';
// import '../constant.dart';

// class AddNote extends StatefulWidget {
//   const AddNote({Key? key}) : super(key: key);

//   @override
//   _AddNoteState createState() => _AddNoteState();
// }

// class _AddNoteState extends State<AddNote> {
//   TextEditingController noteTitleController = TextEditingController();
//   TextEditingController noteContentController = TextEditingController();
//   final note = Boxes.getNotes();

//   var fireData = Firestore.instance.collection("Notes");

//   String dropdownValue = 'Weak';
//   void addNote() async {
//     var date = DateTime.now().toUtc();

//     var connectivityResult = await (Connectivity().checkConnectivity());
//     Notes mynote = Notes(
//         noteTitle: noteTitleController.text,
//         noteContent: noteContentController.text,
//         noteDate: date,
//         noteStrong: dropdownValue);
//     note.add(mynote);

//     if (connectivityResult != ConnectivityResult.none) {
//       await fireData.document((note.getAt(note.length-1)!.key).toString()).set({
//         "noteTitle": noteTitleController.text,
//         "noteContent": noteContentController.text,
//         "noteStrong": dropdownValue,
//         "noteDate": date
//       });
//       // I am connected to a mobile network.
//     } else {
//       // I am connected to a wifi network.
//       AlertDialog(
//         title: Text(
//           "تنبيه",
//           style: TextStyle(
//             fontFamily: 'Tajawal',
//             fontSize: 20,
//             fontWeight: FontWeight.w700,
//             fontStyle: FontStyle.italic,
//             color: fontColor,
//           ),
//         ),
//         content: Text(
//           "تم حفظ البيانات بدون الرفع الى الانترنت لعدم وجود الاتصال !!!",
//           style: TextStyle(
//             fontFamily: 'Tajawal',
//             fontSize: 20,
//             fontWeight: FontWeight.w700,
//             fontStyle: FontStyle.italic,
//             color: fontColor,
//           ),
//         ),
//       );
//     }

//     noteContentController.clear();
//     noteTitleController.clear();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     print("FFFFFF${note.length}");
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: backgroundColor,
//           actions: [
//             ElevatedButton(
//               onPressed: () => addNote(),
//               style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all(buttonColor),
//                   elevation: MaterialStateProperty.all(25)),
//               child: Row(
//                 children: const [
//                   Center(
//                     child: Text(
//                       "اضافة",
//                       style: TextStyle(
//                         fontFamily: 'Tajawal',
//                         fontSize: 20,
//                         fontWeight: FontWeight.w700,
//                         fontStyle: FontStyle.italic,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 15,
//                   ),
//                   Icon(Icons.add_comment_outlined),
//                   SizedBox(
//                     width: 15,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         backgroundColor: backgroundColor,
//         body: ListView(
//           children: [
//             CustomTextField(
//                 width: width,
//                 height: 60,
//                 onChange: (x) {},
//                 maxline: 1,
//                 readOnly: false,
//                 textEditingController: noteTitleController,
//               ),
//             const SizedBox(
//               height: 15,
//             ),
//             SizedBox(
//               height: 60,
//               child: DropdownButton<String>(
//                 value: dropdownValue,
//                 icon: const Icon(Icons.arrow_downward),
//                 elevation: 16,
//                 borderRadius: BorderRadius.circular(25),
//                 style: TextStyle(
//                   fontFamily: 'Tajawal',
//                   fontSize: 20,
//                   fontWeight: FontWeight.w700,
//                   fontStyle: FontStyle.italic,
//                   color: fontColor,
//                 ),
//                 underline: Container(
//                   height: 1,
//                   color: Colors.deepPurpleAccent,
//                 ),
//                 onChanged: (String? newValue) {
//                   setState(() {
//                     print("newValue $newValue");
//                     dropdownValue = newValue!;
//                   });
//                 },
//                 items: <String>['Weak', 'Strong', 'Semi-Strong']
//                     .map<DropdownMenuItem<String>>((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//               ),
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//             CustomTextField(
//                 width: width,
//                 height: 450,
//                 onChange: (x) {},
//                 maxline: 25,
//                 readOnly: false,
//                 textEditingController: noteContentController,
//               ),
//           ],
//         ));
//   }
// }
