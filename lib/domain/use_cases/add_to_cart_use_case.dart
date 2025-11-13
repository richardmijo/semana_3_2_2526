// lib/domain/use_cases/add_to_cart_use_case.dart
import '../entities/product.dart';
import '../repositories/cart_repository.dart';

class AddToCartUseCase {
  final CartRepository repository;

  AddToCartUseCase(this.repository);

  void execute(Product product) {
    repository.addProduct(product);
  }
}