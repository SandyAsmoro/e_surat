import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Pdfview extends StatelessWidget {
  final String linkPdf;

  const Pdfview({Key? key, required this.linkPdf}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
        backgroundColor: Color.fromARGB(255, 27, 0, 71),
      ),
      body: Container(
        child: SfPdfViewer.network(
        'https://asndigital.kedirikota.go.id/${linkPdf}',
        // 'https://www.kindacode.com/wp-content/uploads/2021/07/test.pdf',
        // pdfUrl,
        enableDocumentLinkAnnotation: true,
      ),
      ),
    );
  }
}


    // @override
    // Widget build(BuildContext context) {
    //   return SafeArea(
    //       child: Scaffold(
    //           body: SfPdfViewer.network(
    //               // "http://asndigital.kedirikota.go.id/berkas/2023/101/22c6074a83be766349a6985795a042f3")));
    //               "http://asndigital.kedirikota.go.id/${widget.linkPdf}")));
    //               // "https://esurat.kedirikota.go.id/files/${widget.linkPdf}")));
    // }