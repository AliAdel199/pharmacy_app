import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pharmacy_app/db/notes.dart';
import 'package:pharmacy_app/widget/costomTextField.dart';
import 'package:pharmacy_app/widget/myAlertDailog.dart';
import 'package:pharmacy_app/widget/showEditDailog.dart';
import 'package:pharmacy_app/widget/text_field_widget.dart';

import '../boxes.dart';
import '../constant.dart';

class MyNotes extends StatefulWidget {
  const MyNotes({Key? key}) : super(key: key);

  @override
  _MyNotesState createState() => _MyNotesState();
}

class _MyNotesState extends State<MyNotes> {
  var data = Boxes.getNotes();
  var fireData = Firestore.instance.collection("Notes");

  void getDataFromFireStore() async {
    //  var connectivityResult = await (Connectivity().checkConnectivity());
    //  print(connectivityResult);

    var subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult connectivityResult) async {
      // Got a new connectivity status!
      if (connectivityResult != ConnectivityResult.none) {
        setState(() {
          EasyLoading.show(
            status: 'Get Data...',
            maskType: EasyLoadingMaskType.clear,
          );
        });
        var dataStore = await fireData.get();
        dataStore.forEach((element) {

          final newMedicine = Notes()
            ..noteTitle = element["noteTitle"]
            ..noteContent = element["noteContent"]
            ..noteDate = element["noteDate"]
            ..noteStrong = element["noteStrong"];

          data.put(int.parse(element.id), newMedicine);
        });
        setState(() {
          EasyLoading.showSuccess('Great Success!');
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
    });
  }




  @override
  void initState() {
    // TODO: implement initState
    getDataFromFireStore() ;

    data.values.forEach((element) {print(element.key.runtimeType);});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DesktopWindow.setMinWindowSize(const Size(1050, 800));
    final orientation = MediaQuery.of(context).orientation;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        actions: [
          IconButton(
              onPressed: () => showDialog(
                  context: context,
                  builder: (context) {
                    return ShowAlertDailogNote(height: height, width: width,);
                  }),
              icon: Icon(
                Icons.note_add,
                color: buttonColor,
              ))
        ],
      ),
      backgroundColor: backgroundColor,
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            Positioned(
                left: 0,
                child: Image.asset(
                  "images/dd.png",
                  width: width,
                  height: height,
                  fit: BoxFit.cover,
                )),
          
            Positioned(
              child: Container(
                  width: width * 0.7,
                  height: height,
                  child: ValueListenableBuilder(
                      valueListenable: data.listenable(),
                      builder: (context, box, widget) {
                        return GridView.builder(
                          itemCount: data.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: 4,crossAxisSpacing: 1,
                                  crossAxisCount:4
                                      ),
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () =>showDialog(
                  context: context,
                  builder: (context) {
                    return ShowEditDailogNote(height: height, width: width, noteIndex: index);
                  }),
                         
                              child: Card(
                                color: buttonColor,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            data
                                                .getAt(index)!
                                                .noteTitle
                                                .toString(),
                                            style: TextStyle(
                                              fontFamily: 'Tajawal',
                                              fontSize: width * 0.0122,
                                              fontWeight: FontWeight.w700,
                                              color: fontColor,
                                            ),
                                          ),
                                         
                                        ],
                                      ),
                                    ),
                                    
                                  ],
                                ),
                                elevation: 5,
                              ),
                            );
                          },
                        );
                      })),
              top: height * 0.05,
              right: 50,
            )
          ],
        ),
      ),
    );
  }
}

