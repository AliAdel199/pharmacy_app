import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../db/medicine.dart';
import '../widget/button_widget.dart';
import '../widget/text_field_widget.dart';

import '../boxes.dart';
import '../constant.dart';
import 'items_list.dart';

class ItemInfo extends StatefulWidget {
  ItemInfo({Key? key, required this.barcode}) : super(key: key);
  String barcode;

  @override
  _ItemInfoState createState() => _ItemInfoState();
}

class _ItemInfoState extends State<ItemInfo> {
  final TextEditingController _barcode = TextEditingController();
  final TextEditingController _itemName = TextEditingController();
  final TextEditingController _itemPrice = TextEditingController();
  final TextEditingController _boxPrice = TextEditingController();
  final TextEditingController _docNote = TextEditingController();
  final TextEditingController _sicNote = TextEditingController();
  final  FocusNode _barcodemyFocusNode=FocusNode();
  final  FocusNode _itemNameFocusNode=FocusNode();
  final  FocusNode _itemPriceFocusNode=FocusNode();
  final  FocusNode _boxPriceFocusNode=FocusNode();
   final FocusNode _docNoteFocusNode=FocusNode();
   final FocusNode _sicNoteFocusNode=FocusNode();
   late List aa;
  var fireData = Firestore.instance.collection("Medicine");

  final box = Boxes.getMedicine();

  //
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

    box.put(barcode, newMedicine);

  }
  @override
  void initState() {
    // TODO: implement initState
    _barcode.text = widget.barcode;
    _itemName.text = box.get(widget.barcode)!.medName.toString();
    _boxPrice.text = box.get(widget.barcode)!.boxPrice.toString();
    _sicNote.text = box.get(widget.barcode)!.sicNote.toString();
    _itemPrice.text = box.get(widget.barcode)!.selPrice.toString();
    _docNote.text = box.get(widget.barcode)!.docNote.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    DesktopWindow.setMinWindowSize(Size(1050, 800));

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
                textEditingController: _barcode,myFocusNode: _barcodemyFocusNode,
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
                textEditingController: _docNote,myFocusNode: _docNoteFocusNode,
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
                textEditingController: _itemName,myFocusNode: _itemNameFocusNode,
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
                textEditingController: _itemPrice,myFocusNode: _itemPriceFocusNode,
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
                textEditingController: _boxPrice,myFocusNode: _boxPriceFocusNode,
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
                textEditingController: _sicNote,myFocusNode: _sicNoteFocusNode,
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
                  boxPrice:_boxPrice.text!=""? int.parse(_boxPrice.text):0,
                  selPrice:_itemPrice.text!=""? int.parse(_itemPrice.text):0,
                  docNote: _docNote.text,
                  sicNote: _sicNote.text)),
              MyButton(
                  width: height * 0.2,
                  height: height * 0.2,
                  posRight: height * 0.87,
                  posTop: height * 0.63,
                  title: "حذف",
                  callbackAction: () async {
                var connectivityResult =
                    await (Connectivity().checkConnectivity());

                if (connectivityResult != ConnectivityResult.none) {
                  setState(() {
                    EasyLoading.show(
                        status: 'loading...',
                        maskType: EasyLoadingMaskType.black);
                  });

                  await fireData.document(widget.barcode.toString()).delete();
                  box.delete(widget.barcode);
                  

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

                _barcode.clear();
                _itemName.clear();
                _itemPrice.clear();
                _docNote.clear();
                _sicNote.clear();
                _boxPrice.clear();
               
              },),
            ],
          ),
        ));
  }
}
