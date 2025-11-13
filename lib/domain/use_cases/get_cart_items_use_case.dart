// lib/domain/use_cases/get_cart_items_use_case.dart
import '../entities/product.dart';
import '../repositories/cart_repository.dart';

class GetCartItemsUseCase {
  final CartRepository repository;

  GetCartItemsUseCase(this.repository);

  List<Product> execute() {
    return repository.getCartItems();
  }
}