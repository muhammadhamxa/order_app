import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../services/di.dart';
import '../../../../utils/app_colors.dart';
import '../bloc/order_bloc.dart';
import '../bloc/order_event.dart';
import '../bloc/order_state.dart';
import '../widgets/product_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {},
          icon: Image.asset(
            'assets/images/menu.png',
            width: 30,
            height: 30,
          ),
        ),
        toolbarHeight: 123,
        title: Image.asset('assets/images/logo.png'),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        bloc: getIt<ProductBloc>(),
        builder: (context, state) {
          if (state is ProductInitial) {
            getIt<ProductBloc>().add(GetProductsEvent());
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductLoaded) {
            return ProductList(
              products: state.products,
              orderItems: state.orderItems,
            );
          } else if (state is ProductError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('Unexpected state'));
        },
      ),
    );
  }
}
