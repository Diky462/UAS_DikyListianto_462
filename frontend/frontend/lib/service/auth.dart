import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const secureStorage = FlutterSecureStorage();

Future<void> register(String name, String email, String password,String confirmPassword) async {
  final url = Uri.parse("http://192.168.77.231:8000/api/register");

  try {
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "name": name, 
        "email": email,
        "password": password,
        "password_confirmation": confirmPassword,
      }),
    );

    if (response.statusCode == 201) {
      final data = json.decode(response.body);
      print("Pendaftaran berhasil: ${data['message']}");
    } else {
      final error = json.decode(response.body);
      throw Exception("Pendaftaran gagal: ${error['message'] ?? 'Kesalahan server'}");
    }
  } catch (e) {
    throw Exception("Pendaftaran: $e");
  }
}

// Fungsi Login
Future<void> login(String email, String password) async {
  final url = Uri.parse("http://192.168.77.231:8000/api/login");

  try {
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final accessToken = data['token']['access_token'];

      // Simpan token di secure storage
      await secureStorage.write(key: 'access_token', value: accessToken);
      print('Access token berhasil disimpan: $accessToken');
    } else {
      final error = json.decode(response.body);
      throw Exception("Login gagal: ${error['message'] ?? 'Kesalahan server'}");
    }
  } catch (e) {
    throw Exception("Login gagal: $e");
  }
}

// Fungsi untuk memeriksa apakah user sudah login
Future<bool> isLoggedIn() async {
  final accessToken = await secureStorage.read(key: 'access_token');
  return accessToken != null;
}

// Fungsi untuk mengambil data profil pengguna
Future<Map<String, dynamic>> fetchUserProfile() async {
  final accessToken = await secureStorage.read(key: 'access_token');

  if (accessToken == null) {
    throw Exception("Token tidak ditemukan. Silakan login ulang.");
  }

  final url = Uri.parse("http://192.168.0.119:8000/api/me");

  try {
    final response = await http.get(
      url,
      headers: {
        "Authorization": "Bearer $accessToken",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Gagal mengambil profil pengguna");
    }
  } catch (e) {
    throw Exception("Error mengambil profil: $e");
  }
}

// Fungsi Logout
Future<void> logout() async {
  await secureStorage.delete(key: 'access_token');
  print("Access token berhasil dihapus.");
}
