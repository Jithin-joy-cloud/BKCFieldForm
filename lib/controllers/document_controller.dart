import 'dart:io';
import 'package:bkc_field_form/models/descriprion.dart';
import 'package:bkc_field_form/models/pdf.dart';
import 'package:bkc_field_form/utils/constants.dart';
import 'package:bkc_field_form/utils/helper.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io' as io;
import 'package:bkc_field_form/controllers/form_controller.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class DocumentController extends ControllerMVC {
  GlobalKey<ScaffoldState> documentScaffoldKey = GlobalKey<ScaffoldState>();
  String selectedMonth = "";
  String selectedYear = "";
  GlobalKey<ScaffoldMessengerState> documentScaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  List<Pdf>? allContents;

  Future<File> saveDocument({
    required String name,
    required pw.Document pdf,
  }) async {
    final dir = Directory((Platform.isAndroid
                ? await getExternalStorageDirectory() //FOR ANDROID
                : await getApplicationSupportDirectory() //FOR IOS
            )!
            .path +
        '/documents');
    (dir.exists().then((value) {
      if (!value) {
        dir.create();
      }
    }));
    final file = File('${dir.path}/$name');
    return await file.writeAsBytes(await pdf.save());
  }

  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  List<String> year = [
    '2022',
    '2023',
    '2024',
    '2025',
    '2026',
    '2027',
    '2028',
    '2029',
    '2030',
  ];

  Future<File> generateTable(FormController formController) async {
    final image = (await rootBundle.load('assets/img/logo_progress.png'))
        .buffer
        .asUint8List();
    final pdf = pw.Document();
    final headers = ['Section', 'Value'];
    final result = [
      Description('enrolmentId', formController.general.enrolmentId),
      Description('builderName', formController.general.builderName),
      Description('site', formController.house.site),
      Description('phase', formController.house.phase.toString()),
      Description('lot', formController.house.lot.toString()),
      Description('city', formController.house.city),
      Description('postalCode', formController.house.postalCode),
      Description('attDetMur', formController.house.att_det_murb),
      Description('evaluatorName', formController.general.evaluatorName),
      Description(
          'evaluatorNumber', formController.general.evaluatorId.toString()),
      Description('inspectionDate', formController.general.inspectionDate),
      Description('siteContactName', formController.general.siteContactName),
      Description('siteContactEmail', formController.general.siteContactEmail),
      Description('siteContactPhone', formController.general.siteContactNumber),
    ];
    final data = result.map((result) => [result.name, result.value]).toList();
    pdf.addPage(pw.Page(
        clip: true,
        margin: const pw.EdgeInsets.all(10),
        pageFormat: PdfPageFormat.a4,
        build: (context) => pw.Container(
            // decoration: pw.BoxDecoration(border: pw.Border.all(width: 2)),
            child: pw.Padding(
                padding: const pw.EdgeInsets.all(10),
                child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Image(
                        pw.MemoryImage(image),
                        height: 80,
                        width: 80,
                      ),
                      pw.SizedBox(
                        height: 10,
                      ),
                      pw.Table.fromTextArray(
                        headers: headers,
                        data: data,
                      ),
                      pw.Text(
                        Constants.PDFACK,
                        textAlign: pw.TextAlign.justify,
                      ),
                      pw.Text(
                        formController.general.evaluatorName,
                        textAlign: pw.TextAlign.left,
                      ),
                      pw.Text(
                        Constants.PDFNRC,
                        textAlign: pw.TextAlign.left,
                      ),
                      pw.Text(
                        formController.general.evaluatorId.toString(),
                        textAlign: pw.TextAlign.left,
                      ),
                    ])))));

    return saveDocument(
        name:
            "${formController.general.id.toString().trim()} ${formController.general.inspectionDate.trim()} ${formController.house.site.trim()} .pdf",
        pdf: pdf);
  }

  void showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(msg),
      ));
  }

  Future<List<Pdf>> fileLists(BuildContext context) async {
  /*  final appDir = await getApplicationDocumentsDirectory();

    if (appDir.existsSync()) {
      appDir.deleteSync(recursive: true);
    }*/
    final dir = Directory((Platform.isAndroid
                ? await getExternalStorageDirectory()
                : await getApplicationSupportDirectory())!
            .path +
        '/documents');

    (dir.exists().then((value) {
      if (!value) {
        dir.create();
      }
    }));

    allContents = [Pdf()];
    allContents!.clear();
    final List<FileSystemEntity> entities = await dir.list().toList();
    for (var element in entities) {
      List<String> items =
          Helper.getDocumentString(element.path, dir.path + "/").split(" ");
      Pdf pdf = Pdf();
      pdf.id = items[0];
      pdf.date = items[1];
     pdf.site = items[2];
      pdf.path = element.path;
      if (pdf.date.contains(selectedMonth) && pdf.date.contains(selectedYear)) {
        allContents!.add(pdf);
      }
    }
    return allContents!;
  }
}
