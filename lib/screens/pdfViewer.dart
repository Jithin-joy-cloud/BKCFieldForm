import 'dart:io';

import 'package:bkc_field_form/models/device.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:share_plus/share_plus.dart';

class PDFViewer extends StatefulWidget {
  final File file;

  const PDFViewer({
    Key? key,
    required this.file,
  }) : super(key: key);

  @override
  PDFViewerState createState() => PDFViewerState();
}

class PDFViewerState extends State<PDFViewer> {
  late PDFViewController controller;
  int pages = 0;
  int indexPage = 0;
  final height = currentDevice.value.height;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 5,
        onPressed: () {
          Share.shareFiles([widget.file.path], text: widget.file.path);
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.share,
          color: Theme.of(context).cardColor,
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).cardColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Image.asset('assets/img/logo.png'),
      ),
      body: SizedBox(
        height: height * .56,
        child: PDFView(
          filePath: widget.file.path,
        ),
      ),
    );
  }
}
