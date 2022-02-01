

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:firebase_core_desktop/firebase_core_desktop.dart';
import 'package:firedart/firedart.dart';
import 'package:firedart/firedart.dart' as ff;
import 'package:firedart/generated/google/protobuf/wrappers.pbjson.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../boxes.dart';
import '../widget/text_field_widget.dart';

import '../constant.dart';
import 'invoiceHistory.dart';

class InvoicesHistory extends StatefulWidget {
  const InvoicesHistory({Key? key}) : super(key: key);

  @override
  _InvoicesHistoryState createState() => _InvoicesHistoryState();
}

class _InvoicesHistoryState extends State<InvoicesHistory> {
  TextEditingController barcode = TextEditingController();
  TextEditingController? textEditingController = TextEditingController();
   FocusNode myFocusNode=FocusNode();

  var data = Boxes.getInvoice();
    var fireData = Firestore.instance.collection("Invoices");

    void uploadeInvoce()async{

      
     var subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult connectivityResult) async {
                    if (connectivityResult != ConnectivityResult.none) {
                      print("djhjkdhdhkjdhjkdhkjdhkddkh");
                  setState(() {
                    EasyLoading.show(
                        status: 'loading...',
                        maskType: EasyLoadingMaskType.black);
                  });
   data.values.forEach((element) async{
                  await fireData.document(element.invID.toString()).set({
                    "invID":element.invID,
                    "invDate":element.invDate,
                    // "invItems":Fired.Firestore.FieldValue.arrayUnion,
                    "invTotal":element.invTotal,
                    "invTime":element.invTime
      });  


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
                }});

    }

  @override
  void initState() {
    // TODO: implement initState
  uploadeInvoce();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});
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
              MyTextField(
                onChange: (x) {},
                fontSize: width * 0.012,
                width: width * 0.5,
                height: height * 0.8,
                textEditingController: textEditingController,
                myFocusNode: myFocusNode,
                callbackAction: () {},
                maxline: 1,
                posTop: height * 0.05,
                posRight: 50,
                title: "",
              ),
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
                      itemCount: data.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              (orientation == Orientation.portrait) ? 3 : 4),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => InvoiceHistory(
                                invoiceNumber:
                                    data.getAt(index)!.invID!.toInt(),
                              ),
                            ),
                          ),
                          child: Card(
                            color: backgroundColor,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        data.getAt(index)!.invID.toString(),
                                        style: TextStyle(
                                          fontFamily: 'Tajawal',
                                          fontSize: width * 0.0122,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      Text(
                                        " رقم الفاتورة : ",
                                        style: TextStyle(
                                          fontFamily: 'Tajawal',
                                          fontSize: width * 0.012,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black54,
                                        ),
                                        textDirection: TextDirection.rtl,
                                      )
                                    ],
                                  ),
                                ),
                                Divider(thickness: 3,endIndent: 20,indent: 20,),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        data.getAt(index)!.invTotal.toString(),
                                        style: TextStyle(
                                          fontFamily: 'Tajawal',
                                          fontSize: width * 0.012,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      Text(
                                        "المبلغ الكلي : ",
                                        style: TextStyle(
                                          fontFamily: 'Tajawal',
                                          fontSize: width * 0.012,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black54,
                                        ),
                                        textDirection: TextDirection.rtl,
                                      )
                                    ],
                                  ),
                                ),
                                const Divider(thickness: 3,endIndent: 20,indent: 20,),                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
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
                                      Text(
                                        data
                                            .getAt(index)!
                                            .invDate!
                                            .toLocal()
                                            .toString(),
                                        style: TextStyle(
                                          fontFamily: 'Tajawal',
                                          fontSize: width * 0.012,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black54,
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
                      })
                    
                    
                  ),
                ),
                top: height * 0.15,
                right: 50,
              )
            ],
          ),
        ));
  }
}
