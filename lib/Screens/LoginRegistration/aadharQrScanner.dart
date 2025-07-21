import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AadhaarVerificationScreen extends StatefulWidget {
  const AadhaarVerificationScreen({super.key});

  @override
  _AadhaarVerificationScreenState createState() =>
      _AadhaarVerificationScreenState();
}

class _AadhaarVerificationScreenState extends State<AadhaarVerificationScreen> {
  final _aadhaarController = TextEditingController();
  final _otpController = TextEditingController();
  String? txnId;
  bool otpSent = false;
  String message = '';

  Future<void> requestOtp() async {
    final aadhaar = _aadhaarController.text.trim();
    final response = await http.post(
      Uri.parse('https://your-backend.com/request-otp'), // Replace with actual
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'aadhaar': aadhaar}),

    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      txnId = data['txnId'];
      setState(() {
        otpSent = true;
        message = 'OTP sent to Aadhaar-linked mobile.';
      });
    } else {
      setState(() {
        message = 'Failed to send OTP.';
      });
    }
  }

  Future<void> verifyOtp() async {
    final response = await http.post(
      Uri.parse('https://your-backend.com/verify-otp'), // Replace with actual
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'aadhaar': _aadhaarController.text.trim(),
        'otp': _otpController.text.trim(),
        'txnId': txnId
      }),
    );

    final result = jsonDecode(response.body);
    setState(() {
      message = result['status'] == 'success'
          ? '✅ Aadhaar Verified!'
          : '❌ Verification Failed!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Aadhaar OTP Verification')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _aadhaarController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Aadhaar Number'),
            ),
            if (otpSent)
              TextField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Enter OTP'),
              ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: otpSent ? verifyOtp : requestOtp,
              child: Text(otpSent ? 'Verify OTP' : 'Request OTP'),
            ),
            SizedBox(height: 16),
            Text(message, style: TextStyle(color: Colors.blue)),
          ],
        ),
      ),
    );
  }
}







// import 'package:flutter/material.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
// import 'package:xml/xml.dart';
//
// class AadhaarQRScanner extends StatefulWidget {
//   @override
//   _AadhaarQRScannerState createState() => _AadhaarQRScannerState();
// }
//
// class _AadhaarQRScannerState extends State<AadhaarQRScanner> {
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   QRViewController? controller;
//   String? aadhaarDetails;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Aadhaar QR Scanner')),
//       body: Column(
//         children: [
//           Expanded(
//             flex: 4,
//             child: QRView(
//               key: qrKey,
//               onQRViewCreated: _onQRViewCreated,
//             ),
//           ),
//           Expanded(
//             flex: 2,
//             child: Center(
//               child: aadhaarDetails != null
//                   ? Text(aadhaarDetails!, textAlign: TextAlign.center)
//                   : Text("Scan the Aadhaar QR code"),
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   void _onQRViewCreated(QRViewController controller) {
//     this.controller = controller;
//     controller.scannedDataStream.listen((scanData) {
//       _parseAadhaarQR(scanData.code!);
//       controller.pauseCamera(); // prevent multiple scans
//     });
//   }
//
//   void _parseAadhaarQR(String rawXml) {
//     try {
//       final document = XmlDocument.parse(rawXml);
//       final data = document.findAllElements('PrintLetterBarcodeData').first;
//       final uid = data.getAttribute('uid');
//       final name = data.getAttribute('name');
//       final yob = data.getAttribute('yob');
//       final gender = data.getAttribute('gender');
//       final loc = data.getAttribute('loc');
//
//       setState(() {
//         aadhaarDetails = '''
// UID: $uid
// Name: $name
// Year of Birth: $yob
// Gender: $gender
// Location: $loc
// ''';
//       });
//     } catch (e) {
//       setState(() {
//         aadhaarDetails = 'Invalid QR code data';
//       });
//     }
//   }
//
//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }
// }
