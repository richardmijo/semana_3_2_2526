// lib/features/cart/repositories/cart_repository.dart
import '../models/product.dart';

class CartRepository {
  // Aquí guardamos los productos del carrito
  final List<Product> _items = [];

  // Obtener todos los productos
  List<Product> getItems() {
    return List.unmodifiable(_items);
  }

  // Agregar producto
  void addProduct(Product product) {
    _items.add(product);
  }

  // Eliminar producto
  void removeProduct(String productId) {
    _items.removeWhere((item) => item.id == productId);
  }

  // Limpiar carrito
  void clear() {
    _items.clear();
  }

  // Calcular total
  double getTotal() {
    return _items.fold(0, (sum, item) => sum + item.price);
  }

  // Contar items
  int getCount() {
    return _items.length;
  }
}