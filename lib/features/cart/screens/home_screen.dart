// lib/features/cart/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:semana_3_2_2526/features/cart/widgets/cart_badge.dart';
import '../models/product.dart';
import '../repositories/cart_repository.dart';
import '../widgets/product_item.dart';
import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 🔴 PROBLEMA: El repositorio vive solo en este widget
  final CartRepository _cartRepository = CartRepository();
  
  // Lista de productos
  final List<Product> _products = getProductList();

  // Método para agregar al carrito
  void _handleAddToCart(Product product) {
    setState(() {  
      // 🔴 setState actualiza SOLO este widget
      _cartRepository.addProduct(product);
    });

    // Mostrar confirmación
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('✓ ${product.name} agregado al carrito'),
        duration: Duration(seconds: 1),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi Tienda - setState'),
        backgroundColor: Colors.blue,
        actions: [
          CartBadge(
            itemCount: _cartRepository.getCount(),
            onPressed: () async {
              // ⚠️ Tenemos que PASAR el repositorio manualmente
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(
                    cartRepository: _cartRepository,
                  ),
                ),
              );
              
              // ⚠️ PROBLEMA: Tenemos que refrescar manualmente al volver
              setState(() {});
            },
          ),
          SizedBox(width: 8),
        ],
      ),
      body: _products.isEmpty
          ? Center(child: Text('No hay productos disponibles'))
          : ListView.builder(
              itemCount: _products.length,
              itemBuilder: (context, index) {
                return ProductItem(
                  product: _products[index],
                  onAddToCart: () => _handleAddToCart(_products[index]),
                );
              },
            ),
    );
  }
}