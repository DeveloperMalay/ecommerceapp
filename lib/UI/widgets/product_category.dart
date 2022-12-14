import 'package:ecommerceapp/UI/views/product_category_view.dart';
import 'package:flutter/material.dart';

class ProductCategory extends StatelessWidget {
  ProductCategory({Key? key}) : super(key: key);

  final List<Map<String, String>> category = [
    {
      'imageUrl': 'assets/electronics.jpg',
      'title': 'electronics',
    },
    {
      'imageUrl': 'assets/jewelary.jpg',
      'title': 'jewelery',
    },
    {
      'imageUrl': 'assets/men.jpg',
      'title': "men's clothing",
    },
    {
      'imageUrl': 'assets/women.jpg',
      'title': "women's clothing",
    },
    {
      'imageUrl': 'assets/electronics.jpg',
      'title': 'electronics',
    },
    {
      'imageUrl': 'assets/jewelary.jpg',
      'title': 'jewelary',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: category.length,
          itemBuilder: (context, index) {
            var currentItem = category[index];
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ProductCategoryDetails(
                          categoryName: '${currentItem['title']}');
                    },
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(
                        "${currentItem['imageUrl']}",
                      ),
                      radius: 30,
                    ),
                    Text(
                      '${currentItem['title']}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
