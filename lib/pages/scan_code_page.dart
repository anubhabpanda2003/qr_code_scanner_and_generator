import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class ScanCodePage extends StatefulWidget {
  const ScanCodePage({super.key});

  @override
  State<ScanCodePage> createState() => _ScanCodePageState();
}

class _ScanCodePageState extends State<ScanCodePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Scan QR Code',
        ),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, "/generate");
            },
            icon: const Icon(
              Icons.qr_code,
            ),
          ),
        ],
      ),
      body: Container(
        margin:
            const EdgeInsets.only(left: 30, top: 100, right: 30, bottom: 10),
        child: MobileScanner(
          controller: MobileScannerController(
            detectionSpeed: DetectionSpeed.noDuplicates,
            returnImage: true,
          ),
          onDetect: (capture) {
            final List<Barcode> barcodes = capture.barcodes;
            final Uint8List? image = capture.image;
            for (final barcode in barcodes) {
              print('Barcode found! ${barcode.rawValue}');
            }
            if (image != null) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(
                      barcodes.first.rawValue ?? "",
                    ),
                    content: Image(
                      image: MemoryImage(image),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      extendBodyBehindAppBar: true,
      bottomNavigationBar: Container(
        alignment: Alignment.bottomCenter,
        height: 60.0,
        color: Color(0xff7c94b6),
        child: Text(
          "Made in ❤️ by Abhisek Sandha",
          style: TextStyle(color: Colors.greenAccent, fontSize: 17),
        ),
      ),
    );
  }
}
