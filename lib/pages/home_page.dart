import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_app/constant.dart';
import '../pages/add_item_page.dart';
import '../pages/new_invoice.dart';
import '../widget/button_widget.dart';
import 'invoice_history.dart';
import 'items_list.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
              MyButton(
                width: width * 0.17,
                height: width * 0.17,
                posRight: width * 0.1,
                posTop: width * 0.14,
                title: "أضافة \n دواء جديد",
                callbackAction: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AddNewItem(),
                  ),
                ),
              ),
              MyButton(
                  width: width * 0.17,
                  height: width * 0.17,
                  posRight: width * 0.30,
                  posTop: width * 0.14,
                  title: "فاتورة\n جديدة",
                  callbackAction: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => NewInvoice()))),
              MyButton(
                  width: width * 0.17,
                  height: width * 0.17,
                  posRight: width * 0.1,
                  posTop: width * 0.35,
                  title: "قائمة\n المواد",
                  callbackAction: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ItemsList()))),
              MyButton(
                  width: width * 0.17,
                  height: width * 0.17,
                  posRight: width * 0.30,
                  posTop: width * 0.35,
                  title: "سجل\n الفواتير",
                  callbackAction: () => Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => InvoicesHistory()))),
            ],
          ),
        ));
  }
}
