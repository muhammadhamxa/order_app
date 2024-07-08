import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_app/features/orders/presentation/bloc/order_state.dart';
import 'package:order_app/utils/app_colors.dart';

import '../../../../services/di.dart';
import '../../domain/entities/order.dart';
import '../../domain/entities/product.dart';
import '../bloc/order_bloc.dart';
import '../bloc/order_event.dart';
import 'product_input_row.dart';

class ProductList extends StatelessWidget {
  final List<Product> products;
  final List<OrderItem> orderItems;

  const ProductList(
      {super.key, required this.products, required this.orderItems});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      child: Column(
        children: [
          BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              (state as ProductLoaded);

              if (state.orderItems.isEmpty) {
                return const SizedBox();
              } else {
                return Row(
                  children: [
                    IconButton(
                      onPressed: orderItems.isNotEmpty
                          ? () {
                              getIt<ProductBloc>().add(ClearOrderEvent());
                            }
                          : null,
                      icon: const Icon(
                        Icons.close,
                        color: greenishColor,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: orderItems.isNotEmpty
                          ? () {
                              getIt<ProductBloc>()
                                  .add(SubmitOrderEvent(context: context));
                            }
                          : null,
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        color: greenishColor,
                      ),
                    ),
                  ],
                );
              }
            },
            bloc: getIt<ProductBloc>(),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: orderItems.length + 1,
              itemBuilder: (context, index) {
                if (index == orderItems.length) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: greenishColor,
                          foregroundColor: whiteColor),
                      onPressed: () {
                        getIt<ProductBloc>().add(AddProductRowEvent());
                      },
                      child: const Text('Add Product'),
                    ),
                  );
                }
                return ProductInputRow(
                  products: products,
                  orderItem: orderItems[index],
                  onChanged: (productName, quantity) {
                    getIt<ProductBloc>().add(
                      UpdateProductRowEvent(
                        index: index,
                        productName: productName,
                        quantity: quantity,
                      ),
                    );
                  },
                );
              },
            ),
          ),
          // ElevatedButton(
          //   onPressed: orderItems.isNotEmpty
          //       ? () {
          //           // Navigate to preview page
          //         }
          //       : null,
          //   child: const Text('Submit'),
          // ),
          // ElevatedButton(
          //   onPressed: orderItems.isNotEmpty
          //       ? () {
          //           // Clear all order items
          //         }
          //       : null,
          //   child: const Text('Clean'),
          // ),
        ],
      ),
    );
  }
}
