import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/use_case.dart';
import '../../domain/entities/order.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/get_products.dart';
import '../pages/preview_order.dart';
import 'order_event.dart';
import 'order_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProducts getProducts;

  ProductBloc(productRepository, {required this.getProducts})
      : super(ProductInitial()) {
    on<GetProductsEvent>(_onGetProducts);
    on<AddProductRowEvent>(_onAddProductRow);
    on<UpdateProductRowEvent>(_onUpdateProductRow);
    on<ClearOrderEvent>(_onClearOrder);
    on<SubmitOrderEvent>(_onSubmitOrder);
  }

  Future<void> _onGetProducts(
      GetProductsEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    final failureOrProducts = await getProducts(NoParams());
    emit(failureOrProducts.fold(
      (failure) => ProductError(message: _mapFailureToMessage(failure)),
      (products) {
        if (products.isEmpty) {
          return ProductError(message: 'No products available');
        }
        debugPrint(products.toString());
        return ProductLoaded(
          products: products
              .map((name) => Product(name: name.name, id: name.id))
              .toList(),
          orderItems: [],
        );
      },
    ));
  }

  void _onAddProductRow(AddProductRowEvent event, Emitter<ProductState> emit) {
    if (state is ProductLoaded) {
      final currentState = state as ProductLoaded;
      emit(ProductLoaded(
        products: currentState.products,
        orderItems: [
          ...currentState.orderItems,
          OrderItem(productName: '', quantity: 0)
        ],
      ));
    }
  }

  void _onUpdateProductRow(
      UpdateProductRowEvent event, Emitter<ProductState> emit) {
    if (state is ProductLoaded) {
      final currentState = state as ProductLoaded;
      final updatedOrderItems = List<OrderItem>.from(currentState.orderItems);
      updatedOrderItems[event.index] = OrderItem(
        productName: event.productName,
        quantity: event.quantity,
      );
      emit(ProductLoaded(
        products: currentState.products,
        orderItems: updatedOrderItems,
      ));
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server Failure';
      default:
        return 'Unexpected Error';
    }
  }

  void _onClearOrder(ClearOrderEvent event, Emitter<ProductState> emit) {
    if (state is ProductLoaded) {
      emit(ProductLoaded(products: [], orderItems: []));
    }
  }

  void _onSubmitOrder(SubmitOrderEvent event, Emitter<ProductState> emit) {
    if (state is ProductLoaded) {
      final currentState = state as ProductLoaded;
      final orderItems = currentState.orderItems;

      // Generate a unique order number (For simplicity, using current timestamp)
      final orderNumber = DateTime.now().millisecondsSinceEpoch;
      // Navigate to the PreviewScreen
      Navigator.push(
        event.context,
        MaterialPageRoute(
          builder: (context) =>
              PreviewScreen(orderNumber: orderNumber, orderItems: orderItems),
        ),
      );
    }
  }
}
