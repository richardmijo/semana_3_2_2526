// lib/domain/use_cases/remove_from_cart_use_case.dart
import '../repositories/cart_repository.dart';

class RemoveFromCartUseCase {
  final CartRepository repository;

  RemoveFromCartUseCase(this.repository);

  void execute(String productId) {
    repository.removeProduct(productId);
  }
}