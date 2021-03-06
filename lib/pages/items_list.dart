import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pharmacy_app/db/medicine.dart';
import '../boxes.dart';
import '../constant.dart';
import '../pages/ItemInfo.dart';
import '../widget/text_field_widget.dart';

class ItemsList extends StatefulWidget {
  const ItemsList({Key? key}) : super(key: key);

  @override
  _ItemsListState createState() => _ItemsListState();
}

class _ItemsListState extends State<ItemsList> {
  TextEditingController textEditingController = TextEditingController();
  FocusNode textEditingFocusNode = FocusNode();

  var data = Boxes.getMedicine();
  var fireData = Firestore.instance.collection("Medicine");
  
  List<Medicine> filtered = [];

  void getDataFromFireStore() async {
 

    var subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult connectivityResult) async {
      // Got a new connectivity status!
      if (connectivityResult != ConnectivityResult.none) {
        data.clear();
        
        setState(() {
          EasyLoading.show(
            status: 'Get Data...',
            maskType: EasyLoadingMaskType.clear,
          );
        });
        var dataStore = await fireData.get();
        
        dataStore.forEach((element) {
          print(element);

          final newMedicine = Medicine()
            ..medName = element["medName"]
            ..docNote = element["docNote"]
            ..sicNote = element["sicNote"]
            ..boxPrice = element["boxPrice"]
            ..selPrice = element["sellPrice"];
          data.put(element.id, newMedicine);
        });
        setState(() {
          EasyLoading.showSuccess('Great Success!');
        });

        // I am connected to a mobile network.
      } else {
        // I am connected to a wifi network.
        AlertDialog(
          title: Text(
            "??????????",
            style: TextStyle(
              fontFamily: 'Tajawal',
              fontSize: 20,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.italic,
              color: fontColor,
            ),
          ),
          content: Text(
            "???? ?????? ???????????????? ???????? ?????????? ?????? ???????????????? ???????? ???????? ?????????????? !!!",
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
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getDataFromFireStore();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DesktopWindow.setMinWindowSize(Size(1050, 800));
    final orientation = MediaQuery.of(context).orientation;

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
            MyTextField(onSubmitted: (x){},
              onChange: (x) {
                var filteredUsers = data.values.where((user) =>
                  user.medName!.contains(x));
            setState(() {
                filtered = filteredUsers.toList();
            });
              },
              fontSize: width * 0.012,
              width: width * 0.5,
              height: height * 0.8,
              textEditingController: textEditingController,
              myFocusNode: textEditingFocusNode,
              callbackAction: () {},
              maxline: 1,
              posTop: height * 0.03,
              posRight: 50,
              title: "",
            ),
            Positioned(
              child: Container(
                  width: width * 0.7,
                  height: height,
                  child: ValueListenableBuilder(
                      valueListenable: data.listenable(),
                      builder: (context, box, widget) {
                        return GridView.builder(
                          itemCount:textEditingController.text==""?
                           data.length:filtered.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: 1.5,
                                  crossAxisCount:
                                      (orientation == Orientation.portrait)
                                          ? 3
                                          : 4),
                          itemBuilder: (BuildContext context, int index) {
                            return textEditingController.text==""? GestureDetector(
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ItemInfo(
                                      barcode:
                                          data.getAt(index)!.key.toString()),
                                ),
                              ),
                              child: Card(
                                color: backgroundColor,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Text(
                                        data
                                            .getAt(index)!
                                            .medName
                                            .toString(),
                                        style: TextStyle(
                                          fontFamily: 'Tajawal',
                                          fontSize: width * 0.0122,
                                          fontWeight: FontWeight.w700,
                                          color: fontColor,
                                        ),
                                      ),
                                    ),
                                    Divider(
                                   
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            data
                                                .getAt(index)!
                                                .selPrice
                                                .toString(),
                                            style: TextStyle(
                                              fontFamily: 'Tajawal',
                                              fontSize: width * 0.012,
                                              fontWeight: FontWeight.w700,
                                              color: fontColor,
                                            ),
                                          ),
                                          Text(
                                            "?????? ?????????? : ",
                                            style: TextStyle(
                                              fontFamily: 'Tajawal',
                                              fontSize: width * 0.012,
                                              fontWeight: FontWeight.w700,
                                              color: fontColor,
                                            ),
                                            textDirection: TextDirection.rtl,
                                          )
                                        ],
                                      ),
                                    ),
                                    Divider(
                                     
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            data
                                                .getAt(index)!
                                                .boxPrice
                                                .toString(),
                                            style: TextStyle(
                                              fontFamily: 'Tajawal',
                                              fontSize: width * 0.012,
                                              fontWeight: FontWeight.w700,
                                              color: fontColor,
                                            ),
                                          ),
                                          Text(
                                            "?????? ???????????? : ",
                                            style: TextStyle(
                                              fontFamily: 'Tajawal',
                                              fontSize: width * 0.012,
                                              fontWeight: FontWeight.w700,
                                              color: fontColor,
                                            ),
                                            textDirection: TextDirection.rtl,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                elevation: 5,
                              ),
                            ):GestureDetector(
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ItemInfo(
                                      barcode:
                                          data.getAt(index)!.key.toString()),
                                ),
                              ),
                              child: Card(
                                color: backgroundColor,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Text(
                                       filtered[index].medName.toString(),
                                        style: TextStyle(
                                          fontFamily: 'Tajawal',
                                          fontSize: width * 0.0122,
                                          fontWeight: FontWeight.w700,
                                          color: fontColor,
                                        ),
                                      ),
                                    ),
                                    Divider(
                                   
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                           filtered[index].selPrice.toString(),
                                            style: TextStyle(
                                              fontFamily: 'Tajawal',
                                              fontSize: width * 0.012,
                                              fontWeight: FontWeight.w700,
                                              color: fontColor,
                                            ),
                                          ),
                                          Text(
                                            "?????? ?????????? : ",
                                            style: TextStyle(
                                              fontFamily: 'Tajawal',
                                              fontSize: width * 0.012,
                                              fontWeight: FontWeight.w700,
                                              color: fontColor,
                                            ),
                                            textDirection: TextDirection.rtl,
                                          )
                                        ],
                                      ),
                                    ),
                                    Divider(
                                     
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                           filtered[index].boxPrice.toString(),
                                            style: TextStyle(
                                              fontFamily: 'Tajawal',
                                              fontSize: width * 0.012,
                                              fontWeight: FontWeight.w700,
                                              color: fontColor,
                                            ),
                                          ),
                                          Text(
                                            "?????? ???????????? : ",
                                            style: TextStyle(
                                              fontFamily: 'Tajawal',
                                              fontSize: width * 0.012,
                                              fontWeight: FontWeight.w700,
                                              color: fontColor,
                                            ),
                                            textDirection: TextDirection.rtl,
                                          )
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
                      })),
              top: height * 0.15,
              right: 50,
            )
          ],
        ),
      ),
    );
  }
}
