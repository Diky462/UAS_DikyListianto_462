import 'package:flutter/material.dart';

class TermsConditionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Syarat dan Ketentuan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            '1. Semua produk yang ditampilkan di E-Katalog adalah milik vendor terkait.\n\n'
            '2. Pengguna bertanggung jawab atas keakuratan informasi saat melakukan pemesanan.\n\n'
            '3. Semua transaksi yang dilakukan melalui aplikasi ini tunduk pada hukum yang berlaku.\n\n'
            '4. Kami berhak melakukan perubahan pada aplikasi tanpa pemberitahuan sebelumnya.',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
