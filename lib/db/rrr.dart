// import 'dart:ffi';
// import 'dart:io';
// import 'dart:typed_data';
//
// import 'package:flutter/services.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart';
// import 'package:printing/printing.dart';
// import 'package:pdf/widgets.dart' as pw;
//
// import '../boxes.dart';
//
// final box = Boxes.getInvoice();
//
// List items = box.values.last.invItems!;
//
// Future generateAndPrintArabicPdf() async {
//   final Document pdf = Document();
//
//   var arabicFont = Font.ttf(await rootBundle.load('fonts/Tajawal-Bold.ttf'));
//   pdf.addPage(Page(
//       theme: ThemeData.withFont(
//         base: arabicFont,
//       ),
//       pageFormat: PdfPageFormat.a5,
//       build: (Context context) {
//         return Center(
//             child: Column(children: [
//           Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//             pw.SizedBox(
//               width: 150,
//               child: Directionality(
//                 textDirection: TextDirection.rtl,
//                 child: Center(
//                   child: Text(
//                     ' ${box.values.last.invItems!.last.sicNote} ',
//                     style: TextStyle(
//                       fontSize: 4,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Directionality(
//                 textDirection: TextDirection.rtl,
//                 child: Center(
//                     child: Text('الفرع : ',
//                         style: TextStyle(
//                           fontSize: 10,
//                         )))),
//           ]),
//           Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//             Directionality(
//                 textDirection: TextDirection.rtl,
//                 child: Center(
//                     child: Text('  01231324234  ',
//                         style: TextStyle(
//                           fontSize: 10,
//                         )))),
//             Directionality(
//                 textDirection: TextDirection.rtl,
//                 child: Center(
//                     child: Text('الرقم الضريبي : ',
//                         style: TextStyle(
//                           fontSize: 10,
//                         )))),
//           ]),
//           Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//             Directionality(
//                 textDirection: TextDirection.rtl,
//                 child: Center(
//                     child: Text('  حي الخليج - الرياض ',
//                         style: TextStyle(
//                           fontSize: 10,
//                         )))),
//             Directionality(
//                 textDirection: TextDirection.rtl,
//                 child: Center(
//                     child: Text('الموقع : ',
//                         style: TextStyle(
//                           fontSize: 10,
//                         )))),
//           ]),
//           Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//             Directionality(
//                 textDirection: TextDirection.rtl,
//                 child: Center(
//                     child: Text('  0123456789 ',
//                         style: TextStyle(
//                           fontSize: 10,
//                         )))),
//             Directionality(
//                 textDirection: TextDirection.rtl,
//                 child: Center(
//                     child: Text('هاتف : ',
//                         style: TextStyle(
//                           fontSize: 10,
//                         )))),
//           ]),
//           Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//             Directionality(
//                 textDirection: TextDirection.rtl,
//                 child: Center(
//                     child: Text('  1  ',
//                         style: TextStyle(
//                           fontSize: 10,
//                         )))),
//             Directionality(
//                 textDirection: TextDirection.rtl,
//                 child: Center(
//                     child: Text('رقم الفاتورة : ',
//                         style: TextStyle(
//                           fontSize: 10,
//                         )))),
//           ]),
//           Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//             Directionality(
//                 textDirection: TextDirection.rtl,
//                 child: Center(
//                     child: Text('  خالد  ',
//                         style: TextStyle(
//                           fontSize: 10,
//                         )))),
//             Directionality(
//                 textDirection: TextDirection.rtl,
//                 child: Center(
//                     child: Text('اسم العميل : ',
//                         style: TextStyle(
//                           fontSize: 10,
//                         )))),
//           ]),
//           Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//             Directionality(
//                 textDirection: TextDirection.rtl,
//                 child: Center(
//                     child: Text('  0506040215 ',
//                         style: TextStyle(
//                           fontSize: 10,
//                         )))),
//             Directionality(
//                 textDirection: TextDirection.rtl,
//                 child: Center(
//                     child: Text('رقم هاتف العميل : ',
//                         style: TextStyle(
//                           fontSize: 10,
//                         )))),
//           ]),
//           Directionality(
//               textDirection: TextDirection.rtl,
//               child: Text('المشتريات', style: TextStyle(fontSize: 10))),
//           Container(
//             margin: EdgeInsets.fromLTRB(22, 5, 22, 5),
//             child: Directionality(
//               textDirection: TextDirection.rtl,
//               child: Table.fromTextArray(
//                   headerStyle: TextStyle(fontSize: 6),
//                   headers: <dynamic>['الإجمالي', 'العدد', 'الخدمة', 'القطعة'],
//                   cellAlignments: {
//
//                     1: pw.Alignment.centerRight,
//                     2: pw.Alignment.centerRight,
//                     3: pw.Alignment.centerRight,
//                   },
//                   cellStyle: TextStyle(fontSize: 5),
//                   columnWidths: {
//                     0: FixedColumnWidth(300.0),
//                     1:FixedColumnWidth(100.0),
//                     2: FixedColumnWidth(100.0),
//                     3: FixedColumnWidth(100.0),
//                   },
//                   data: List<List<String>>.generate(
//                     items.length,
//                     (row) => List<String>.generate(
//                       4,
//                       (col) => items[row].getIndex(col),
//                     ),
//                   )),
//             ),
//           ),
//           Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//             Directionality(
//                 textDirection: TextDirection.rtl,
//                 child: Center(
//                     child: Text('  50  ',
//                         style: TextStyle(
//                           fontSize: 10,
//                         )))),
//             Directionality(
//                 textDirection: TextDirection.rtl,
//                 child: Center(
//                     child: Text('المجموع الفرعي : ',
//                         style: TextStyle(
//                           fontSize: 10,
//                         )))),
//           ]),
//           Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//             Directionality(
//                 textDirection: TextDirection.rtl,
//                 child: Center(
//                     child: Text('  -20  ',
//                         style: TextStyle(
//                           fontSize: 10,
//                         )))),
//             Directionality(
//                 textDirection: TextDirection.rtl,
//                 child: Center(
//                     child: Text('خصم العميل : ',
//                         style: TextStyle(
//                           fontSize: 10,
//                         )))),
//           ]),
//           Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//             Directionality(
//                 textDirection: TextDirection.rtl,
//                 child: Center(
//                     child: Text('  1  ',
//                         style: TextStyle(
//                           fontSize: 10,
//                         )))),
//             Directionality(
//                 textDirection: TextDirection.rtl,
//                 child: Center(
//                     child: Text('خصم عددي : ',
//                         style: TextStyle(
//                           fontSize: 10,
//                         )))),
//           ]),
//           Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//             Directionality(
//                 textDirection: TextDirection.rtl,
//                 child: Center(
//                     child: Text('  29  ',
//                         style: TextStyle(
//                           fontSize: 10,
//                         )))),
//             Directionality(
//                 textDirection: TextDirection.rtl,
//                 child: Center(
//                     child: Text('الإجمالي : ',
//                         style: TextStyle(
//                           fontSize: 10,
//                         )))),
//           ]),
//           Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//             Directionality(
//                 textDirection: TextDirection.rtl,
//                 child: Center(
//                     child: Text('  مدفوعة  ',
//                         style: TextStyle(
//                           fontSize: 10,
//                         )))),
//             Directionality(
//                 textDirection: TextDirection.rtl,
//                 child: Center(
//                     child: Text('حالة الفاتورة : ',
//                         style: TextStyle(
//                           fontSize: 10,
//                         )))),
//           ]),
//           Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//             Directionality(
//                 textDirection: TextDirection.rtl,
//                 child: Center(
//                     child: Text('  نقدا  ',
//                         style: TextStyle(
//                           fontSize: 10,
//                         )))),
//             Directionality(
//                 textDirection: TextDirection.rtl,
//                 child: Center(
//                     child: Text('طريقة الدفع : ',
//                         style: TextStyle(
//                           fontSize: 10,
//                         )))),
//           ]),
//         ]));
//       }));
//   final String dir = (await getApplicationDocumentsDirectory()).path;
//   final String path = '$dir/1.pdf';
//   final File file = File(path);
//   file.writeAsBytes(await pdf.save());
//
//   return pdf.save();
//   // await Printing.layoutPdf(
//   //     onLayout: (PdfPageFormat format) async => pdf.save());
// }
//
// Future<Uint8List> generateInvoice(PdfPageFormat pageFormat) async {
//   return await generateAndPrintArabicPdf();
// }
