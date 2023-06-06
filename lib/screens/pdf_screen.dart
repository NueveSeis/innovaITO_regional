import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

class PdfScreen extends StatelessWidget {
  static const String name = 'pdf_screen';
  final Future<Uint8List> archivo;
  const PdfScreen({
    super.key,
    required this.archivo,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter PDF Example'),
      ),
      body: PdfPreview(
        build: (context) => archivo,
      ),
    );
  }
}
