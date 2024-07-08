class Order {
  final String orderNumber;
  final List<OrderItem> items;

  Order({required this.orderNumber, required this.items});
}

class OrderItem {
  final String productName;
  final int quantity;
  final String? notes;
  final String? imagePath;

  OrderItem({
    required this.productName,
    required this.quantity,
    this.notes,
    this.imagePath,
  });
}
