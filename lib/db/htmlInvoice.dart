// import 'dart:typed_data';
//
// import 'package:flutter/services.dart';
// import 'package:intl/intl.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:pharmacy_app/boxes.dart';
// import 'package:pharmacy_app/db/item_for_sell.dart';
// import 'package:printing/printing.dart';
//
// //
// final box = Boxes.getInvoice();
//
//
//
// class HtmlInvoice {
//   HtmlInvoice({required this.items,
//     required this.invoiceNumber,
//     required this.total,
//     required this.date,
//     required this.time});
//
//   List<ItemForSell> items;
//   final String invoiceNumber;
//   final int total;
//   final DateTime date;
//   final DateTime time;
//
// }
//
//   String generateHtmlA(HtmlInvoice p) {
//     String items = '''
//     ''';
//
//     for (var i = 0; i < p.items.length; i++) {
//       //
//       // final String formatted = datee.format(forFormat);
//       // double amount = p.list[i].debitAmount + p.list[i].payableAmount;
//       items += '''<tr class = "item">''';
//
//       items += '''<td>${p.items[i].medName}</td>''';
//       items += '''<td>${p.items[i].itemCount}</td>''';
//       items += '''<td>${p.items[i].selPrice}</td>''';
//       items += '''<td>${p.items[i].itemTotal}</td>''';
//       items += '''<td>${p.items[i].sicNote}</td>''';
//       items += '''</tr>''';
//     }
//     var html = """ <!DOCTYPE html>
// <html>
// <head>
// <meta name="viewport" content="width=device-width, initial-scale=1">
// <link rel="stylesheet" href=
// "https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css" />
//     <style>
//
//       .invoice-box {
//         max-width:1000px;
//         margin: auto;
//         padding: 8px;
//         border: 1px solid #eee;
//         box-shadow: 0 0 10px rgba(0, 0, 0, 0.15);
//         font-size: 8px;
//         line-height: 24px;
//         font-family: 'Helvetica Neue', 'Helvetica', Helvetica, Arial, sans-serif;
//         color: #555;
//       }
//         .invoice-box table {
//         width: 100%;
//         line-height: inherit;
//         text-align: center;
//       }
//
//       .invoice-box table td {
//         padding: 10px;
//         vertical-align: top;
//       }
//
//       .invoice-box table tr.top table td {
//         padding-bottom: 5px;
//       }
//
// * {
//   box-sizing: border-box;
// }
//
//
// .column {
//   float: right;
//   width:23%;
//
//   padding: 16px;
//
// }
// .header{
// text-align:center;
// }
//
//
// .row:after {
//   content: "";
//   display: table;
//   clear: both;
// }
//
// </style>
// </head>
// <body>
// <h2 class="header">كشف حساب</h2>
// <h3 class="header">بيانات الزبون</h3>
// <table>
// <tr>
// <div class="row">
//   <div class="column" >
//     <h4>المبلغ</h4>
//     <p></p>
//   </div>
//
//   <div class="column" >
//
//     <h4>نوع العملية</h4>
//
//   </div>
//
//   <div class="column" >
//     <h4>تاريخ</h4>
//
//   </div>
//   <div class="column" >
//     <h4>وصف</h4>
//
//   </div>
// </div>
// </tr>
// $items
// </table>
// <div>
// <p class="header">------------------------</p>
// <p class="header">:مجموع ${p.date}</p>
// <p class="header">:مجموع ${p.total}</p>
// <p class="header">:المبلغ ${p.total}</p>
// <p>---</p>
// <p>--</p>
// <p>-</p>
// </div>
// </body>
// </html>""";
//
//     return html;
//   }
// generateInvoice(HtmlInvoice pageFormat ) async {
//
//    await Printing.layoutPdf(
//     onLayout: (format) async => await Printing.convertHtml(
//       format: format,
//       html: generateHtmlA(pageFormat),
//     ),
//   );
//
// }
