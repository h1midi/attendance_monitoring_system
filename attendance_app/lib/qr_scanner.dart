import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'user/user_provider.dart';

class QrScanner extends StatefulWidget {
  const QrScanner({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
        ],
      ),
    );
  }

  bool isLoading = false;
  void _showPopup(BuildContext context, userProvider, qrurl) async {
    if (isLoading) return;
    final uid = userProvider.uid;
    String url = '$qrurl/$uid';
    isLoading = true;
    controller!.pauseCamera();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const SizedBox(
          height: 22,
          width: 15,
          child: AlertDialog(
            title: Text('Registering...'),
            content: LinearProgressIndicator(),
          ),
        );
      },
    );
    final response = await http.get(Uri.parse(url));
    await Future.delayed(const Duration(seconds: 1));
    isLoading = false;
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
    // ignore: use_build_context_synchronously
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: switch (response.statusCode) {
            200 => const Text('Registered successfully.', style: TextStyle(color: Colors.green)),
            202 => Text('Already regestered.', style: TextStyle(color: Colors.yellow[700])),
            204 =>
              const Text('The event is closed.', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            _ => const Text('Failed to register.', style: TextStyle(color: Colors.red)),
          },
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea =
        (MediaQuery.of(context).size.width < 400 || MediaQuery.of(context).size.height < 400) ? 260.0 : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red, borderRadius: 10, borderLength: 30, borderWidth: 10, cutOutSize: scanArea),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      _showPopup(context, Provider.of<UserProvider>(context, listen: false), result!.code);
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
