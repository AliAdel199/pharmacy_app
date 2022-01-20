import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pharmacy_app/constant.dart';
import 'package:pharmacy_app/db/invoice.dart';
import 'package:pharmacy_app/db/item_for_sell.dart';
import 'package:intl/intl.dart' as international;
import 'package:pharmacy_app/db/printInvoice.dart';
import 'package:pharmacy_app/widget/InvoiceTextField.dart';
import 'package:pharmacy_app/widget/button_widget.dart';
import 'package:pharmacy_app/widget/costomTextField.dart';
import 'package:pharmacy_app/widget/text_field_widget.dart';
import 'package:printing/printing.dart';
import '../constant.dart';
import '../boxes.dart';
import 'package:tabbed_view/tabbed_view.dart';

class NewInvoice extends StatefulWidget {
  const NewInvoice({Key? key}) : super(key: key);

  @override
  _NewInvoiceState createState() => _NewInvoiceState();
}

class _NewInvoiceState extends State<NewInvoice> {
  late TabbedViewController controller;
  final List<TextEditingController> _countControllers = [];
  final List<TextEditingController> _noteControllers = [];
  final List<TextEditingController> _docNoteControllers = [];
  final List<TextEditingController> _sellPriceControllers = [];
  final List<TextEditingController> _totalPriceControllers = [];
  final List<TextEditingController> _itemNameControllers = [];
  late List<List<ItemForSell>> tabItemList;

  num invoiceTotal = 0;
  final TextEditingController searchControler = TextEditingController();

  bool isRTL(String text) {
    return international.Bidi.detectRtlDirectionality(text);
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final items = Boxes.getMedicine();
    final itemSell = Boxes.getItemForSell();

    invoiceTotal = 0;
    for (int i = 0; i < itemSell.length; i++) {
      invoiceTotal = invoiceTotal + itemSell.getAt(i)!.itemTotal!;
    }

    DesktopWindow.setMinWindowSize(const Size(1050, 800));

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
                        )),
                  ),
                  Positioned(
                    top: height * 0.06,
                    right: height * 0.09,
                    child: Text(
                      "  بحث",
                      style: GoogleFonts.tajawal(
                        textStyle: Theme.of(context).textTheme.headline4,
                        fontSize: height * 0.03,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.italic,
                        color: fontColor,
                      ),
                    ),
                  ),
                  Positioned(
                    top: height * 0.3,
                    right: height * 0.98,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(width * 0.01),
                        color: buttonColor,
                        boxShadow: [
                          BoxShadow(
                            color: fontColor,
                            offset: Offset(1, 2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      width: width * 0.15,
                      height: width * 0.12,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Center(
                            child: Text(
                              "الاجمالي",
                              style: GoogleFonts.tajawal(
                                textStyle:
                                    Theme.of(context).textTheme.headline4,
                                fontSize: height * 0.03,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.italic,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Divider(),
                          Center(
                            child: Text(
                              " د.ع  $invoiceTotal",
                              style: GoogleFonts.tajawal(
                                textStyle:
                                    Theme.of(context).textTheme.headline4,
                                fontSize: height * 0.03,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.italic,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  MyButton(
                    posTop: height * 0.55,
                    posRight: height * 0.9,
                    width: width * 0.12,
                    height: width * 0.12,
                    title: "طباعة الفاتورة",
                    callbackAction: () async {
                      // Printing.listPrinters().
                      List<Printer> printers = await Printing.listPrinters();
                      var prenterIndex = printers.indexWhere((element) =>
                          element.isDefault == true &&
                          element.isAvailable == true);
                      print(printers);

                      final box = Boxes.getItemForSell();
                      final box2 = Boxes.getInvoice();
                      Invoice x = Invoice()
                        ..invID = box2.length + 1
                        ..invDate = DateTime.now()
                        ..invTime = DateTime.now()
                        ..invItems = box.values.toList()
                        ..invTotal = invoiceTotal as int?;
                      box2.put(box2.length + 1, x);

                      if (prenterIndex == -1) {
                        await Printing.layoutPdf(
                            onLayout: (format) => generateInvoice(format));
                      } else {
                        Printer printer = printers[prenterIndex];
                        await Printing.directPrintPdf(
                            printer: printer,
                            onLayout: (format) => generateInvoice(format));
                      }

                      box.clear();
                      setState(() {
                        invoiceTotal = 0;
                      });
                    },
                  ),
                  MyButton(
                    posTop: height * 0.55,
                    posRight: height * 1.1,
                    width: width * 0.12,
                    height: width * 0.12,
                    title: "فاتورة جديدة",
                    callbackAction: () {
                      final box = Boxes.getItemForSell();
                      final box2 = Boxes.getInvoice();
                      box2.clear();
                      box.clear();
                      setState(() {
                        invoiceTotal = 0;
                      });
                    },
                  ),
                  MyTextField(
                      fontSize: height * 0.02,
                      onChange: (x) async {
                        final box = Boxes.getItemForSell();



                        // box.add(newMedicine);

                        if (box.containsKey(searchControler.text.trim())) {
                          var x =
                              box.get(searchControler.text.trim())!.itemCount;
                          final newMedicine = ItemForSell()
                            ..barcode = searchControler.text.trim()
                            ..medName =
                                items.get(searchControler.text.trim())!.medName
                            ..sicNote =
                                items.get(searchControler.text.trim())!.sicNote
                            ..docNote =
                                items.get(searchControler.text.trim())!.docNote
                            ..itemCount = x! + 1
                            ..itemTotal = (x + 1) *
                                items
                                    .get(searchControler.text.trim())!
                                    .selPrice!
                            ..selPrice = items
                                .get(searchControler.text.trim())!
                                .selPrice;

                          box.put(searchControler.text.trim(), newMedicine);
                          setState(() {
                            invoiceTotal = 0;
                            for (int i = 0; i < itemSell.length; i++) {
                              invoiceTotal =
                                  invoiceTotal + itemSell.getAt(i)!.itemTotal!;
                            }
                          });
                          searchControler.clear();
                        } else {
                          var x = 1;
                          final newMedicine = ItemForSell()
                            ..barcode = searchControler.text.trim()
                            ..medName =
                                items.get(searchControler.text.trim())!.medName
                            ..sicNote =
                                items.get(searchControler.text.trim())!.sicNote
                            ..itemCount = x
                            ..docNote =
                                items.get(searchControler.text.trim())!.docNote
                            ..itemTotal = x *
                                items
                                    .get(searchControler.text.trim())!
                                    .selPrice!
                            ..selPrice = items
                                .get(searchControler.text.trim())!
                                .selPrice;
                          box.put(searchControler.text.trim(), newMedicine);
                          setState(() {
                            invoiceTotal = 0;
                            for (int i = 0; i < itemSell.length; i++) {
                              invoiceTotal =
                                  invoiceTotal + itemSell.getAt(i)!.itemTotal!;
                            }
                          });
                          searchControler.clear();
                        }
                      },
                      callbackAction: () {},
                      width: width * 0.51,
                      height: height * 0.9,
                      posRight: height * 0.07,
                      posTop: height * 0.1,
                      textEditingController: searchControler,
                      title: "title",
                      maxline: 1),
                  Positioned(
                    top: height * 0.2,
                    right: height * 0.07,
                    child: ValueListenableBuilder<Box<ItemForSell>>(
                      valueListenable: Boxes.getItemForSell().listenable(),
                      builder: (context, box, _) {
                        final transactions =
                            box.values.toList().cast<ItemForSell>();

                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(width * 0.01),
                            color: backgroundColor,
                            boxShadow: [
                              BoxShadow(
                                color: fontColor,
                                offset: Offset(10, 50),
                                blurRadius: 40,
                              ),
                            ],
                          ),
                          width: width * 0.51,
                          height: height * 0.9,
                          // color: Colors.white,
                          child: ListView.builder(
                            padding: EdgeInsets.only(
                                top: height * 0.01, bottom: height * 0.12),
                            itemCount: transactions.length,
                            itemBuilder: (BuildContext context, int index) {
                              // invoiceTotal= transactions.first.itemCount!.toInt();

                              _countControllers.add(TextEditingController());
                              _noteControllers.add(TextEditingController());
                              _docNoteControllers.add(TextEditingController());
                              _sellPriceControllers
                                  .add(TextEditingController());
                              _totalPriceControllers
                                  .add(TextEditingController());
                              _itemNameControllers.add(TextEditingController());

                              _countControllers[index].text =
                                  transactions[index].itemCount.toString();
                              _sellPriceControllers[index].text =
                                  transactions[index].selPrice.toString();
                              _noteControllers[index].text =
                                  transactions[index].sicNote.toString();
                              _docNoteControllers[index].text =
                                  transactions[index].docNote.toString();
                              _itemNameControllers[index].text =
                                  transactions[index].medName.toString();
                              _totalPriceControllers[index].text =
                                  transactions[index].itemTotal.toString();

                              // print("KLKLKL ${transactions.length}");
                              final transaction = transactions[index].itemTotal;
                              final item = transactions[index];

                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: height * 0.01,
                                    horizontal: height * 0.01),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(width * 0.01),
                                    color: buttonColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color: fontColor,
                                        offset: Offset(
                                            height * 0.01, height * 0.01),
                                        blurRadius: height * 0.01,
                                      ),
                                    ],
                                  ),
                                  height: height * 0.59,
                                  // color: Color(0xff97D4CA),
                                  child: ListView(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 20, top: 5),
                                            child: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    itemSell.deleteAt(index);
                                                  });
                                                },
                                                icon: Icon(
                                                  Icons.delete_forever_rounded,
                                                  color: textFieldFill,
                                                  size: 50,
                                                )),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.all(height * 0.01),
                                            child: CustomTextField(
                                              readOnly: true,
                                              width: width * 0.1,
                                              height: height,
                                              onChange: (x) {},
                                              textEditingController:
                                                  _totalPriceControllers[index],
                                              maxline: 1,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.all(height * 0.01),
                                            child: CustomTextField(
                                              readOnly: false,
                                              width: width * 0.1,
                                              height: height,
                                              onChange: (x) {
                                                box.getAt(index)!.selPrice =
                                                    int.parse(x.trim());
                                                setState(() {
                                                  box.getAt(index)!.itemTotal =
                                                      box
                                                              .getAt(index)!
                                                              .selPrice! *
                                                          box
                                                              .getAt(index)!
                                                              .itemCount!;
                                                });
                                              },
                                              textEditingController:
                                                  _sellPriceControllers[index],
                                              maxline: 1,
                                            ),
                                          ),
                                          Padding(
                                              padding:
                                                  EdgeInsets.all(height * 0.01),
                                              child: CustomTextField(
                                                readOnly: false,
                                                width: width * 0.055,
                                                height: height,
                                                onChange: (x) {
                                                  int a = box
                                                          .getAt(index)!
                                                          .itemCount =
                                                      int.parse(x.trim());
                                                  setState(() {
                                                    box
                                                        .getAt(index)!
                                                        .itemTotal = box
                                                            .getAt(index)!
                                                            .selPrice! *
                                                        a;
                                                  });
                                                },
                                                textEditingController:
                                                    _countControllers[index],
                                                maxline: 1,
                                              )),
                                          Padding(
                                            padding:
                                                EdgeInsets.all(height * 0.01),
                                            child: CustomTextField(
                                              readOnly: true,
                                              width: width * 0.15,
                                              height: height,
                                              onChange: (x) {},
                                              textEditingController:
                                                  _itemNameControllers[index],
                                              maxline: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Divider(),
                                      Text(
                                        "       ملاحظات للمريض",
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(
                                          fontFamily: 'Tajawal',
                                          fontSize: height * 0.02,
                                          fontWeight: FontWeight.w700,
                                          fontStyle: FontStyle.italic,
                                          color: fontColor,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(height * 0.01),
                                        child: InvoiceTextField(
                                          width: width,
                                          height: height * 0.20,
                                          maxLine: 6,
                                          textEditingController:
                                              _noteControllers[index],
                                          callbackAction: () {},
                                          onChange: (v) {
                                            final box = Boxes.getItemForSell();
                                            box.getAt(index)!.sicNote = v;
                                            // print("MMMMMM ${ box.getAt(index)!.sicNote}");
                                          },
                                        ),
                                      ),
                                      Text(
                                        "       ملاحظات شخصية",
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(
                                          fontFamily: 'Tajawal',
                                          fontSize: height * 0.02,
                                          fontWeight: FontWeight.w700,
                                          fontStyle: FontStyle.italic,
                                          color: fontColor,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(height * 0.01),
                                        child: InvoiceTextField(
                                          width: width,
                                          height: height * 0.20,
                                          maxLine: 6,
                                          textEditingController:
                                              _docNoteControllers[index],
                                          callbackAction: () {},
                                          onChange: (v) {},
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ));
  }
}
