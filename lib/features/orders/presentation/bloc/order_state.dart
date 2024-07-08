import '../../domain/entities/order.dart';
import '../../domain/entities/product.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;
  final List<OrderItem> orderItems;

  ProductLoaded({required this.products, required this.orderItems});
}

class ProductError extends ProductState {
  final String message;

  ProductError({required this.message});
}
