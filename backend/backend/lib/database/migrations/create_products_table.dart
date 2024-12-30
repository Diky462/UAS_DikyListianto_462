import 'package:vania/vania.dart';

class CreateProductsTable extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTableNotExists('products', () {
      id(); // Kolom ID utama
      string('name'); // Kolom nama produk
      text('description'); // Kolom deskripsi produk
      integer('price'); // Gunakan fungsi valid untuk kolom harga
      integer('stock'); // Kolom stok dengan default 0
      timeStamps(); // Kolom created_at dan updated_at
    });
  }

  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('products');
  }
}
