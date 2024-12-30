import 'dart:io';
import 'package:order_entry__diky__listianto/app/models/products.dart';
import 'package:vania/vania.dart';

class ProductController extends Controller {
  // Register a new product
  Future<Response> create(Request request) async {
    // Validasi input
    request.validate({
      'name': 'required',
      'description': 'required',
      'price': 'required|numeric|min:0',
      'stock': 'required|numeric|min:0',
    }, {
      'name.required': 'Nama produk tidak boleh kosong',
      'description.required': 'Deskripsi produk tidak boleh kosong',
      'price.required': 'Harga produk tidak boleh kosong',
      'price.numeric': 'Harga produk harus berupa angka',
      'price.min': 'Harga produk tidak boleh kurang dari 0',
      'stock.required': 'Stok produk tidak boleh kosong',
      'stock.numeric': 'Stok produk harus berupa angka',
      'stock.min': 'Stok produk tidak boleh kurang dari 0',
    });

    final name = request.input('name');
    final description = request.input('description');
    final price = request.input('price');
    final stock = request.input('stock');

    // Simpan produk baru ke database
    await Product().query().insert({
      'name': name,
      'description': description,
      'price': price,
      'stock': stock,
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    });

    return Response.json({
      'message': 'Produk berhasil ditambahkan'
    }, 201);  // HTTP Status 201 Created
  }

Future<Response> index(Request request) async {
  try {
    final products = await Product().query().select().get(); // Pastikan query ini benar
    return Response.json({
      'message': 'Berhasil mengambil daftar produk',
      'data': products,
    });
  } catch (e) {
    return Response.json({
      'message': 'Terjadi kesalahan saat mengambil data produk',
      'error': e.toString(),
    }, 500);  // HTTP Status 500 Internal Server Error
  }
}

  // Get a single product by ID
  Future<Response> show(Request request, String id) async {
    try {
      final product = await Product().query().where('id', '=', id).first();
      if (product == null) {
        return Response.json({
          'message': 'Produk tidak ditemukan',
        }, 404);  // HTTP Status 404 Not Found
      }

      return Response.json({
        'message': 'Berhasil mengambil data produk',
        'data': product.toMap(),  // Convert product to Map
      });
    } catch (e) {
      return Response.json({
        'message': 'Terjadi kesalahan saat mengambil data produk',
        'error': e.toString(),
      }, 500);  // HTTP Status 500 Internal Server Error
    }
  }

  // Update product by ID
  Future<Response> update(Request request, String id) async {
    try {
      request.validate({
        'name': 'string',
        'description': 'string',
        'price': 'numeric|min:0',
        'stock': 'numeric|min:0',
      });

      final product = await Product().query().where('id', '=', id).first();
      if (product == null) {
        return Response.json({
          'message': 'Produk tidak ditemukan',
        }, 404);
      }

      final name = request.input('name');
      final description = request.input('description');
      final price = request.input('price');
      final stock = request.input('stock');
      final updatedAt = DateTime.now().toIso8601String();

      await Product().query().where('id', '=', id).update({
        'name': name ?? product['name'],
        'description': description ?? product['description'],
        'price': price ?? product['price'],
        'stock': stock ?? product['stock'],
        'updated_at': updatedAt,
      });

      return Response.json({
        'message': 'Produk berhasil diperbarui',
      });
    } catch (e) {
      return Response.json({
        'message': 'Terjadi kesalahan saat memperbarui produk',
        'error': e.toString(),
      }, 500);  // HTTP Status 500 Internal Server Error
    }
  }

  // Delete product by ID
  Future<Response> destroy(Request request, String id) async {
    try {
      final product = await Product().query().where('id', '=', id).first();
      if (product == null) {
        return Response.json({
          'message': 'Produk tidak ditemukan',
        }, 404);  // HTTP Status 404 Not Found
      }

      await Product().query().where('id', '=', id).delete();

      return Response.json({
        'message': 'Produk berhasil dihapus',
      });
    } catch (e) {
      return Response.json({
        'message': 'Terjadi kesalahan saat menghapus produk',
        'error': e.toString(),
      }, 500);  // HTTP Status 500 Internal Server Error
    }
  }
}

extension on Map<String, dynamic> {
  toMap() {}
}

final ProductController productController = ProductController();
