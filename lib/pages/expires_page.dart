import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:desktop_window/desktop_window.dart';
// import 'package:firebase_core_desktop/firebase_core_desktop.dart';
import 'package:firedart/firedart.dart';
import 'package:firedart/firedart.dart' as ff;
import 'package:firedart/generated/google/protobuf/wrappers.pbjson.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pharmacy_app/db/expireItems.dart';
import 'package:pharmacy_app/db/expiresoon.dart';
import '../boxes.dart';
import '../widget/text_field_widget.dart';

import '../constant.dart';
import 'invoiceHistory.dart';

class ExpireSoon extends StatefulWidget {
  const ExpireSoon({Key? key}) : super(key: key);

  @override
  _ExpireSoonState createState() => _ExpireSoonState();
}

class _ExpireSoonState extends State<ExpireSoon> {
  TextEditingController barcode = TextEditingController();
  TextEditingController? textEditingController = TextEditingController();
  FocusNode myFocusNode = FocusNode();
  List<ExpireItems> filtered = [];

  var data = Boxes.getExpires();
  var fireData = Firestore.instance.collection("Invoices");



  @override
  void initState() {
    setState(() {
      var ff = data.values.where(
          (element) => element.expired!.difference(DateTime.now()).inDays < 11);
      filtered = ff.toList();
      filtered.sort((a, b) => a.expired!.compareTo(b.expired!));
    });
    // TODO: implement initState
    // uploadeInvoce();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DesktopWindow.setMinWindowSize(Size(1050, 800));
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final orientation = MediaQuery.of(context).orientation;

    return Scaffold(
        backgroundColor: const Color(0xffE1EFEC),
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
                top: 10,
                left: 10,
                child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.exit_to_app_rounded,
                      size: width * 0.024,
                      color: const Color(0xff79C9BC),
                    )),
              ),
             data.length!=0?
              Positioned(
                child: Container(
                  width: width * 0.7,
                  height: height,
                  child: Padding(
                      padding: const EdgeInsets.only(bottom: 140),
                      child: ValueListenableBuilder(
                          valueListenable: data.listenable(),
                          builder: (context, box, widget) {
                            return GridView.builder(
                              itemCount: filtered.length,
                              gridDelegate:
                                   const SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: 2,crossAxisSpacing: 6,
                                  crossAxisCount:4
                                      ),
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  child: Card(
                                    color: backgroundColor,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                filtered[index]
                                                    .itemName
                                                    .toString(),
                                                style: TextStyle(
                                                  fontFamily: 'Tajawal',
                                                  fontSize: width * 0.0122,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                              Text(
                                                " اسم المادة : ",
                                                style: TextStyle(
                                                  fontFamily: 'Tajawal',
                                                  fontSize: width * 0.012,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.black54,
                                                ),
                                                textDirection:
                                                    TextDirection.rtl,
                                              )
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          thickness: 3,
                                          endIndent: 20,
                                          indent: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10),
                                              child: Text(
                                                "${filtered[index].expired!.year} - ${filtered[index].expired!.month} - ${filtered[index].expired!.day}",
                                                style: TextStyle(
                                                  fontFamily: 'Tajawal',
                                                  fontSize: width * 0.012,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              "التأريخ : ",
                                              style: TextStyle(
                                                fontFamily: 'Tajawal',
                                                fontSize: width * 0.012,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black54,
                                              ),
                                              textDirection: TextDirection.rtl,
                                            ),
                                            SizedBox(
                                              width: 15,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    elevation: 5,
                                  ),
                                );
                              },
                            );
                          })),
                ),
                top: height * 0.15,
                right: 50,
              ):Center(child: Text("رائع لاتوجد مواد منتهية الصلاحية ", style: TextStyle(
          fontFamily: 'Tajawal',
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: fontColor,
        ),),)
           
            ],
          ),
        ));
  }
}
