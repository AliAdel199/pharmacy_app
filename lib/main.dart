
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../db/invoice.dart';
import '../db/item_for_sell.dart';
import '../db/medicine.dart';


import 'pages/home_page.dart';

const apiKey = 'AIzaSyBIJefPHqhfp7isoQ3aJ4wKcVvEw-6Rsjo';
const projectId = 'chatapp-44b87';
const email = 'you@server.com';
const password = '123123';


void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.squareCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false
  ..customAnimation=CustomAnimation();
}
void main() async{
  // await DesktopWindow.setMinWindowSize(Size(500,500));
  WidgetsFlutterBinding.ensureInitialized();
    Firestore.initialize("pharmacy-940a1"); // Firestore reuses the auth client
  await Hive.initFlutter();
  // await DesktopWindow.setMinWindowSize(Size(500,500));
  // Size size = await DesktopWindow.getWindowSize();
  //     print(size);
  Hive.registerAdapter(MedicineAdapter());
  Hive.registerAdapter(ItemForSellAdapter());
  Hive.registerAdapter(InvoiceAdapter());
  await Hive.openBox<Medicine>('medicine');
  await Hive.openBox<ItemForSell>('itemForSell');
  await Hive.openBox<ItemForSell>('inv1');
  await Hive.openBox<ItemForSell>('inv2');
  await Hive.openBox<ItemForSell>('inv3');
  await Hive.openBox<ItemForSell>('inv4');
  await Hive.openBox<ItemForSell>('inv5');
  await Hive.openBox<ItemForSell>('inv6');
  await Hive.openBox<ItemForSell>('inv7');
  await Hive.openBox<ItemForSell>('inv8');
  await Hive.openBox<ItemForSell>('inv9');
  await Hive.openBox<ItemForSell>('inv10');
  await Hive.openBox<Invoice>('invoice');
  // await Hive.openBox('test');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}


class CustomAnimation extends EasyLoadingAnimation {
  CustomAnimation();

  @override
  Widget buildWidget(
      Widget child,
      AnimationController controller,
      AlignmentGeometry alignment,
      ) {
    return Opacity(
      opacity: controller.value,
      child: RotationTransition(
        turns: controller,
        child: child,
      ),
    );
  }
}