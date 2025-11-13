// lib/domain/repositories/cart_repository.dart
import '../entities/product.dart';

abstract class CartRepository {
  List<Product> getCartItems();
  void addProduct(Product product);
  void removeProduct(String productId);
  void clearCart();
  double getTotalPrice();
}