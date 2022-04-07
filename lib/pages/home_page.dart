import 'package:badges/badges.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_app/boxes.dart';
import 'package:pharmacy_app/db/expireItems.dart';
import 'package:pharmacy_app/pages/expires_page.dart';
import 'package:pharmacy_app/pages/myNotes.dart';
import '../constant.dart';
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
  final expSoon = Boxes.getExpiresSoon();
   List<ExpireItems> filtered=[];
   int? count;

  var data = Boxes.getExpires();
  @override
  void initState() {
    // TODO: implement initState

    // checkExpire();

setState(() {
  
});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // checkExpire();
        setState(() {
var ff=data.values.where((element) => element.expired!.difference(DateTime.now()).inDays <11);
filtered=ff.toList();
count=filtered.length;
// filtered.sort((a,b)=>a.expired!.compareTo(b.expired!));

    });
    // expSoon.clear();

    DesktopWindow.setMinWindowSize(Size(1200, 800));

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
                posTop: width *0.1,
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
                posTop: width *0.1,
                title: "فاتورة\n جديدة",
                callbackAction: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => NewInvoice(),
                  ),
                ),
              ),
              MyButton(
                width: width * 0.17,
                height: width * 0.17,
                posRight: width * 0.5,
                posTop: width *0.1,
                title: "ملاحظاتي",
                callbackAction: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MyNotes(),
                  ),
                ),
              ),
              MyButton(
                width: width * 0.17,
                height: width * 0.17,
                posRight: width * 0.49,
                posTop: width * 0.3,
                title: "انتهاء\n الصلاحية",
                callbackAction: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ExpireSoon(),
                  ),
                ),
              ),
              Positioned(
                child: Badge(
                  padding: EdgeInsets.all(10),
                  badgeContent: Text('${count}'),
                ),
                right: width * 0.5,
                top: width * 0.33,
              ),
              MyButton(
                  width: width * 0.17,
                  height: width * 0.17,
                  posRight: width * 0.1,
                  posTop: width * 0.3,
                  title: "قائمة\n المواد",
                  callbackAction: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ItemsList()))),
              MyButton(
                width: width * 0.17,
                height: width * 0.17,
                posRight: width * 0.30,
                posTop: width * 0.3,
                title: "سجل\n الفواتير",
                callbackAction: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => InvoicesHistory())),
              ),
            ],
          ),
        ));
  }
}
