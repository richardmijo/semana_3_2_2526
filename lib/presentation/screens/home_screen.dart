// lib/presentation/screens/home_screen.dart
import 'package:flutter/material.dart';
import '../../domain/entities/product.dart';
import '../../domain/use_cases/add_to_cart_use_case.dart';
import '../../domain/use_cases/get_cart_items_use_case.dart';
import '../../data/datasources/cart_local_datasource.dart';
import '../../data/repositories/cart_repository_impl.dart';
import '../widgets/product_item.dart';
import '../widgets/cart_badge.dart';
import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ⚠️ PROBLEMA: Estado vive aquí, no se comparte
  late final AddToCartUseCase _addToCartUseCase;
  late final GetCartItemsUseCase _getCartItemsUseCase;
  late final CartLocalDataSource _dataSource;
  
  // Lista de productos mock
  final List<Product> _products = [
    Product(id: '1', name: 'Laptop Lenovo', price: 899.99),
    Product(id: '2', name: 'Mouse Logitech', price: 25.50),
    Product(id: '3', name: 'Teclado Mecánico', price: 75.00),
    Product(id: '4', name: 'Monitor 24"', price: 199.99),
  ];

  @override
  void initState() {
    super.initState();
    // Inyección manual de dependencias
    _dataSource = CartLocalDataSource();
    final repository = CartRepositoryImpl(_dataSource);
    _addToCartUseCase = AddToCartUseCase(repository);
    _getCartItemsUseCase = GetCartItemsUseCase(repository);
  }

  void _handleAddToCart(Product product) {
    setState(() {  // 🔴 setState actualiza SOLO este widget
      _addToCartUseCase.execute(product);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} agregado'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartItems = _getCartItemsUseCase.execute();

    return Scaffold(
      appBar: AppBar(
        title: Text('Tienda - setState'),
        actions: [
          CartBadge(
            itemCount: cartItems.length,
            onPressed: () async {
              // ⚠️ Tenemos que pasar el dataSource manualmente
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(dataSource: _dataSource),
                ),
              );
              // ⚠️ Tenemos que refrescar manualmente al regresar
              setState(() {});
            },
          ),
        ],
      ),
      body: ListView.builder(
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