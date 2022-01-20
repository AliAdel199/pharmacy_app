import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:pharmacy_app/db/item_for_sell.dart';
import 'package:pharmacy_app/db/medicine.dart';
import 'package:pharmacy_app/widget/button_widget.dart';
import 'package:pharmacy_app/widget/text_field_widget.dart';

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

  late List aa;

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

    final box = Boxes.getMedicine();

    box.put(barcode, newMedicine);
    _barcode.clear();
    _itemName.clear();
    _itemPrice.clear();
    _docNote.clear();
    _sicNote.clear();
    _boxPrice.clear();

    // final mybox = Boxes.getTransactions();
    // final myTransaction = mybox.get('key');
    // mybox.values;
    // mybox.keys;
  }

  Future addItemSell(
      {String? barcode, String? name, String? sicNote, int? selPrice}) async {
    final box = Boxes.getItemForSell();

    // box.add(newMedicine);

    if (box.containsKey(barcode)) {
      var x = box.get(barcode)!.itemCount;
      final newMedicine = ItemForSell()
        ..medName = name
        ..sicNote = sicNote
        ..itemCount = x! + 1
        ..itemTotal = (x + 1) * selPrice!
        ..selPrice = selPrice;

      box.put(barcode, newMedicine);
    } else {
      final newMedicine = ItemForSell()
        ..medName = name
        ..sicNote = sicNote
        ..itemCount = 1
        ..selPrice = selPrice;
      box.put(barcode, newMedicine);
    }

    // final mybox = Boxes.getTransactions();
    // final myTransaction = mybox.get('key');
    // mybox.values;
    // mybox.keys;
  }

  @override
  Widget build(BuildContext context) {
    DesktopWindow.setMinWindowSize(Size(1050, 800));

    var itemForSell = Boxes.getItemForSell();
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
                    itemForSell.clear();
                  }),
            ],
          ),
        ));
  }
}
