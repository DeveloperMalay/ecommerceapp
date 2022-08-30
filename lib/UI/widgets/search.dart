import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
        height: 50,
        width: 400,
        child: TextField(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search_rounded),
            labelText: 'Search',
          ),
        ),
      ),
    );
  }
}
