import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../../core/utils/api_end_points.dart';

class TwoFactorSetupDialog extends StatefulWidget {
  final String token;

  const TwoFactorSetupDialog({Key? key, required this.token}) : super(key: key);

  @override
  State<TwoFactorSetupDialog> createState() => _TwoFactorSetupDialogState();
}

class _TwoFactorSetupDialogState extends State<TwoFactorSetupDialog> {
  String? qrCodeData;
  List<String>? recoveryCodes;
  final codeController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchQRCodeAndRecoveryCodes();
  }

  Future<void> _fetchQRCodeAndRecoveryCodes() async {
    setState(() => isLoading = true);
    final dio = Dio();
    dio.options.headers = {
      'Authorization': 'Bearer ${widget.token}',
      'Accept': 'application/json',
    };

    try {
      final qrResponse = await dio.get('${ApiEndPoints.baseUrl}/user/two-factor-qr-code');
      final recoveryResponse = await dio.get('${ApiEndPoints.baseUrl}/user/two-factor-recovery-codes');

      setState(() {
        qrCodeData = (qrResponse.data as Map<String, dynamic>)['url'] as String;
        recoveryCodes = List<String>.from(recoveryResponse.data);
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to fetch 2FA setup data: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  Future<void> _confirmSetup() async {
    if (codeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter verification code'), backgroundColor: Colors.red),
      );
      return;
    }

    setState(() => isLoading = true);
    final dio = Dio();
    dio.options.headers = {
      'Authorization': 'Bearer ${widget.token}',
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    try {
      await dio.post(
        '${ApiEndPoints.baseUrl}/user/confirmed-two-factor-authentication',
        data: {'code': codeController.text},
      );

      if (mounted) {
        Navigator.of(context).pop(true);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('2FA enabled successfully'), backgroundColor: Colors.green),
        );
      }
    } catch (e) {
      setState(() => isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Invalid code. Please try again.'),
              backgroundColor: Colors.red
          ),
        );
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Two-Factor Authentication Setup',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text(
              "Scan this QR code or enter the secret code into your authenticator application, such as Google Authenticator, Authy, etc.",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
            ),
            const SizedBox(height: 16),
            if (qrCodeData != null) ...[
              Center(
                child: SizedBox(
                  width: 200,
                  height: 200,
                  child: QrImageView(
                    data: qrCodeData!,
                    version: QrVersions.auto,
                    size: 200,
                  ),
                ),
              ),
            ],
            const SizedBox(height: 16),
            if (recoveryCodes != null) ...[
              const Text(
                'Recovery Codes',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Text(
                'Please save these codes somewhere secure to use them in case you lose access to the code generator application.',
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: recoveryCodes!
                      .map((code) => Text(code, style: const TextStyle(fontFamily: 'monospace')))
                      .toList(),
                ),
              ),
            ],
            const SizedBox(height: 16),
            TextField(
              controller: codeController,
              decoration: const InputDecoration(
                labelText: 'Enter verification code',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.kPrimaryColor),
              onPressed: _confirmSetup,
              child:  const Text('Send Condirmation', style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}