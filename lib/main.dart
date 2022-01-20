
import 'package:desktop_window/desktop_window.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pharmacy_app/db/invoice.dart';
import 'package:pharmacy_app/db/item_for_sell.dart';
import 'package:pharmacy_app/db/medicine.dart';


import 'pages/home_page.dart';

const apiKey = 'AIzaSyBIJefPHqhfp7isoQ3aJ4wKcVvEw-6Rsjo';
const projectId = 'chatapp-44b87';
const email = 'you@server.com';
const password = '123123';

// Future main() async {
//   FirebaseAuth.initialize(apiKey, VolatileStore());
//   Firestore.initialize(projectId); // Firestore reuses the auth client
//
//   var auth = FirebaseAuth.instance;
//   // Monitor sign-in state
//   auth.signInState.listen((state) => print("Signed ${state ? "in" : "out"}"));
//
//   // Sign in with user credentials
//   await auth.signIn(email, password);
//
//
//   // Get user object
//   var user = await auth.getUser();
//   print(user);
//
//   // Instantiate a reference to a document - this happens offline
//   var ref = Firestore.instance.collection('test').document('doc');
//
//   // Subscribe to changes to that document
//   ref.stream.listen((document) => print('updated: $document'));
//
//   // Update the document
//   await ref.update({'value': 'test'});
//
//   // Get a snapshot of the document
//   var document = await ref.get();
//   print('snapshot: ${document['value']}');
//
//   auth.signOut();
//
//   // Allow some time to get the signed out event
//   await Future.delayed(Duration(seconds: 1));
//
//
// }

void main() async{
  // await DesktopWindow.setMinWindowSize(Size(500,500));
  WidgetsFlutterBinding.ensureInitialized();

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
