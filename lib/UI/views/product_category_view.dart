import 'package:flutter/material.dart';

class ProductCategory extends StatefulWidget {
  const ProductCategory({Key? key, required this.categoryName})
      : super(key: key);
  final String categoryName;
  @override
  State<ProductCategory> createState() => _ProductCategoryState();
}

class _ProductCategoryState extends State<ProductCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.categoryName)),
      body: Container(),
    );
  }
}
