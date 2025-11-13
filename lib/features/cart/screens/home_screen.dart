// lib/features/cart/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../widgets/product_item.dart';
import '../widgets/cart_badge.dart';
import 'cart_screen.dart';

// ✅ Ahora puede ser StatelessWidget (sin estado local)
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Lista de productos
    final products = getProductList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Mi Tienda - Provider'),
        backgroundColor: Colors.blue,
        actions: [
          // 🎯 Consumer: Se reconstruye automáticamente cuando hay cambios
          Consumer<CartProvider>(
            builder: (context, cartProvider, child) {
              return CartBadge(
                itemCount: cartProvider.itemCount,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CartScreen()),
                  );
                  // ✅ NO necesitamos hacer nada al regresar
                  // El Consumer ya escucha los cambios automáticamente
                },
              );
            },
          ),
          SizedBox(width: 8),
        ],
      ),
      body: products.isEmpty
          ? Center(child: Text('No hay productos disponibles'))
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ProductItem(
                  product: products[index],
                  onAddToCart: () {
                    // 🚀 Acceso directo al Provider
                    // context.read NO reconstruye este widget
                    context.read<CartProvider>().addProduct(products[index]);
                    
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('✓ ${products[index].name} agregado'),
                        duration: Duration(seconds: 1),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}