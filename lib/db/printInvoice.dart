import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

import '../boxes.dart';
import 'item_for_sell.dart';

final box = Boxes.getInvoice();

Future<Uint8List> generateInvoice(PdfPageFormat pageFormat) async {
  final invoice = PrintInvice(
      items: box.values.last.invItems!,
      invoiceNumber: (box.length).toString(),
      accentColor: PdfColors.grey800,
      baseColor: PdfColors.white,
      total: box.values.last.invTotal!,
      date: DateFormat('yyyy-MM-dd – kk:mm').format(box.values.last.invDate!),
      time: box.values.last.invTime!);

  return await invoice.buildPdf(PdfPageFormat.a5);
}

class PrintInvice {
  PrintInvice(
      {required this.items,
      required this.invoiceNumber,
      required this.accentColor,
      required this.baseColor,
      required this.total,
      required this.date,
      required this.time});

  List<ItemForSell> items;
  final String invoiceNumber;
  final int total;
  final String date;
  final DateTime time;
  final PdfColor baseColor;
  final PdfColor accentColor;

  String? _logo;

  String? _bgShape;

  Future<Uint8List> buildPdf(PdfPageFormat pageFormat) async {
    final doc = pw.Document();
    _logo = await rootBundle.loadString('images/logo.svg');

    // _bgShape = await rootBundle.loadString('assets/invoice.svg');
    final ttf = await fontFromAssetBundle('fonts/Tajawal-Bold.ttf');
    doc.addPage(
      pw.MultiPage(
        pageTheme: _buildTheme(
          PdfPageFormat.a5,
          await ttf,
          await ttf,
          await ttf,
        ),
        header: _buildHeader,
        footer: _buildFooter,
        build: (context) => [
          _contentHeader(context),
          _contentTable(context),
          pw.SizedBox(height: 10),
          _contentFooter(context),
        ],
      ),
    );

    return doc.save();
  }

  pw.Widget _buildHeader(pw.Context context) {
    return pw.Column(
      children: [
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          mainAxisAlignment: pw.MainAxisAlignment.center,
          children: [
            pw.Expanded(
              child: pw.Column(
                children: [
                  pw.Container(
                    height: 15,
                    padding: const pw.EdgeInsets.only(left: 10),
                    alignment: pw.Alignment.centerLeft,
                    child: pw.Text(
                      'INVOICE',
                      textDirection: pw.TextDirection.rtl,
                      style: pw.TextStyle(
                        color: accentColor,
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  pw.Container(
                    decoration: pw.BoxDecoration(
                      borderRadius:
                          const pw.BorderRadius.all(pw.Radius.circular(2)),
                      color: accentColor,
                    ),
                    padding: const pw.EdgeInsets.only(
                        left: 10, top: 10, bottom: 10, right: 20),
                    alignment: pw.Alignment.center,
                    height: 50,
                    child: pw.DefaultTextStyle(
                      style: pw.TextStyle(
                        color: baseColor,
                        fontSize: 12,
                      ),
                      child: pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Row(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceEvenly,
                              children: [
                                pw.Text(
                                  'Invoice :',
                                  // textDirection: pw.TextDirection.rtl,
                                ),
                                pw.Text(
                                  invoiceNumber,
                                  textDirection: pw.TextDirection.rtl,
                                ),
                              ]),
                          pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceEvenly,
                              children: [
                                pw.Text('Date:  ',
                                    textDirection: pw.TextDirection.rtl,
                                    style: pw.TextStyle(fontSize: 8)),
                                pw.Text(date,
                                    textDirection: pw.TextDirection.rtl,
                                    style: pw.TextStyle(fontSize: 8)),
                              ])
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            pw.Expanded(
              child: pw.Column(
                mainAxisSize: pw.MainAxisSize.min,
                children: [
                  pw.Container(
                    alignment: pw.Alignment.bottomCenter,
                    padding:
                        const pw.EdgeInsets.only(bottom: 0, left: 1, top: 35),
                    height: 100,
                    // padding: pw.EdgeInsets.only(top: 20),
                    child: _logo != null
                        ? pw.SvgImage(svg: _logo!)
                        : pw.FlutterLogo(),
                  ),
                  // pw.Container(
                  //   color: baseColor,
                  //   padding: pw.EdgeInsets.only(top: 3),
                  // ),
                ],
              ),
            ),
          ],
        ),
        if (context.pageNumber > 1) pw.SizedBox(height: 20)
      ],
    );
  }

  pw.Widget _buildFooter(pw.Context context) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Container(
          height: 20,
          width: 100,
          child: pw.BarcodeWidget(
            barcode: pw.Barcode.pdf417(),
            data: 'Invoice:  $invoiceNumber',
            drawText: false,
          ),
        ),
        // pw.Text(
        //   'Page ${context.pageNumber}/${context.pagesCount}',
        //   style: const pw.TextStyle(
        //     fontSize: 12,
        //     color: PdfColors.white,
        //   ),
        // ),
      ],
    );
  }

  pw.PageTheme _buildTheme(
      PdfPageFormat pageFormat, pw.Font base, pw.Font bold, pw.Font italic) {
    return pw.PageTheme(
      pageFormat: pageFormat,
      textDirection: pw.TextDirection.rtl,
      orientation: pw.PageOrientation.portrait,

      theme: pw.ThemeData.withFont(
        base: base,
        bold: bold,
        italic: italic,
      ),
      // buildBackground: (context) =>
      //     pw.FullPage(
      //       ignoreMargins: true,
      //       child: pw.SvgImage(svg: _bgShape!),
      //     ),
    );
  }

  pw.Widget _contentHeader(pw.Context context) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // pw.SizedBox(height: 20),
        pw.Container(
          margin: const pw.EdgeInsets.only(top: 1),
          height: 30,
          child: pw.Text(
            'Total: ${total}',
            textDirection: pw.TextDirection.rtl,
            style: pw.TextStyle(
                color: accentColor,
                fontStyle: pw.FontStyle.italic,
                fontSize: 18),
          ),
        ),
      ],
    );
  }

  pw.Widget _contentTable(pw.Context context) {
    const tableHeaders = [
      'ملاحظات للمريض',
      'الاجمالي',
      'السعر',
      'الكمية',
      'الدواء'
    ];

    return pw.Table.fromTextArray(
      border: null,
      // cellAlignment: pw.Alignment.centerRight,

      headerDecoration: pw.BoxDecoration(
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(2)),
        color: accentColor,
      ),
      headerHeight: 20,
      cellHeight: 15,
      // cellPadding: pw.EdgeInsets.all(),
      headerPadding: pw.EdgeInsets.all(0),
      headerAlignments: {
        0: pw.Alignment.center,
        1: pw.Alignment.center,
        2: pw.Alignment.center,
        3: pw.Alignment.center,
        4: pw.Alignment.center,
      },

      cellAlignments: {
        1: pw.Alignment.centerRight,
        2: pw.Alignment.centerRight,
        3: pw.Alignment.centerRight,
        4: pw.Alignment.centerRight,
      },
      columnWidths: {
        0: FixedColumnWidth(300.0),
        1: FixedColumnWidth(75.0),
        2: FixedColumnWidth(75.0),
        3: FixedColumnWidth(50.0),
        4: FixedColumnWidth(100.0),
      },
      headerStyle: pw.TextStyle(
          color: baseColor,
          fontSize: 6,
          fontWeight: pw.FontWeight.bold,
          fontStyle: pw.FontStyle.normal),
      cellStyle: const pw.TextStyle(
          // color: accentColor,
          fontSize: 6,
          lineSpacing: 2),
      rowDecoration: pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(
            color: accentColor,
            width: .5,
          ),
        ),
      ),
      headers: List<String>.generate(
        tableHeaders.length,
        (col) => tableHeaders[col],
      ),
      data: List<List<String>>.generate(
        items.length,
        (row) => List<String>.generate(
          tableHeaders.length,
          (col) => items[row].getIndex(col),
        ),
      ),
    );
  }

  pw.Widget _contentFooter(pw.Context context) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          flex: 2,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Text(
                'تمنياتنا لكم بالشفاء العاجل',
                // textDirection: pw.TextDirection.,
                style: pw.TextStyle(
                    color: accentColor,
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 8),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
