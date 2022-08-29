import 'package:ecommerceapp/UI/theme/theme.dart';
import 'package:ecommerceapp/bloc/getproduct_bloc.dart';
import 'package:ecommerceapp/bloc/getproduct_event.dart';
import 'package:ecommerceapp/bloc/getproduct_state.dart';
import 'package:ecommerceapp/models/new_model.dart';
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
                  return const Text("something wrong");
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildCard(BuildContext context, List<Product> model) {
  return Expanded(
    child: SizedBox(
      height: MediaQuery.of(context).size.height,
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 20, mainAxisSpacing: 20, crossAxisCount: 2),
        itemCount: model.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(model[index].image),
                            fit: BoxFit.contain)),
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
          );
        },
      ),
    ),
  );
}

Widget _buildLoading() => const Center(child: CircularProgressIndicator());
