import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:pharmacy_app/db/expireItems.dart';
import '../db/medicine.dart';
import '../widget/button_widget.dart';
import '../widget/text_field_widget.dart';

import '../boxes.dart';
import '../constant.dart';

class AddNewItem extends StatefulWidget {
  const AddNewItem({Key? key}) : super(key: key);

  @override
  _AddNewItemState createState() => _AddNewItemState();
}

class _AddNewItemState extends State<AddNewItem> {
  final TextEditingController _barcode = TextEditingController();
  final TextEditingController _itemName = TextEditingController();
  final TextEditingController _itemPrice = TextEditingController();
  final TextEditingController _boxPrice = TextEditingController();
  final TextEditingController _docNote = TextEditingController();
  final TextEditingController _sicNote = TextEditingController();
  FocusNode _barcodemyFocusNode = FocusNode();
  FocusNode _itemNameFocusNode = FocusNode();
  FocusNode _itemPriceFocusNode = FocusNode();
  FocusNode _boxPriceFocusNode = FocusNode();
  FocusNode _docNoteFocusNode = FocusNode();
  FocusNode _sicNoteFocusNode = FocusNode();

  var fireData = Firestore.instance.collection("Medicine");

  Future addItem(
      {String? barcode,
      String? name,
      String? docNote,
      String? sicNote,
      int? boxPrice,
      int? selPrice}) async {
    final newMedicine = Medicine()
      ..medName = name
      ..docNote = docNote
      ..sicNote = sicNote
      ..boxPrice = boxPrice
      ..selPrice = selPrice;

    final box = Boxes.getMedicine();
    box.put(barcode, newMedicine);
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      setState(() {
        EasyLoading.show(
            status: 'loading...', maskType: EasyLoadingMaskType.black);
      });

      await fireData.document(barcode!).set({
        "medName": name,
        "boxPrice": boxPrice,
        "sellPrice": selPrice,
        "sicNote": sicNote,
        "docNote": docNote
      });

      if(expireDate!=""){
        final expire=Boxes.getExpires();
        final newExp=ExpireItems(barcode: barcode,itemName: name ,expired: selectedDate);
        expire.add(newExp);

      }

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

    _barcode.clear();
    _itemName.clear();
    _itemPrice.clear();
    _docNote.clear();
    _sicNote.clear();
    _boxPrice.clear();
    _barcodemyFocusNode.requestFocus();

    // final mybox = Boxes.getTransactions();
    // final myTransaction = mybox.get('key');
    // mybox.values;
    // mybox.keys;
  }

  void clearFields() {
    _barcode.clear();
    _sicNote.clear();
    _boxPrice.clear();
    _itemPrice.clear();
    _itemName.clear();
    _docNote.clear();
  }

  @override
  Widget build(BuildContext context) {
    DesktopWindow.setMinWindowSize(Size(1050, 800));
    _barcodemyFocusNode.requestFocus();
    // var itemForSell = Boxes.getItemForSell();
    var invoice = Boxes.getInvoice();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
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
                   top: height * 0.5,
                right: height * 0.63,
                  child: GestureDetector(onTap: ()=>_selectDate(context),
                    child: Container(child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                     
                      Icon(Icons.date_range_outlined,size: height*0.04,),
                      Text(expireDate==""? "  تاريخ الانتهاء":expireDate,
                      style: TextStyle(
                        fontFamily: 'Tajawal',
                        fontSize: height * 0.03,
                        fontWeight: FontWeight.w700,
                        color: fontColor,
                      )),],),
                      width: width * 0.3,
                      height: height * 0.06,
                      decoration:   BoxDecoration(
                          borderRadius: BorderRadius.circular(width * 0.05),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: fontColor,
                              offset: Offset(1, 2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                    ),
                  )
                  //        RaisedButton(
                  //   onPressed: () => _selectDate(context),
                  //   child: Text('Select date'),
                  // ),
                  ),
              Positioned(
                top: 10,
                left: 10,
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(
                    Icons.exit_to_app_rounded,
                    size: width * 0.024,
                    color: buttonColor,
                  ),
                ),
              ),
              Positioned(
                top: height * 0.06,
                right: height * 0.12,
                child: Text("  الباركود",
                    style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: height * 0.03,
                      fontWeight: FontWeight.w700,
                      color: fontColor,
                    )),
              ),
              MyTextField(
                fontSize: height * 0.02,
                onChange: (x) {
                  final box = Boxes.getMedicine();
                  if (box.containsKey(_barcode.text.trim())) {
                    _barcode.text = _barcode.text.toString();
                    _sicNote.text = box.get(_barcode.text)!.sicNote.toString();
                    _docNote.text = box.get(_barcode.text)!.docNote.toString();
                    _boxPrice.text =
                        box.get(_barcode.text)!.boxPrice.toString();
                    _itemPrice.text =
                        box.get(_barcode.text)!.selPrice.toString();
                    _itemName.text = box.get(_barcode.text)!.medName.toString();
                  }
                },
                callbackAction: () {},
                width: width * 0.3,
                maxline: 1,
                height: height,
                posRight: height * 0.1,
                posTop: height * 0.1,
                title: "الباركود",
                textEditingController: _barcode,
                myFocusNode: _barcodemyFocusNode,
              ),
              Positioned(
                top: height * 0.06,
                right: height * 0.66,
                child: Text("  ملاحظات شخصية",
                    style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: height * 0.03,
                      fontWeight: FontWeight.w700,
                      color: fontColor,
                    )),
              ),
              MyTextField(
                fontSize: height * 0.025,
                onChange: (x) {},
                callbackAction: () {},
                width: width * 0.3,
                maxline: 16,
                height: height * 6,
                posRight: height * 0.63,
                posTop: height * 0.1,
                title: "ملاحظات شخصية",
                textEditingController: _docNote,
                myFocusNode: _docNoteFocusNode,
              ),
              Positioned(
                top: height * 0.21,
                right: height * 0.12,
                child: Text("  اسم المنتج",
                    style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: height * 0.03,
                      fontWeight: FontWeight.w700,
                      color: fontColor,
                    )),
              ),
              MyTextField(
                fontSize: height * 0.02,
                onChange: (x) {},
                callbackAction: () {},
                width: width * 0.3,
                maxline: 1,
                height: height,
                posRight: height * 0.1,
                posTop: height * 0.25,
                title: "اسم المنتج",
                textEditingController: _itemName,
                myFocusNode: _itemNameFocusNode,
              ),
              Positioned(
                top: height * 0.35,
                right: height * 0.12,
                child: Text("  سعر المفرد",
                    style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: height * 0.03,
                      fontWeight: FontWeight.w700,
                      color: fontColor,
                    )),
              ),
              MyTextField(
                fontSize: height * 0.02,
                onChange: (x) {},
                callbackAction: () {},
                width: width * 0.14,
                maxline: 1,
                height: height,
                posRight: height * 0.1,
                posTop: height * 0.4,
                title: "سعر المفرد",
                textEditingController: _itemPrice,
                myFocusNode: _itemPriceFocusNode,
              ),
              Positioned(
                top: height * 0.35,
                right: height * 0.37,
                child: Text("  سعر الصندوق",
                    style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: height * 0.03,
                      fontWeight: FontWeight.w700,
                      color: fontColor,
                    )),
              ),
              MyTextField(
                fontSize: height * 0.02,
                onChange: (x) {},
                callbackAction: () {},
                width: width * 0.14,
                maxline: 1,
                height: height,
                posRight: height * 0.35,
                posTop: height * 0.4,
                title: "سعر الصندوق",
                textEditingController: _boxPrice,
                myFocusNode: _boxPriceFocusNode,
              ),
              Positioned(
                top: height * 0.51,
                right: height * 0.12,
                child: Text("  ملاحظات للمريض",
                    style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: height * 0.03,
                      fontWeight: FontWeight.w700,
                      color: fontColor,
                    )),
              ),
              MyTextField(
                fontSize: height * 0.025,
                onChange: (x) {},
                callbackAction: () {},
                width: width * 0.3,
                maxline: 14,
                height: height * 6,
                posRight: height * 0.1,
                posTop: height * 0.55,
                title: "ملاحظات للمريض",
                textEditingController: _sicNote,
                myFocusNode: _sicNoteFocusNode,
              ),
              MyButton(
                  width: height * 0.2,
                  height: height * 0.2,
                  posRight: height * 0.65,
                  posTop: height * 0.63,
                  title: "اضافة",
                  callbackAction: () => addItem(
                      barcode: _barcode.text,
                      name: _itemName.text,
                      boxPrice: int.parse(_boxPrice.text),
                      selPrice: int.parse(_itemPrice.text),
                      docNote: _docNote.text,
                      sicNote: _sicNote.text)),
              MyButton(
                  width: height * 0.2,
                  height: height * 0.2,
                  posRight: height * 0.87,
                  posTop: height * 0.63,
                  title: "تعديل",
                  callbackAction: () async {
                    addItem(
                        barcode: _barcode.text,
                        name: _itemName.text,
                        docNote: _docNote.text,
                        sicNote: _sicNote.text,
                        boxPrice: int.parse(_boxPrice.text),
                        selPrice: int.parse(_itemPrice.text));
                    // clearFields();
                    _barcodemyFocusNode.requestFocus();
                    // itemForSell.clear();
                  }),
            ],
          ),
        ));
  }
  String expireDate="";
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        expireDate=DateFormat('yyyy-MM-dd').format(selectedDate);
        print(selectedDate.difference(DateTime.now()).inDays);
      });
    }
  }
}
