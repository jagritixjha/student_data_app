import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfPreviewScreen extends StatelessWidget {
  const PdfPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String path = ModalRoute.of(context)!.settings.arguments as String;
    log("pdf path ----------- $path");
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Preview'),
      ),
      body: path.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(24),
              child: PDFView(
                filePath: path!,
              ),
            )
          : const Center(child: Text("PDF file not found")),
    );
  }
}
