import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import '../../domain/entities/payslip.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PayslipDownloadPage extends StatefulWidget {
  final PayslipEntity payslipData;

  const PayslipDownloadPage({super.key, required this.payslipData});

  @override
  State<PayslipDownloadPage> createState() => _PayslipDownloadPageState();
}

class _PayslipDownloadPageState extends State<PayslipDownloadPage> {
  Future saveAndLaunchFile(List<int> bytes, String fileName) async {
    final path = (await getExternalStorageDirectory())!.path;
    final file = File("$path/$fileName");
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open("$path/$fileName");
  }

  Future<Uint8List> _generatePdf(
      BuildContext context, PdfPageFormat format, String title) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final font = await PdfGoogleFonts.kanitRegular();
    final fontBold = await PdfGoogleFonts.kanitMedium();

    pdf.addPage(
      pw.Page(
        margin: const pw.EdgeInsets.all(25),
        pageFormat: format,
        build: (BuildContext) {
          return pw.Column(
            children: [
              pw.Row(
                children: [
                  pw.Text("Confidential", style: pw.TextStyle(font: font)),
                  pw.Spacer(),
                  pw.Text("PAY SLIP",
                      style: pw.TextStyle(
                          font: fontBold,
                          color: const PdfColor.fromInt(0xffD13B3B),
                          fontWeight: pw.FontWeight.bold)),
                ],
              ),
              pw.SizedBox(height: 30),
              pw.Table(
                // border: pw.TableBorder.all(),
                defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
                columnWidths: {
                  0: const pw.FractionColumnWidth(2),
                  1: const pw.FractionColumnWidth(7),
                  2: const pw.FractionColumnWidth(2),
                  3: const pw.FractionColumnWidth(2)
                },
                children: [
                  pw.TableRow(
                    children: [
                      pw.Text("${AppLocalizations.of(context)!.fullname} :",
                          style: pw.TextStyle(
                              font: font,
                              fontSize: 10,
                              color: const PdfColor.fromInt(0xff7D7D7D))),
                      pw.Text(
                          "${widget.payslipData.titleTh} ${widget.payslipData.firstnameTh} ${widget.payslipData.lastnameTh}",
                          style: pw.TextStyle(
                              font: font,
                              fontSize: 10,
                              color: const PdfColor.fromInt(0xff212B36))),
                      pw.Text("${AppLocalizations.of(context)!.employeeid} :",
                          style: pw.TextStyle(
                              font: font,
                              fontSize: 10,
                              color: const PdfColor.fromInt(0xff7D7D7D))),
                      pw.Text("${widget.payslipData.employeeId ?? '-'}",
                          style: pw.TextStyle(
                              font: font,
                              fontSize: 10,
                              color: const PdfColor.fromInt(0xff212B36))),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Text("${AppLocalizations.of(context)!.company} :",
                          style: pw.TextStyle(
                              font: font,
                              fontSize: 10,
                              fontWeight: pw.FontWeight.bold,
                              color: const PdfColor.fromInt(0xff7D7D7D))),
                      pw.Text(widget.payslipData.companyName ?? '',
                          style: pw.TextStyle(
                              font: font,
                              fontSize: 10,
                              color: const PdfColor.fromInt(0xff212B36))),
                      pw.Text("${AppLocalizations.of(context)!.startdate} :",
                          style: pw.TextStyle(
                              font: font,
                              fontSize: 10,
                              fontWeight: pw.FontWeight.bold,
                              color: const PdfColor.fromInt(0xff7D7D7D))),
                      pw.Text(
                          widget.payslipData.start != null
                              ? DateFormat("dd/MM/yyyy")
                                  .format(widget.payslipData.start!)
                              : "",
                          style: pw.TextStyle(
                              font: font,
                              fontSize: 10,
                              color: const PdfColor.fromInt(0xff212B36))),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Text("${AppLocalizations.of(context)!.department} :",
                          style: pw.TextStyle(
                              font: font,
                              fontSize: 10,
                              color: const PdfColor.fromInt(0xff7D7D7D))),
                      pw.Text(widget.payslipData.departmentName ?? '',
                          style: pw.TextStyle(
                              font: font,
                              fontSize: 10,
                              fontWeight: pw.FontWeight.bold,
                              color: const PdfColor.fromInt(0xff212B36))),
                      pw.Text("${AppLocalizations.of(context)!.enddate} :",
                          style: pw.TextStyle(
                              font: font,
                              fontSize: 10,
                              color: const PdfColor.fromInt(0xff7D7D7D))),
                      pw.Text(
                          widget.payslipData.end != null
                              ? DateFormat("dd/MM/yyyy")
                                  .format(widget.payslipData.end!)
                              : "",
                          style: pw.TextStyle(
                              font: font,
                              fontSize: 10,
                              fontWeight: pw.FontWeight.bold,
                              color: const PdfColor.fromInt(0xff212B36))),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Text("${AppLocalizations.of(context)!.accountNo} :",
                          style: pw.TextStyle(
                              font: font,
                              fontSize: 10,
                              color: const PdfColor.fromInt(0xff7D7D7D))),
                      pw.Text(widget.payslipData.bookId!,
                          style: pw.TextStyle(
                              font: font,
                              fontSize: 10,
                              color: const PdfColor.fromInt(0xff212B36))),
                      pw.Text("${AppLocalizations.of(context)!.paymentdate} :",
                          style: pw.TextStyle(
                              font: font,
                              fontSize: 10,
                              color: const PdfColor.fromInt(0xff7D7D7D))),
                      pw.Text(
                          widget.payslipData.payDate != null
                              ? widget.payslipData.payDate!.substring(0, 10)
                              : DateFormat("dd/MM/yyyy").format(DateTime(
                                  widget.payslipData.monthPeriod!.year,
                                  widget.payslipData.monthPeriod!.month,
                                  28)),
                          style: pw.TextStyle(
                              font: font,
                              fontSize: 10,
                              color: const PdfColor.fromInt(0xff212B36))),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 5),
              pw.Table(
                defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
                columnWidths: {
                  0: const pw.FractionColumnWidth(.25),
                  1: const pw.FractionColumnWidth(.15),
                  2: const pw.FractionColumnWidth(.3),
                  3: const pw.FractionColumnWidth(.15)
                },
                border: const pw.TableBorder(
                  verticalInside: pw.BorderSide(
                      width: 1, color: PdfColor.fromInt(0xffE0E0E0)),
                  left: pw.BorderSide(
                      width: 1, color: PdfColor.fromInt(0xffE0E0E0)),
                  right: pw.BorderSide(
                      width: 1, color: PdfColor.fromInt(0xffE0E0E0)),
                  bottom: pw.BorderSide(
                      width: 1, color: PdfColor.fromInt(0xffE0E0E0)),
                ),
                children: [
                  pw.TableRow(
                    decoration: const pw.BoxDecoration(
                        color: PdfColor.fromInt(0xff46cbe2)),
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: pw.Text(
                            "${AppLocalizations.of(context)!.incomelist}",
                            style: pw.TextStyle(
                                font: fontBold,
                                fontSize: 10,
                                color: PdfColors.white)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: pw.Text(
                            "${AppLocalizations.of(context)!.amountBaht}",
                            style: pw.TextStyle(
                                font: fontBold,
                                fontSize: 10,
                                color: PdfColors.white),
                            textAlign: pw.TextAlign.right),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: pw.Text(
                            "${AppLocalizations.of(context)!.deductionlist}",
                            style: pw.TextStyle(
                                font: fontBold,
                                fontSize: 10,
                                color: PdfColors.white)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: pw.Text(
                            "${AppLocalizations.of(context)!.amountBaht}",
                            style: pw.TextStyle(
                                font: fontBold,
                                fontSize: 10,
                                color: PdfColors.white),
                            textAlign: pw.TextAlign.right),
                      ),
                    ],
                  ),
                  for (var i = 0, j = 0;
                      i < widget.payslipData.addition!.length ||
                          j < widget.payslipData.deduction!.length;
                      i++, j++)
                    pw.TableRow(
                      verticalAlignment: pw.TableCellVerticalAlignment.middle,
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          child: pw.Text(
                              "${i < widget.payslipData.addition!.length ? widget.payslipData.addition![i].name : ''}",
                              style: pw.TextStyle(
                                  font: font,
                                  fontSize: 10,
                                  color: const PdfColor.fromInt(0xff252F39))),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          child: pw.Text(
                              i < widget.payslipData.addition!.length
                                  ? NumberFormat("#,###.##").format(
                                      widget.payslipData.addition![i].value)
                                  : '',
                              style: pw.TextStyle(
                                  font: font,
                                  fontSize: 10,
                                  color: const PdfColor.fromInt(0xff252F39)),
                              textAlign: pw.TextAlign.right),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          child: pw.Text(
                              "${j < widget.payslipData.deduction!.length ? widget.payslipData.deduction![j].name : ''}",
                              style: pw.TextStyle(
                                  font: font,
                                  fontSize: 10,
                                  color: const PdfColor.fromInt(0xff252F39))),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          child: pw.Text(
                              j < widget.payslipData.deduction!.length
                                  ? NumberFormat("#,###.##").format(
                                      widget.payslipData.deduction![j].value)
                                  : '',
                              style: pw.TextStyle(
                                  font: font,
                                  fontSize: 10,
                                  color: const PdfColor.fromInt(0xff252F39)),
                              textAlign: pw.TextAlign.right),
                        ),
                      ],
                    ),
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(vertical: 30),
                        child: pw.Text("", style: pw.TextStyle(font: font)),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(vertical: 30),
                        child: pw.Text("", style: pw.TextStyle(font: font)),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    verticalAlignment: pw.TableCellVerticalAlignment.middle,
                    decoration: const pw.BoxDecoration(
                        color: PdfColor.fromInt(0xffEEEEEE)),
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: pw.Text(
                            "${AppLocalizations.of(context)!.totalIncome}",
                            style: pw.TextStyle(
                                font: font,
                                fontSize: 10,
                                color: const PdfColor.fromInt(0xff4D555E))),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(
                            horizontal: 8, vertical: 5),
                        child: pw.Text(
                            NumberFormat("#,###.##").format(
                                widget.payslipData.accumulateEarnings ?? 0),
                            style: pw.TextStyle(
                                font: font,
                                fontSize: 10,
                                color: const PdfColor.fromInt(0xff4D555E)),
                            textAlign: pw.TextAlign.right),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: pw.Text(
                            "${AppLocalizations.of(context)!.totalDeduction}",
                            style: pw.TextStyle(
                                font: font,
                                fontSize: 10,
                                color: const PdfColor.fromInt(0xff4D555E))),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: pw.Text(
                            NumberFormat("#,###.##")
                                .format(widget.payslipData.totalDeductions),
                            style: pw.TextStyle(
                                font: font,
                                fontSize: 10,
                                color: const PdfColor.fromInt(0xff4D555E)),
                            textAlign: pw.TextAlign.right),
                      ),
                    ],
                  ),
                ],
              ),
              pw.Table(
                defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
                columnWidths: {
                  0: const pw.FractionColumnWidth(.25),
                  1: const pw.FractionColumnWidth(.15),
                  2: const pw.FractionColumnWidth(.3),
                  3: const pw.FractionColumnWidth(.15)
                },
                children: [
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: pw.Text("", style: pw.TextStyle(font: font)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: pw.Text("",
                            style: pw.TextStyle(
                              font: font,
                            )),
                      ),
                      pw.Container(
                        color: const PdfColor.fromInt(0xffE0E0E0),
                        child: pw.Padding(
                          padding: const pw.EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: pw.Text(
                              "${AppLocalizations.of(context)!.netpay}",
                              style: pw.TextStyle(
                                  font: fontBold,
                                  fontSize: 10,
                                  fontWeight: pw.FontWeight.bold,
                                  color: const PdfColor.fromInt(0xff4A525B))),
                        ),
                      ),
                      pw.Container(
                        color: const PdfColor.fromInt(0xffE0E0E0),
                        child: pw.Padding(
                          padding: const pw.EdgeInsets.symmetric(
                              horizontal: 8, vertical: 5),
                          child: pw.Text(
                              NumberFormat("#,###.##")
                                  .format(widget.payslipData.net),
                              style: pw.TextStyle(
                                  font: fontBold,
                                  fontSize: 10,
                                  fontWeight: pw.FontWeight.bold,
                                  color: const PdfColor.fromInt(0xff4A525B)),
                              textAlign: pw.TextAlign.right),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              pw.Padding(
                  padding: const pw.EdgeInsets.only(top: 15, bottom: 5),
                  child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      children: [
                        pw.Text(
                            "${AppLocalizations.of(context)!.accumulatecurrentyear} - ${AppLocalizations.of(context)!.year}" +
                                DateFormat(" yyyy")
                                    .format(widget.payslipData.monthPeriod!),
                            style: pw.TextStyle(
                                font: font,
                                color: const PdfColor.fromInt(0xff212B36))),
                      ])),
              pw.Table(
                border: pw.TableBorder.all(
                    color: const PdfColor.fromInt(0xffE0E0E0)),
                defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
                // columnWidths: {
                //   0: const pw.FractionColumnWidth(2),
                //   1: const pw.FractionColumnWidth(3),
                //   2: const pw.FractionColumnWidth(4),
                //   3: const pw.FractionColumnWidth(5)},
                children: [
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(
                            horizontal: 10, vertical: 3),
                        child: pw.Text(
                            "${AppLocalizations.of(context)!.accumulatecurrentyear} (${AppLocalizations.of(context)!.baht})",
                            style: pw.TextStyle(
                                font: font,
                                fontSize: 10,
                                color: const PdfColor.fromInt(0xff212B36)),
                            textAlign: pw.TextAlign.center),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(
                            horizontal: 10, vertical: 3),
                        child: pw.Text(
                            "${AppLocalizations.of(context)!.cumulativeWithholdingTax} (${AppLocalizations.of(context)!.baht})",
                            style: pw.TextStyle(
                                font: font,
                                fontSize: 10,
                                color: const PdfColor.fromInt(0xff212B36)),
                            textAlign: pw.TextAlign.center),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(
                            horizontal: 10, vertical: 3),
                        child: pw.Text(
                            "${AppLocalizations.of(context)!.cumulativeSocialSecurity} (${AppLocalizations.of(context)!.baht})",
                            style: pw.TextStyle(
                                font: font,
                                fontSize: 10,
                                color: const PdfColor.fromInt(0xff212B36)),
                            textAlign: pw.TextAlign.center),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(
                            horizontal: 10, vertical: 3),
                        child: pw.Text(
                            "${AppLocalizations.of(context)!.cumulativeProvidentFund} (${AppLocalizations.of(context)!.baht})",
                            style: pw.TextStyle(
                                font: font,
                                fontSize: 10,
                                color: const PdfColor.fromInt(0xff212B36)),
                            textAlign: pw.TextAlign.center),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        child: pw.Text(
                            NumberFormat("#,###.##").format(
                                widget.payslipData.accumulateEarnings ?? 0),
                            style: pw.TextStyle(
                                font: font,
                                fontSize: 10,
                                color: const PdfColor.fromInt(0xff212B36)),
                            textAlign: pw.TextAlign.center),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        child: pw.Text(
                            NumberFormat("#,###.##")
                                .format(widget.payslipData.accumulateTax ?? 0),
                            style: pw.TextStyle(
                                font: font,
                                fontSize: 10,
                                color: const PdfColor.fromInt(0xff212B36)),
                            textAlign: pw.TextAlign.center),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        child: pw.Text(
                            NumberFormat("#,###.##")
                                .format(widget.payslipData.accumulateSso ?? 0),
                            style: pw.TextStyle(
                                font: font,
                                fontSize: 10,
                                color: const PdfColor.fromInt(0xff212B36)),
                            textAlign: pw.TextAlign.center),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        child: pw.Text(
                            NumberFormat("#,###.##")
                                .format(widget.payslipData.accumulatePf ?? 0),
                            style: pw.TextStyle(
                                font: font,
                                fontSize: 10,
                                color: const PdfColor.fromInt(0xff212B36)),
                            textAlign: pw.TextAlign.center),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
    final output = await getApplicationSupportDirectory();
    final file = File(
        "${output.path}/${AppLocalizations.of(context)!.salarySlip} ${DateFormat("MMMM yyyy", "en_US").format(widget.payslipData.monthPeriod!)}.pdf");
    await file.writeAsBytes(await pdf.save());
    log("${output.path}");
    OpenFile.open(
        "${output.path}/${AppLocalizations.of(context)!.salarySlip} ${DateFormat("MMMM yyyy", "en_US").format(widget.payslipData.monthPeriod!)}.pdf");
    return pdf.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          scrolledUnderElevation: 0,
          elevation: 0,
          toolbarHeight: MediaQuery.of(context).size.height * 0.1,
          flexibleSpace: Stack(children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/background_img.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    Colors.white.withOpacity(0),
                    Colors.white.withOpacity(0.2)
                  ])),
            ),
          ]),
          centerTitle: true,
          title: Text(
            "${AppLocalizations.of(context)!.salarySlip}",
            style: GoogleFonts.kanit(
                fontSize: 25, fontWeight: FontWeight.w500, color: Colors.white),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
        ),
        body: InteractiveViewer(
          minScale: 0.1,
          maxScale: 3,
          child: PdfPreview(
              canDebug: false,
              useActions: false,
              padding: const EdgeInsets.all(0),
              build: (format) => _generatePdf(context, format, "title")),
        ));
  }
}
