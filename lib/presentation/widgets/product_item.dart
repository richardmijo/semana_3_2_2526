// lib/presentation/widgets/product_item.dart
import 'package:flutter/material.dart';
import '../../domain/entities/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  final VoidCallback onAddToCart;

  const ProductItem({
    Key? key,
    required this.product,
    required this.onAddToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: ListTile(
        title: Text(product.name),
        subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
        trailing: ElevatedButton.icon(
          onPressed: onAddToCart,
          icon: Icon(Icons.add_shopping_cart),
          label: Text('Agregar'),
        ),
      ),
    );
  }
}