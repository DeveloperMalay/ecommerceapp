import 'package:ecommerceapp/UI/theme/theme.dart';
import 'package:ecommerceapp/UI/views/product_details_view.dart';
import 'package:ecommerceapp/models/new_model.dart';
import 'package:ecommerceapp/networking/new_api_provider.dart';
import 'package:flutter/material.dart';

class ProductCategoryDetails extends StatefulWidget {
  const ProductCategoryDetails({Key? key, required this.categoryName})
      : super(key: key);
  final String categoryName;
  @override
  State<ProductCategoryDetails> createState() => _ProductCategoryDetailsState();
}

class _ProductCategoryDetailsState extends State<ProductCategoryDetails> {
  ApiProvider _provider = ApiProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.categoryName)),
      body: Container(
        color: theme.scaffoldBackgroundColor,
        child: FutureBuilder<List<Product>>(
          future: _provider.getProductByCategoty(widget.categoryName),
          builder: (context, snapshot) {
            final productCategory = snapshot.data;
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());

              default:
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('error occured'),
                  );
                } else {
                  return _buildProductCategory(productCategory!);
                }
            }
          },
        ),
      ),
    );
  }

  Widget _buildProductCategory(List<Product> model) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 8),
      child: Expanded(
        child: GridView.builder(
          itemCount: model.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 20, mainAxisSpacing: 20, crossAxisCount: 2),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ProductDetailView(
                    productID: model[index].id,
                  );
                }));
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(model[index].image),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      model[index].title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "\$ ${model[index].price.toString()}",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 253, 104, 104),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
