import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

import 'package:hive_flutter/hive_flutter.dart';
import '../constant.dart';
import '../db/invoice.dart';
import '../db/item_for_sell.dart';
import 'package:intl/intl.dart' as international;
import '../db/printInvoice.dart';
import '../widget/InvoiceTextField.dart';
import '../widget/button_widget.dart';
import '../widget/costomTextField.dart';
import '../widget/text_field_widget.dart';
import 'package:printing/printing.dart';

import '../boxes.dart';
import 'package:tabbed_view/tabbed_view.dart';

import '../customTabView.dart';

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

  final items = Boxes.getMedicine();

  // late List<List<ItemForSell>> tabItemList;

  num invoiceTotal = 0;
  final TextEditingController searchControler = TextEditingController();
  late FocusNode searchFocusNode;

  bool isRTL(String text) {
    return international.Bidi.detectRtlDirectionality(text);
  }

  List<String> data = ['New Invoice'];
  int initPosition = 0;

  var box;

  @override
  void initState() {
    // TODO: implement initState
    searchFocusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    searchFocusNode.requestFocus();
    updateTotalInvoice(initPosition);

    DesktopWindow.setMinWindowSize(const Size(1150, 800));

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: backgroundColor,
        body: Container(
            constraints: BoxConstraints.expand(),
            child: CustomTabView(
              onPositionChange: (index) {
                print('current position: $index');
                setState(() {
                  initPosition = index;
                });
              },
              onScroll: (position) => print('$position'),
              stub: Container(),
              initPosition: initPosition,
             
              itemCount: data.length,

              tabBuilder: (context, index) => Container(
                  width: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(data[index]),
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            clearInvoice(initPosition);

                              if(index!=0){

                                data.removeAt(index);
                              }
                              setState(() {
                                invoiceTotal=0;
                              });

                          },
                          icon: Icon(Icons.delete_forever_rounded),color: Colors.deepOrangeAccent,),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              if (data.length < 10) {
                                data.add('New Invoice ');
                              } else {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text('تنبيه !!',
                                        textDirection: TextDirection.rtl),
                                    content: const Text(
                                      'لقد وصلت الى اعلا قدر\n من النوافذ المفتوحة',
                                      textDirection: TextDirection.rtl,
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Cancel'),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'OK'),
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            });
                          },
                          icon: Icon(Icons.add))
                    ],
                  )),
             
              pageBuilder: (context, tabIndex) => Stack(
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
                        onPressed: () {
                          Navigator.of(context).pop();
                          Boxes.getItemForSell("inv1").clear();
                          Boxes.getItemForSell("inv2").clear();
                          Boxes.getItemForSell("inv3").clear();
                          Boxes.getItemForSell("inv4").clear();
                          Boxes.getItemForSell("inv5").clear();
                          Boxes.getItemForSell("inv6").clear();
                          Boxes.getItemForSell("inv7").clear();
                          Boxes.getItemForSell("inv8").clear();
                          Boxes.getItemForSell("inv9").clear();
                          Boxes.getItemForSell("inv10").clear();
                        },
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
                      // style: GoogleFonts.tajawal(
                      //   textStyle: Theme.of(context).textTheme.headline4,
                      //   fontSize: height * 0.03,
                      //   fontWeight: FontWeight.w700,
                      //   fontStyle: FontStyle.italic,
                      //   color: fontColor,
                      // ),
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
                              // style: GoogleFonts.tajawal(
                              //   textStyle:
                              //       Theme.of(context).textTheme.headline4,
                              //   fontSize: height * 0.03,
                              //   fontWeight: FontWeight.w700,
                              //   fontStyle: FontStyle.italic,
                              //   color: Colors.white,
                              // ),
                            ),
                          ),
                          Divider(),
                          Center(
                            child: Text(
                              " د.ع  $invoiceTotal",
                              // style: GoogleFonts.tajawal(
                              //   textStyle:
                              //       Theme.of(context).textTheme.headline4,
                              //   fontSize: height * 0.03,
                              //   fontWeight: FontWeight.w700,
                              //   fontStyle: FontStyle.italic,
                              //   color: Colors.white,
                              // ),
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

                      if (initPosition == 0) {
                        box = Boxes.getItemForSell("inv1");
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
                      } else if (initPosition == 1) {
                        box = Boxes.getItemForSell("inv2");
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
                      } else if (initPosition == 2) {
                        box = Boxes.getItemForSell("inv3");
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
                      } else if (initPosition == 3) {
                        box = Boxes.getItemForSell("inv4");
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
                      } else if (initPosition == 4) {
                        box = Boxes.getItemForSell("inv5");
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
                      } else if (initPosition == 5) {
                        box = Boxes.getItemForSell("inv6");
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
                      } else if (initPosition == 6) {
                        box = Boxes.getItemForSell("inv7");
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
                      } else if (initPosition == 7) {
                        box = Boxes.getItemForSell("inv8");
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
                      } else if (initPosition == 8) {
                        box = Boxes.getItemForSell("inv9");
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
                      } else if (initPosition == 9) {
                        box = Boxes.getItemForSell("inv10");
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
                      }

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
                      clearInvoice(initPosition);
                      setState(() {
                        invoiceTotal = 0;
                      });
                    },
                  ),
                  MyTextField(
                      fontSize: height * 0.02,
                      onChange: (x) {
                        updateItemsList(initPosition);
                      },
                      callbackAction: () {},
                      width: width * 0.51,
                      height: height * 0.9,
                      posRight: height * 0.07,
                      posTop: height * 0.1,
                      textEditingController: searchControler,
                      myFocusNode: searchFocusNode,
                      title: "title",
                      maxline: 1),
                  Positioned(
                    top: height * 0.2,
                    right: height * 0.07,
                    child: ValueListenableBuilder<Box<ItemForSell>>(
                      valueListenable:
                          Boxes.getItemForSell(box.name).listenable(),
                      builder: (context, box, _) {
                        print(box.name);
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
                            itemCount: box.length,
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
                                            padding:  EdgeInsets.only(
                                                right: width*0.002, top: 5),
                                            child: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    box.deleteAt(index);
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
                                            box = Boxes.getItemForSell(
                                                'inv${initPosition}');
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
            ),
            ),
            );
  }



  void updateTotalInvoice(int initPosition) {
    if (initPosition == 0) {
      box = Boxes.getItemForSell("inv1");
      invoiceTotal = 0;
      for (int i = 0; i < box.length; i++) {
        invoiceTotal = invoiceTotal + box.getAt(i)!.itemTotal!;
      }
    } else if (initPosition == 1) {
      box = Boxes.getItemForSell("inv2");
      invoiceTotal = 0;
      for (int i = 0; i < box.length; i++) {
        invoiceTotal = invoiceTotal + box.getAt(i)!.itemTotal!;
      }
    } else if (initPosition == 2) {
      box = Boxes.getItemForSell("inv3");
      invoiceTotal = 0;
      for (int i = 0; i < box.length; i++) {
        invoiceTotal = invoiceTotal + box.getAt(i)!.itemTotal!;
      }
    } else if (initPosition == 3) {
      box = Boxes.getItemForSell("inv4");
      invoiceTotal = 0;
      for (int i = 0; i < box.length; i++) {
        invoiceTotal = invoiceTotal + box.getAt(i)!.itemTotal!;
      }
    } else if (initPosition == 4) {
      box = Boxes.getItemForSell("inv5");
      invoiceTotal = 0;
      for (int i = 0; i < box.length; i++) {
        invoiceTotal = invoiceTotal + box.getAt(i)!.itemTotal!;
      }
    } else if (initPosition == 5) {
      box = Boxes.getItemForSell("inv6");
      invoiceTotal = 0;
      for (int i = 0; i < box.length; i++) {
        invoiceTotal = invoiceTotal + box.getAt(i)!.itemTotal!;
      }
    } else if (initPosition == 6) {
      box = Boxes.getItemForSell("inv7");
      invoiceTotal = 0;
      for (int i = 0; i < box.length; i++) {
        invoiceTotal = invoiceTotal + box.getAt(i)!.itemTotal!;
      }
    } else if (initPosition == 7) {
      box = Boxes.getItemForSell("inv8");
      invoiceTotal = 0;
      for (int i = 0; i < box.length; i++) {
        invoiceTotal = invoiceTotal + box.getAt(i)!.itemTotal!;
      }
    } else if (initPosition == 8) {
      box = Boxes.getItemForSell("inv9");
      invoiceTotal = 0;
      for (int i = 0; i < box.length; i++) {
        invoiceTotal = invoiceTotal + box.getAt(i)!.itemTotal!;
      }
    } else if (initPosition == 9) {
      box = Boxes.getItemForSell("inv10");
      invoiceTotal = 0;
      for (int i = 0; i < box.length; i++) {
        invoiceTotal = invoiceTotal + box.getAt(i)!.itemTotal!;
      }
    }
  }

  void clearInvoice(int initPosition) {
    if (initPosition == 0) {
      box = Boxes.getItemForSell("inv1");
      box.clear();
    } else if (initPosition == 1) {
      box = Boxes.getItemForSell("inv2");
      box.clear();
    } else if (initPosition == 2) {
      box.clear();
    } else if (initPosition == 3) {
      box = Boxes.getItemForSell("inv4");
      box.clear();
    } else if (initPosition == 4) {
      box = Boxes.getItemForSell("inv5");
      box.clear();
    } else if (initPosition == 5) {
      box = Boxes.getItemForSell("inv6");
      box.clear();
    } else if (initPosition == 6) {
      box = Boxes.getItemForSell("inv7");
      box.clear();
    } else if (initPosition == 7) {
      box = Boxes.getItemForSell("inv8");
      box.clear();
    } else if (initPosition == 8) {
      box = Boxes.getItemForSell("inv9");
      box.clear();
    } else if (initPosition == 9) {
      box = Boxes.getItemForSell("inv10");
      box.clear();
    }
  }

  void updateItemsList(int initPosition,) {
    if (initPosition == 0) {
      box = Boxes.getItemForSell("inv1");

      if (box.containsKey(searchControler.text.trim())) {
        var x = box.get(searchControler.text.trim())!.itemCount;
        final newMedicine = ItemForSell()
          ..barcode = searchControler.text.trim()
          ..medName = items.get(searchControler.text.trim())!.medName
          ..sicNote = items.get(searchControler.text.trim())!.sicNote
          ..docNote = items.get(searchControler.text.trim())!.docNote
          ..itemCount = x! + 1
          ..itemTotal =
              (x + 1) * items.get(searchControler.text.trim())!.selPrice!
          ..selPrice = items.get(searchControler.text.trim())!.selPrice;

        box.put(searchControler.text.trim(), newMedicine);
        setState(() {
          invoiceTotal = 0;
          for (int i = 0; i < box.length; i++) {
            invoiceTotal = invoiceTotal + box.getAt(i)!.itemTotal!;
          }
        });
        searchControler.clear();
        searchFocusNode.requestFocus();
      } else {
        var x = 1;
        final newMedicine = ItemForSell()
          ..barcode = searchControler.text.trim()
          ..medName = items.get(searchControler.text.trim())!.medName
          ..sicNote = items.get(searchControler.text.trim())!.sicNote
          ..itemCount = x
          ..docNote = items.get(searchControler.text.trim())!.docNote
          ..itemTotal = x * items.get(searchControler.text.trim())!.selPrice!
          ..selPrice = items.get(searchControler.text.trim())!.selPrice;
        box.put(searchControler.text.trim(), newMedicine);
        setState(() {
          invoiceTotal = 0;
          for (int i = 0; i < box.length; i++) {
            invoiceTotal = invoiceTotal + box.getAt(i)!.itemTotal!;
          }
        });
        searchControler.clear();
        searchFocusNode.requestFocus();
      }
    } else if (initPosition == 1) {
      box = Boxes.getItemForSell("inv2");
      if (box.containsKey(searchControler.text.trim())) {
        var x = box.get(searchControler.text.trim())!.itemCount;
        final newMedicine = ItemForSell()
          ..barcode = searchControler.text.trim()
          ..medName = items.get(searchControler.text.trim())!.medName
          ..sicNote = items.get(searchControler.text.trim())!.sicNote
          ..docNote = items.get(searchControler.text.trim())!.docNote
          ..itemCount = x! + 1
          ..itemTotal =
              (x + 1) * items.get(searchControler.text.trim())!.selPrice!
          ..selPrice = items.get(searchControler.text.trim())!.selPrice;

        box.put(searchControler.text.trim(), newMedicine);
        setState(() {
          invoiceTotal = 0;
          for (int i = 0; i < box.length; i++) {
            invoiceTotal = invoiceTotal + box.getAt(i)!.itemTotal!;
          }
        });
        searchControler.clear();
        searchFocusNode.requestFocus();
      } else {
        var x = 1;
        final newMedicine = ItemForSell()
          ..barcode = searchControler.text.trim()
          ..medName = items.get(searchControler.text.trim())!.medName
          ..sicNote = items.get(searchControler.text.trim())!.sicNote
          ..itemCount = x
          ..docNote = items.get(searchControler.text.trim())!.docNote
          ..itemTotal = x * items.get(searchControler.text.trim())!.selPrice!
          ..selPrice = items.get(searchControler.text.trim())!.selPrice;
        box.put(searchControler.text.trim(), newMedicine);
        setState(() {
          invoiceTotal = 0;
          for (int i = 0; i < box.length; i++) {
            invoiceTotal = invoiceTotal + box.getAt(i)!.itemTotal!;
          }
        });
        searchControler.clear();
        searchFocusNode.requestFocus();
      }
    } else if (initPosition == 2) {
      box = Boxes.getItemForSell("inv3");

      if (box.containsKey(searchControler.text.trim())) {
        var x = box.get(searchControler.text.trim())!.itemCount;
        final newMedicine = ItemForSell()
          ..barcode = searchControler.text.trim()
          ..medName = items.get(searchControler.text.trim())!.medName
          ..sicNote = items.get(searchControler.text.trim())!.sicNote
          ..docNote = items.get(searchControler.text.trim())!.docNote
          ..itemCount = x! + 1
          ..itemTotal =
              (x + 1) * items.get(searchControler.text.trim())!.selPrice!
          ..selPrice = items.get(searchControler.text.trim())!.selPrice;

        box.put(searchControler.text.trim(), newMedicine);
        setState(() {
          invoiceTotal = 0;
          for (int i = 0; i < box.length; i++) {
            invoiceTotal = invoiceTotal + box.getAt(i)!.itemTotal!;
          }
        });
        searchControler.clear();
        searchFocusNode.requestFocus();
      } else {
        var x = 1;
        final newMedicine = ItemForSell()
          ..barcode = searchControler.text.trim()
          ..medName = items.get(searchControler.text.trim())!.medName
          ..sicNote = items.get(searchControler.text.trim())!.sicNote
          ..itemCount = x
          ..docNote = items.get(searchControler.text.trim())!.docNote
          ..itemTotal = x * items.get(searchControler.text.trim())!.selPrice!
          ..selPrice = items.get(searchControler.text.trim())!.selPrice;
        box.put(searchControler.text.trim(), newMedicine);
        setState(() {
          invoiceTotal = 0;
          for (int i = 0; i < box.length; i++) {
            invoiceTotal = invoiceTotal + box.getAt(i)!.itemTotal!;
          }
        });
        searchControler.clear();
        searchFocusNode.requestFocus();
      }
    } else if (initPosition == 3) {
      box = Boxes.getItemForSell("inv4");

      if (box.containsKey(searchControler.text.trim())) {
        var x = box.get(searchControler.text.trim())!.itemCount;
        final newMedicine = ItemForSell()
          ..barcode = searchControler.text.trim()
          ..medName = items.get(searchControler.text.trim())!.medName
          ..sicNote = items.get(searchControler.text.trim())!.sicNote
          ..docNote = items.get(searchControler.text.trim())!.docNote
          ..itemCount = x! + 1
          ..itemTotal =
              (x + 1) * items.get(searchControler.text.trim())!.selPrice!
          ..selPrice = items.get(searchControler.text.trim())!.selPrice;

        box.put(searchControler.text.trim(), newMedicine);
        setState(() {
          invoiceTotal = 0;
          for (int i = 0; i < box.length; i++) {
            invoiceTotal = invoiceTotal + box.getAt(i)!.itemTotal!;
          }
        });
        searchControler.clear();
        searchFocusNode.requestFocus();
      } else {
        var x = 1;
        final newMedicine = ItemForSell()
          ..barcode = searchControler.text.trim()
          ..medName = items.get(searchControler.text.trim())!.medName
          ..sicNote = items.get(searchControler.text.trim())!.sicNote
          ..itemCount = x
          ..docNote = items.get(searchControler.text.trim())!.docNote
          ..itemTotal = x * items.get(searchControler.text.trim())!.selPrice!
          ..selPrice = items.get(searchControler.text.trim())!.selPrice;
        box.put(searchControler.text.trim(), newMedicine);
        setState(() {
          invoiceTotal = 0;
          for (int i = 0; i < box.length; i++) {
            invoiceTotal = invoiceTotal + box.getAt(i)!.itemTotal!;
          }
        });
        searchControler.clear();
        searchFocusNode.requestFocus();
      }
    } else if (initPosition == 4) {
      box = Boxes.getItemForSell("inv5");
      if (box.containsKey(searchControler.text.trim())) {
        var x = box.get(searchControler.text.trim())!.itemCount;
        final newMedicine = ItemForSell()
          ..barcode = searchControler.text.trim()
          ..medName = items.get(searchControler.text.trim())!.medName
          ..sicNote = items.get(searchControler.text.trim())!.sicNote
          ..docNote = items.get(searchControler.text.trim())!.docNote
          ..itemCount = x! + 1
          ..itemTotal =
              (x + 1) * items.get(searchControler.text.trim())!.selPrice!
          ..selPrice = items.get(searchControler.text.trim())!.selPrice;

        box.put(searchControler.text.trim(), newMedicine);
        setState(() {
          invoiceTotal = 0;
          for (int i = 0; i < box.length; i++) {
            invoiceTotal = invoiceTotal + box.getAt(i)!.itemTotal!;
          }
        });
        searchControler.clear();
        searchFocusNode.requestFocus();
      } else {
        var x = 1;
        final newMedicine = ItemForSell()
          ..barcode = searchControler.text.trim()
          ..medName = items.get(searchControler.text.trim())!.medName
          ..sicNote = items.get(searchControler.text.trim())!.sicNote
          ..itemCount = x
          ..docNote = items.get(searchControler.text.trim())!.docNote
          ..itemTotal = x * items.get(searchControler.text.trim())!.selPrice!
          ..selPrice = items.get(searchControler.text.trim())!.selPrice;
        box.put(searchControler.text.trim(), newMedicine);
        setState(() {
          invoiceTotal = 0;
          for (int i = 0; i < box.length; i++) {
            invoiceTotal = invoiceTotal + box.getAt(i)!.itemTotal!;
          }
        });
        searchControler.clear();
        searchFocusNode.requestFocus();
      }
    } else if (initPosition == 5) {
      box = Boxes.getItemForSell("inv6");
      if (box.containsKey(searchControler.text.trim())) {
        var x = box.get(searchControler.text.trim())!.itemCount;
        final newMedicine = ItemForSell()
          ..barcode = searchControler.text.trim()
          ..medName = items.get(searchControler.text.trim())!.medName
          ..sicNote = items.get(searchControler.text.trim())!.sicNote
          ..docNote = items.get(searchControler.text.trim())!.docNote
          ..itemCount = x! + 1
          ..itemTotal =
              (x + 1) * items.get(searchControler.text.trim())!.selPrice!
          ..selPrice = items.get(searchControler.text.trim())!.selPrice;

        box.put(searchControler.text.trim(), newMedicine);
        setState(() {
          invoiceTotal = 0;
          for (int i = 0; i < box.length; i++) {
            invoiceTotal = invoiceTotal + box.getAt(i)!.itemTotal!;
          }
        });
        searchControler.clear();
        searchFocusNode.requestFocus();
      } else {
        var x = 1;
        final newMedicine = ItemForSell()
          ..barcode = searchControler.text.trim()
          ..medName = items.get(searchControler.text.trim())!.medName
          ..sicNote = items.get(searchControler.text.trim())!.sicNote
          ..itemCount = x
          ..docNote = items.get(searchControler.text.trim())!.docNote
          ..itemTotal = x * items.get(searchControler.text.trim())!.selPrice!
          ..selPrice = items.get(searchControler.text.trim())!.selPrice;
        box.put(searchControler.text.trim(), newMedicine);
        setState(() {
          invoiceTotal = 0;
          for (int i = 0; i < box.length; i++) {
            invoiceTotal = invoiceTotal + box.getAt(i)!.itemTotal!;
          }
        });
        searchControler.clear();
        searchFocusNode.requestFocus();
      }
    } else if (initPosition == 6) {
      box = Boxes.getItemForSell("inv7");

      if (box.containsKey(searchControler.text.trim())) {
        var x = box.get(searchControler.text.trim())!.itemCount;
        final newMedicine = ItemForSell()
          ..barcode = searchControler.text.trim()
          ..medName = items.get(searchControler.text.trim())!.medName
          ..sicNote = items.get(searchControler.text.trim())!.sicNote
          ..docNote = items.get(searchControler.text.trim())!.docNote
          ..itemCount = x! + 1
          ..itemTotal =
              (x + 1) * items.get(searchControler.text.trim())!.selPrice!
          ..selPrice = items.get(searchControler.text.trim())!.selPrice;

        box.put(searchControler.text.trim(), newMedicine);
        setState(() {
          invoiceTotal = 0;
          for (int i = 0; i < box.length; i++) {
            invoiceTotal = invoiceTotal + box.getAt(i)!.itemTotal!;
          }
        });
        searchControler.clear();
        searchFocusNode.requestFocus();
      } else {
        var x = 1;
        final newMedicine = ItemForSell()
          ..barcode = searchControler.text.trim()
          ..medName = items.get(searchControler.text.trim())!.medName
          ..sicNote = items.get(searchControler.text.trim())!.sicNote
          ..itemCount = x
          ..docNote = items.get(searchControler.text.trim())!.docNote
          ..itemTotal = x * items.get(searchControler.text.trim())!.selPrice!
          ..selPrice = items.get(searchControler.text.trim())!.selPrice;
        box.put(searchControler.text.trim(), newMedicine);
        setState(() {
          invoiceTotal = 0;
          for (int i = 0; i < box.length; i++) {
            invoiceTotal = invoiceTotal + box.getAt(i)!.itemTotal!;
          }
        });
        searchControler.clear();
        searchFocusNode.requestFocus();
      }
    } else if (initPosition == 7) {
      box = Boxes.getItemForSell("inv8");

      if (box.containsKey(searchControler.text.trim())) {
        var x = box.get(searchControler.text.trim())!.itemCount;
        final newMedicine = ItemForSell()
          ..barcode = searchControler.text.trim()
          ..medName = items.get(searchControler.text.trim())!.medName
          ..sicNote = items.get(searchControler.text.trim())!.sicNote
          ..docNote = items.get(searchControler.text.trim())!.docNote
          ..itemCount = x! + 1
          ..itemTotal =
              (x + 1) * items.get(searchControler.text.trim())!.selPrice!
          ..selPrice = items.get(searchControler.text.trim())!.selPrice;

        box.put(searchControler.text.trim(), newMedicine);
        setState(() {
          invoiceTotal = 0;
          for (int i = 0; i < box.length; i++) {
            invoiceTotal = invoiceTotal + box.getAt(i)!.itemTotal!;
          }
        });
        searchControler.clear();
        searchFocusNode.requestFocus();
      } else {
        var x = 1;
        final newMedicine = ItemForSell()
          ..barcode = searchControler.text.trim()
          ..medName = items.get(searchControler.text.trim())!.medName
          ..sicNote = items.get(searchControler.text.trim())!.sicNote
          ..itemCount = x
          ..docNote = items.get(searchControler.text.trim())!.docNote
          ..itemTotal = x * items.get(searchControler.text.trim())!.selPrice!
          ..selPrice = items.get(searchControler.text.trim())!.selPrice;
        box.put(searchControler.text.trim(), newMedicine);
        setState(() {
          invoiceTotal = 0;
          for (int i = 0; i < box.length; i++) {
            invoiceTotal = invoiceTotal + box.getAt(i)!.itemTotal!;
          }
        });
        searchControler.clear();
        searchFocusNode.requestFocus();
      }
    } else if (initPosition == 8) {
      box = Boxes.getItemForSell("inv9");

      if (box.containsKey(searchControler.text.trim())) {
        var x = box.get(searchControler.text.trim())!.itemCount;
        final newMedicine = ItemForSell()
          ..barcode = searchControler.text.trim()
          ..medName = items.get(searchControler.text.trim())!.medName
          ..sicNote = items.get(searchControler.text.trim())!.sicNote
          ..docNote = items.get(searchControler.text.trim())!.docNote
          ..itemCount = x! + 1
          ..itemTotal =
              (x + 1) * items.get(searchControler.text.trim())!.selPrice!
          ..selPrice = items.get(searchControler.text.trim())!.selPrice;

        box.put(searchControler.text.trim(), newMedicine);
        setState(() {
          invoiceTotal = 0;
          for (int i = 0; i < box.length; i++) {
            invoiceTotal = invoiceTotal + box.getAt(i)!.itemTotal!;
          }
        });
        searchControler.clear();
        searchFocusNode.requestFocus();
      } else {
        var x = 1;
        final newMedicine = ItemForSell()
          ..barcode = searchControler.text.trim()
          ..medName = items.get(searchControler.text.trim())!.medName
          ..sicNote = items.get(searchControler.text.trim())!.sicNote
          ..itemCount = x
          ..docNote = items.get(searchControler.text.trim())!.docNote
          ..itemTotal = x * items.get(searchControler.text.trim())!.selPrice!
          ..selPrice = items.get(searchControler.text.trim())!.selPrice;
        box.put(searchControler.text.trim(), newMedicine);
        setState(() {
          invoiceTotal = 0;
          for (int i = 0; i < box.length; i++) {
            invoiceTotal = invoiceTotal + box.getAt(i)!.itemTotal!;
          }
        });
        searchControler.clear();
        searchFocusNode.requestFocus();
      }
    } else if (initPosition == 9) {
      box = Boxes.getItemForSell("inv10");

      if (box.containsKey(searchControler.text.trim())) {
        var x = box.get(searchControler.text.trim())!.itemCount;
        final newMedicine = ItemForSell()
          ..barcode = searchControler.text.trim()
          ..medName = items.get(searchControler.text.trim())!.medName
          ..sicNote = items.get(searchControler.text.trim())!.sicNote
          ..docNote = items.get(searchControler.text.trim())!.docNote
          ..itemCount = x! + 1
          ..itemTotal =
              (x + 1) * items.get(searchControler.text.trim())!.selPrice!
          ..selPrice = items.get(searchControler.text.trim())!.selPrice;

        box.put(searchControler.text.trim(), newMedicine);
        setState(() {
          invoiceTotal = 0;
          for (int i = 0; i < box.length; i++) {
            invoiceTotal = invoiceTotal + box.getAt(i)!.itemTotal!;
          }
        });
        searchControler.clear();
        searchFocusNode.requestFocus();
      } else {
        var x = 1;
        final newMedicine = ItemForSell()
          ..barcode = searchControler.text.trim()
          ..medName = items.get(searchControler.text.trim())!.medName
          ..sicNote = items.get(searchControler.text.trim())!.sicNote
          ..itemCount = x
          ..docNote = items.get(searchControler.text.trim())!.docNote
          ..itemTotal = x * items.get(searchControler.text.trim())!.selPrice!
          ..selPrice = items.get(searchControler.text.trim())!.selPrice;
        box.put(searchControler.text.trim(), newMedicine);
        setState(() {
          invoiceTotal = 0;
          for (int i = 0; i < box.length; i++) {
            invoiceTotal = invoiceTotal + box.getAt(i)!.itemTotal!;
          }
        });
        searchControler.clear();
        searchFocusNode.requestFocus();
      }
    }
  }




}