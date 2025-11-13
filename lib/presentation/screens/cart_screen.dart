// lib/presentation/screens/cart_screen.dart
import 'package:flutter/material.dart';
import '../../domain/use_cases/get_cart_items_use_case.dart';
import '../../domain/use_cases/remove_from_cart_use_case.dart';
import '../../data/datasources/cart_local_datasource.dart';
import '../../data/repositories/cart_repository_impl.dart';

class CartScreen extends StatefulWidget {
  final CartLocalDataSource dataSource; // ⚠️ Recibimos el dataSource

  const CartScreen({Key? key, required this.dataSource}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late final GetCartItemsUseCase _getCartItemsUseCase;
  late final RemoveFromCartUseCase _removeFromCartUseCase;

  @override
  void initState() {
    super.initState();
    final repository = CartRepositoryImpl(widget.dataSource);
    _getCartItemsUseCase = GetCartItemsUseCase(repository);
    _removeFromCartUseCase = RemoveFromCartUseCase(repository);
  }

  void _handleRemove(String productId) {
    setState(() {  // 🔴 setState local
      _removeFromCartUseCase.execute(productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartItems = _getCartItemsUseCase.execute();
    final total = cartItems.fold(0.0, (sum, item) => sum + item.price);

    return Scaffold(
      appBar: AppBar(
        title: Text('Mi Carrito'),
      ),
      body: cartItems.isEmpty
          ? Center(child: Text('Carrito vacío'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final product = cartItems[index];
                      return ListTile(
                        title: Text(product.name),
                        subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _handleRemove(product.id),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  color: Colors.grey[200],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      Text('\$${total.toStringAsFixed(2)}', style: TextStyle(fontSize: 20)),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}