import 'package:ecommerceapp/UI/theme/theme.dart';
import 'package:ecommerceapp/UI/widgets/get_all_product.dart';
import 'package:ecommerceapp/UI/widgets/product_category.dart';
import 'package:ecommerceapp/UI/widgets/search.dart';
import 'package:ecommerceapp/UI/widgets/slider.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ecommerce'),
       
        actions: [
          const Icon(
            Icons.favorite_rounded,
            color: Colors.red,
          ),
          const SizedBox(width: 20),
          const Icon(Icons.shopping_cart_rounded),
          const SizedBox(width: 20),
          CircleAvatar(
            backgroundColor: theme.scaffoldBackgroundColor,
            child: const Icon(Icons.person),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Column(
        // mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          const Search(),
          const ImageSlider(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Category',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ProductCategory(),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'All Products',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: GetAllProducts(),
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: theme.primaryColorDark,
        ),
        child: IconButton(
          splashColor: theme.primaryColor,
          icon: const Icon(
            Icons.add,
            color: Colors.white,
            size: 35,
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
