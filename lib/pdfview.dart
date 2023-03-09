import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Pdfview extends StatefulWidget {
  final String linkPdf;
  const Pdfview({Key? key, required this.linkPdf}) : super(key: key);

  @override
  _PdfviewState createState() => _PdfviewState();
}

class _PdfviewState extends State<Pdfview> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SfPdfViewer.network(
                "https://esurat.kedirikota.go.id/files/${widget.linkPdf}")));
  }
}
