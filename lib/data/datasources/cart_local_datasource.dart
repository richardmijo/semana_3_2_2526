// lib/data/datasources/cart_local_datasource.dart
import '../../domain/entities/product.dart';

class CartLocalDataSource {
  final List<Product> _cartItems = [];

  List<Product> getItems() => List.unmodifiable(_cartItems);

  void addItem(Product product) {
    _cartItems.add(product);
  }

  void removeItem(String productId) {
    _cartItems.removeWhere((item) => item.id == productId);
  }

  void clear() {
    _cartItems.clear();
  }
}