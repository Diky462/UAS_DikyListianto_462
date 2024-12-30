import 'package:flutter/material.dart';
import 'product_detail_page.dart';

class CategoryProductPage extends StatelessWidget {
  final String categoryName;

  CategoryProductPage({required this.categoryName});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> products = [];

    // Menentukan produk berdasarkan kategori
    if (categoryName == 'Kamera Mirrorless') {
      products = [
        {
          'name': 'Canon EOS R6',
          'description': 'Kamera mirrorless dengan sensor full-frame 20MP.',
          'image': 'assets/images/canon_r6.jpg',
        },
        {
          'name': 'Sony Alpha a7 III',
          'description': 'Kamera full-frame 24.2MP.',
          'image': 'assets/images/sony_alpha_a7.jpg',
        },
      ];
    } else if (categoryName == 'Kamera DSLR') {
      products = [
        {
          'name': 'Nikon D850',
          'description': 'Kamera DSLR dengan sensor full-frame 45.7MP.',
          'image': 'assets/images/nikon_d850.jpg',
        },
        {
          'name': 'Canon EOS 5D Mark IV',
          'description': 'Kamera DSLR dengan kemampuan perekaman 4K.',
          'image': 'assets/images/canon_5d_mark_iv.jpg',
        },
      ];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('$categoryName Produk'),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 3 / 4,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailPage(
                    name: product['name']!,
                    description: product['description']!,
                    image: product['image']!,
                  ),
                ),
              );
            },
            child: Card(
              child: Column(
                children: [
                  Expanded(
                    child: Image.asset(
                      product['image']!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      product['name']!,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
