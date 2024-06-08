import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:libonthego/widget/fetchingbookdetails.dart';

class BarcodeScan extends StatefulWidget {
  const BarcodeScan({super.key});
  @override
  State<StatefulWidget> createState() {
    return _BarcodeScanState();
  }
}

class _BarcodeScanState extends State<BarcodeScan> {
  String barcode = '';

  Future<void> scanBarcode() async {
    try {
      final barcode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        false,
        ScanMode.DEFAULT,
      );

      if (!mounted) return;

      setState(() {
        this.barcode = barcode;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => GetBookUrl(bookID: barcode)));
      });
    } on PlatformException {
      barcode = 'Failed to get platform version.';
    }
  }

  @override
  Widget build(BuildContext context) => Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: AssetImage('assets/images/DTU.jpg'), opacity: 0.5)),
        child: Column(
          children: [
            AppBar(
              title: const Text('Scan A Book'),
            ),
            const SizedBox(
              height: 175,
            ),
            SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    color: const Color.fromARGB(195, 255, 255, 255),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 50, horizontal: 10),
                      child: Image.asset(
                        'assets/images/Book.png',
                        scale: 8,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  if (barcode != '')
                    Text(
                      'Scanned Result:$barcode',
                      style: const TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  const SizedBox(height: 5),
                  if (barcode == '')
                    ElevatedButton(
                        onPressed: scanBarcode,
                        child: const Text('Scan A Code')),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel"))
                ],
              ),
            ),
          ],
        ),
      );
}
