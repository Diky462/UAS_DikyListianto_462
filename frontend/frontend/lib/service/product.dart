import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductService {
  static const String apiUrl = 'http://192.168.0.107:800';  // URL API

  // Mengambil daftar produk dari backend
  static Future<List<Map<String, dynamic>>> fetchProducts() async {
    final response = await http.get(Uri.parse('$apiUrl/products'));  // Endpoint benar
    if (response.statusCode == 200) {
      // Parsing data JSON jika respons sukses
      List<dynamic> data = json.decode(response.body)['data'];
      return data.map((product) => product as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  // Menambahkan produk baru
  static Future<void> addProduct(String name, String description, double price, int stock) async {
    final response = await http.post(
      Uri.parse('$apiUrl/products'),  // Endpoint benar
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'name': name,
        'description': description,
        'price': price,
        'stock': stock,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add product');
    }
  }
}
