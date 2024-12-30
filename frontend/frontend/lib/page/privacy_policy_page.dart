import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kebijakan Privasi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            'Kami menghormati privasi Anda. Semua data yang Anda masukkan ke dalam aplikasi E-Katalog '
            'akan digunakan untuk keperluan transaksi dan layanan. Data Anda tidak akan dibagikan kepada pihak ketiga tanpa persetujuan.',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
