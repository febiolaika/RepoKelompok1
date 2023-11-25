import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:ugd6_1217/preview_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ugd6_1217/entity/Product.dart';
import 'package:ugd6_1217/page/product_input_page.dart';

Future<void> createPdf(
  TextEditingController namaController,
  TextEditingController hargaController,
  TextEditingController durasiController,
  String id,
  String dropDown,
  BuildContext context,
) async {
  final doc = pw.Document();
  final now = DateTime.now();
  final formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

  final pdfTheme = pw.PageTheme(
    pageFormat: PdfPageFormat.a4,
    buildBackground: (pw.Context context) {
      return pw.Container(
        decoration: pw.BoxDecoration(
          border: pw.Border.all(
            color: PdfColor.fromHex('#FFBD59'),
            width: 1.w,
          ),
        ),
      );
    },
  );
  // Other existing code...

  doc.addPage(
    pw.MultiPage(
      pageTheme: pdfTheme,
      header: (pw.Context context) {
        return headerPDF();
      },
      build: (pw.Context context) {
        return [
          pw.Center(
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.SizedBox(height: 10.h),
                pw.SizedBox(height: 10.h),
                personalDataFromInput(namaController, hargaController, durasiController),
                pw.SizedBox(height: 10.h),
                topOfInvoice(dropDown),
                barcodeGaris(id),
                pw.SizedBox(height: 5.h),
                barcodeKotak(id),
                pw.SizedBox(height: 1.h),
              ],
            ),
          ),
        ];
      },
      footer: (pw.Context context) {
        return pw.Container(
          color: PdfColor.fromHex('#FFBD59'),
          child: footerPDF(formattedDate),
        );
      },
    ),
  );

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PreviewScreen(doc: doc),
    ),
  );
}


pw.Header headerPDF() {
  return pw.Header(
    margin: pw.EdgeInsets.zero,
    outlineColor: PdfColors.amber50,
    outlineStyle:
PdfOutlineStyle.normal,
    level: 5,
    decoration: pw.BoxDecoration(
      shape: pw.BoxShape.rectangle,
      gradient: pw.LinearGradient(
        colors: [
          PdfColor.fromHex('#FCDF8A'),
          PdfColor.fromHex('#F38381')
        ],
        begin: pw.Alignment.topLeft,
        end: pw.Alignment.bottomRight,
      ),
    ),
    child: pw.Center(
      child: pw.Text(
        '-Salon-',
        style: pw.TextStyle(
          fontWeight:
  pw.FontWeight.bold,
          fontSize: 12.sp,
        ),
      ),
    )
  );
}



pw.Padding personalDataFromInput(TextEditingController namaController, TextEditingController hargaController, TextEditingController durasiController) 
{
  return pw.Padding(
                    padding: 
                        pw.EdgeInsets.symmetric(horizontal: 5.h, vertical: 1.h),
                    child: pw.Table(
                      border: pw.TableBorder.all(),
                      children: [
                        pw.TableRow(
                          children: [
                            pw.Padding(
                              padding: pw.EdgeInsets.symmetric(
                                  horizontal: 1.h, vertical: 1.h),
                              child: pw.Text(
                                'Nama',
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 10.sp,
                                ),
                              ),
                            ),
                            pw.Padding(
                              padding: pw.EdgeInsets.symmetric(
                                  horizontal: 1.h, vertical: 1.h),
                              child: pw.Text(
                                namaController.text,
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 10.sp,
                                ),
                              ),
                            ),
                          ],
                        ),

                        pw.TableRow(
                          children: [
                            pw.Padding(
                              padding: pw.EdgeInsets.symmetric(
                                  horizontal: 1.h, vertical: 1.h),
                              child: pw.Text(
                                'Harga',
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 10.sp,
                                ),
                              ),
                            ),
                            pw.Padding(
                              padding: pw.EdgeInsets.symmetric(
                                  horizontal: 1.h, vertical: 1.h),
                              child: pw.Text(
                                hargaController.text,
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 10.sp,
                                ),
                              ),
                            ),
                          ],
                        ),

                        pw.TableRow(
                          children: [
                            pw.Padding(
                              padding: pw.EdgeInsets.symmetric(
                                  horizontal: 1.h, vertical: 1.h),
                              child: pw.Text(
                                'Durasi',
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 10.sp,
                                ),
                              ),
                            ),
                            pw.Padding(
                              padding: pw.EdgeInsets.symmetric(
                                  horizontal: 1.h, vertical: 1.h),
                              child: pw.Text(
                                durasiController.text,
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 10.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
}

pw.Padding topOfInvoice(String dropDown) {
  return pw.Padding(
                    padding: const pw.EdgeInsets.all(8.0),
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                          pw.Expanded(child: 
                            pw.Container(
                              height: 10.h,
                              decoration: const pw.BoxDecoration(borderRadius:
pw.BorderRadius.all(pw.Radius.circular(2)),color: PdfColors.amberAccent),
                              padding: const pw.EdgeInsets.only(left: 40, top: 10, bottom: 10, right: 40),
                              alignment: pw.Alignment.centerLeft,
                              child:
                              pw.DefaultTextStyle(
                                style: const pw.TextStyle(color:PdfColors.amber100, fontSize: 12),
                                child: pw.GridView(
                                  crossAxisCount: 2,
                                  children: [
                                    pw.Text('Awesome Product',
                                            style: pw.TextStyle( fontSize: 10.sp, color: PdfColors.blue800)),
                                    pw.Text('Anggrek Street 12',
                                        style: pw.TextStyle(fontSize: 10.sp, color: PdfColors.blue800)),
                                    pw.SizedBox(height: 1.h),
                                    pw.Text('Jakarta 5111',
                                        style: pw.TextStyle(fontSize: 10.sp, color: PdfColors.blue800)),
                                    pw.SizedBox(height: 1.h),
                                    pw.SizedBox(height: 1.h),
                                    pw.Text('Contact Us',
                                            style: pw.TextStyle(fontSize: 10.sp, color: PdfColors.blue800)),
                                    pw.SizedBox(height: 1.h),
                                    pw.Text('Phone Number',
                                            style: pw.TextStyle(fontSize: 10.sp, color: PdfColors.blue800)),
                                    pw.Text('0812345678',
                                        style: pw.TextStyle(fontSize: 10.sp, color: PdfColors.blue800)),
                                    pw.Text('Email',
                                            style: pw.TextStyle(fontSize: 10.sp, color: PdfColors.blue800)),
                                    pw.Text('awesomeproduct@gmail.com',
                                        style: pw.TextStyle(fontSize: 10.sp, color: PdfColors.blue800)),
                                  ], 
                                ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
}



pw.Padding barcodeKotak(String id) {
  return pw.Padding(
    padding:
      pw.EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.h),
    child: pw.Center(
      child:
          //jenis barcode berbeda dengan value sama(hanya untuk contoh untuk guided)
          pw.BarcodeWidget(
        barcode: pw.Barcode.qrCode(
          errorCorrectLevel: BarcodeQRCorrectionLevel.high,
        ),
        data: id,
        width: 15.w,
        height: 15.h,
      ),
    ),
  );
}

pw.Container barcodeGaris(String id) {
  return pw.Container(
      child: 
        pw.Padding(
          padding: pw.EdgeInsets.symmetric(
              horizontal: 1.h, vertical: 1.h),
          child: pw.BarcodeWidget(
            barcode: Barcode.code128(escapes: 
true),      data: id,
            width: 10.w,
            height: 5.h,
          ),
        ),
    );
}

pw.Center footerPDF(String formattedDate) =>
  pw.Center(child: pw.Text('Created At $formattedDate', style: pw.TextStyle( fontSize: 10.sp, color:
PdfColors.blue)));