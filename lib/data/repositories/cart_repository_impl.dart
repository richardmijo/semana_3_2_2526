// lib/data/repositories/cart_repository_impl.dart
import '../../domain/entities/product.dart';
import '../../domain/repositories/cart_repository.dart';
import '../datasources/cart_local_datasource.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource dataSource;

  CartRepositoryImpl(this.dataSource);

  @override
  List<Product> getCartItems() {
    return dataSource.getItems();
  }

  @override
  void addProduct(Product product) {
    dataSource.addItem(product);
  }

  @override
  void removeProduct(String productId) {
    dataSource.removeItem(productId);
  }

  @override
  void clearCart() {
    dataSource.clear();
  }

  @override
  double getTotalPrice() {
    return dataSource.getItems().fold(0, (sum, item) => sum + item.price);
  }
}