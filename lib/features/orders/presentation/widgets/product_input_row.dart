import 'package:flutter/material.dart';
import 'package:order_app/utils/app_colors.dart';

import '../../domain/entities/order.dart';
import '../../domain/entities/product.dart';

class ProductInputRow extends StatelessWidget {
  final List<Product> products;
  final OrderItem orderItem;
  final Function(String, int) onChanged;

  const ProductInputRow({
    super.key,
    required this.products,
    required this.orderItem,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            decoration: const BoxDecoration(
                border: Border(
              bottom: BorderSide(color: greenishColor),
            )),
            child: TextFormField(
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.zero,
                labelText: 'Quantity',
                border: InputBorder.none,
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                onChanged(orderItem.productName, int.tryParse(value) ?? 0);
              },
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: greenishColor),
                left: BorderSide(color: greenishColor),
              ),
            ),
            child: Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                return products
                    .where((product) => product.name
                        .toLowerCase()
                        .contains(textEditingValue.text.toLowerCase()))
                    .map((product) => product.name);
              },
              onSelected: (String selection) {
                onChanged(selection, orderItem.quantity);
              },
            ),
          ),
        ),
      ],
    );
  }
}
