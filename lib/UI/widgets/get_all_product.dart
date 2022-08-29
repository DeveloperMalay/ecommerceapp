import 'package:ecommerceapp/bloc/getproduct_bloc.dart';
import 'package:ecommerceapp/bloc/getproduct_event.dart';
import 'package:ecommerceapp/bloc/getproduct_state.dart';
import 'package:ecommerceapp/models/get_all_products_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetAllProducts extends StatefulWidget {
  const GetAllProducts({Key? key}) : super(key: key);

  @override
  State<GetAllProducts> createState() => _GetAllProductsState();
}

class _GetAllProductsState extends State<GetAllProducts> {
  final GetProductsBloc _newBloc = GetProductsBloc();

  @override
  void initState() {
    _newBloc.add(GetProductsList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(8),
        child: BlocProvider(
          create: (_) => _newBloc,
          child: BlocListener<GetProductsBloc, GetProductState>(
            listener: (context, state) {
              if (state is ProductError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message!),
                  ),
                );
              }
            },
            child: BlocBuilder<GetProductsBloc, GetProductState>(
              builder: (context, state) {
                if (state is Productinitial) {
                  return _buildLoading();
                } else if (state is ProductLoading) {
                  return _buildLoading();
                } else if (state is ProductLoaded) {
                  return _buildCard(context, state.allproducts);
                } else {
                  return Container();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildCard(BuildContext context, AllProducts model) {
  return Expanded(
    child: ListView.builder(
      itemCount: model.id,
      itemBuilder: (context, index) {
        return Column(
          children: [
            SizedBox(height: 100, child: Text('${model.title}')),
          ],
        );
      },
    ),
  );
}

Widget _buildLoading() => const Center(child: CircularProgressIndicator());
