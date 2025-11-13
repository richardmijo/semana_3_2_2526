// lib/features/cart/providers/cart_provider.dart
import 'package:flutter/foundation.dart';
import '../models/product.dart';
import '../repositories/cart_repository.dart';

// 🟢 Provider: Notifica automáticamente a todos los widgets que escuchan
class CartProvider extends ChangeNotifier {
  final CartRepository _repository = CartRepository();

  // Getters públicos
  List<Product> get items => _repository.getItems();
  
  int get itemCount => _repository.getCount();
  
  double get totalPrice => _repository.getTotal();
  
  bool get isEmpty => items.isEmpty;

  // Métodos públicos que notifican cambios
  void addProduct(Product product) {
    _repository.addProduct(product);
    notifyListeners(); // 🚀 Notifica a TODOS los widgets escuchando
  }

  void removeProduct(String productId) {
    _repository.removeProduct(productId);
    notifyListeners(); // 🚀 Actualización automática
  }

  void clearCart() {
    _repository.clear();
    notifyListeners();
  }
}