// lib/features/cart/models/product.dart
class Product {
  final String id;
  final String name;
  final double price;

  Product({
    required this.id,
    required this.name,
    required this.price,
  });
}

// Productos de ejemplo para la tienda
List<Product> getProductList() {
  return [
    Product(id: '1', name: 'Laptop HP', price: 899.99),
    Product(id: '2', name: 'Mouse Inalámbrico', price: 25.50),
    Product(id: '3', name: 'Teclado Mecánico', price: 75.00),
    Product(id: '4', name: 'Monitor 24"', price: 199.99),
    Product(id: '5', name: 'Webcam HD', price: 45.00),
  ];
}