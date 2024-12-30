import 'package:flutter/material.dart';
import 'package:piranti/navigation/bottom_navigation.dart';
import 'package:piranti/page/ganti_password_page.dart';
import 'package:piranti/page/terms_condition_page.dart';
import 'privacy_policy_page.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  void showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hapus Akun'),
          content: Text('Apakah Anda yakin ingin menghapus akun Anda?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Menutup dialog
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                // Logika untuk menghapus akun
                Navigator.of(context).pop(); // Menutup dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Akun berhasil dihapus.')),
                );
                // Arahkan kembali ke halaman login atau tindakan lainnya
              },
              child: Text('Hapus', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengaturan Akun'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'User123', // Nama akun
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Divider(),
            ListTile(
              title: Text('Nama Akun'),
              subtitle: Text('User123'),
              leading: Icon(Icons.person),
            ),
            Divider(),
            ListTile(
              title: Text('Ganti Kata Sandi'),
              leading: Icon(Icons.lock),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChangePasswordPage()),
                );
              },
            ),
            Divider(),
            ListTile(
              title: Text('Kebijakan Privasi'),
              leading: Icon(Icons.privacy_tip),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PrivacyPolicyPage()),
                );
              },
            ),
            Divider(),
            ListTile(
              title: Text('Syarat dan Ketentuan'),
              leading: Icon(Icons.description),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TermsConditionsPage()),
                );
              },
            ),
            Divider(),
            ListTile(
              title: Text(
                'Hapus Akun',
                style: TextStyle(color: Colors.red),
              ),
              leading: Icon(Icons.delete, color: Colors.red),
              onTap: () {
                showDeleteAccountDialog(context);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(currentIndex: 1),
    );
  }
}
