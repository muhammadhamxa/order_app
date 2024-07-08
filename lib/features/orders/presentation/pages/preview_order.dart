import 'package:flutter/material.dart';

import '../../../../utils/app_colors.dart';
import '../../domain/entities/order.dart';

class PreviewScreen extends StatelessWidget {
  final int orderNumber;
  final List<OrderItem> orderItems;

  const PreviewScreen(
      {super.key, required this.orderNumber, required this.orderItems});

  @override
  Widget build(BuildContext context) {
    print('items => $orderItems');
    return Scaffold(
      backgroundColor: whiteColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png'),
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: greenishColor,
                ),
              ),
            ),
            const SizedBox(height: 20),
            _orderRow('Order Number#', orderNumber.toString()),
            const SizedBox(height: 10),
            _orderRow('Order Name', 'Joe\'s Catering'),
            const SizedBox(height: 10),
            _orderRow('Delivery Date', 'May 4th 2024'),
            const SizedBox(height: 10),
            _orderRow('Total Quantity', '38'),
            const SizedBox(height: 10),
            _orderRow('Estimated Total', '\$1402.96'),
            const SizedBox(height: 10),
            _orderRow('Location', '355 onderdonk stMarina Dubai, UAE'),
            const SizedBox(height: 25),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Delivery instructions ...',
                style: TextStyle(
                  color: greenishColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              width: double.maxFinite,
              child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: greenishColor,
                      foregroundColor: whiteColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  child: const Text('submit')),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(foregroundColor: greenishColor),
                child: const Text('Save as draft'),
              ),
            )
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: orderItems.length,
            //     itemBuilder: (context, index) {
            //       final orderItem = orderItems[index];
            //       return _orderRow(title, value)
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Row _orderRow(String title, String value) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: purpleColor,
          ),
        ),
        const Spacer(),
        Container(
          width: 140,
          alignment: Alignment.centerLeft,
          child: Text(
            value,
            textAlign: TextAlign.left,
            style: const TextStyle(
              color: greenishColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
