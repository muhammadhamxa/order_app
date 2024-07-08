import 'package:flutter/material.dart';

abstract class ProductEvent {}

class GetProductsEvent extends ProductEvent {}

class AddProductRowEvent extends ProductEvent {}

class UpdateProductRowEvent extends ProductEvent {
  final int index;
  final String productName;
  final int quantity;

  UpdateProductRowEvent(
      {required this.index, required this.productName, required this.quantity});
}

class ClearOrderEvent extends ProductEvent {}

class SubmitOrderEvent extends ProductEvent {
  final BuildContext context;

  SubmitOrderEvent({required this.context});
}
