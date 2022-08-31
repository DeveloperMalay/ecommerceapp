import 'package:ecommerceapp/UI/theme/theme.dart';
import 'package:ecommerceapp/UI/views/home_view.dart';
import 'package:ecommerceapp/models/new_model.dart';
import 'package:ecommerceapp/networking/new_api_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductDetailView extends StatefulWidget {
  const ProductDetailView({Key? key, required this.productID})
      : super(key: key);
  final int productID;
  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  ApiProvider _provider = ApiProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const HomeView();
                },
              ),
            );
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 30,
            color: Colors.white,
          ),
        ),
        title: const Text(
          'Product Details',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: theme.scaffoldBackgroundColor,
        child: FutureBuilder<Product>(
          future: _provider.getProductById(widget.productID),
          builder: (context, snapshot) {
            final product = snapshot.data;
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());

              default:
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('error occured'),
                  );
                } else {
                  return buildProduct(product!);
                }
            }
          },
        ),
      ),
    );
  }

  Widget buildProduct(Product product) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.all(10),
            height: 400,
            width: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Image.network(
              product.image,
              height: 100,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            product.title,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Text(product.category.toString()),
              const SizedBox(
                width: 24,
              ),
              const Icon(
                Icons.star,
                color: Color.fromARGB(255, 226, 183, 25),
              ),
              Text(product.rating.rate.toString()),
              const SizedBox(
                width: 10,
              ),
              Text(
                "(${product.rating.count.toString()} reviews)",
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Information',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 95, child: Text(product.description)),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Text(
                "\$ ${product.price.toString()}",
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 110,
              ),
              CupertinoButton(
                color: theme.primaryColorDark,
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                alignment: Alignment.center,
                child: Row(
                  children: const [
                    Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                    Text(
                      'Add to Cart',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                onPressed: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}
