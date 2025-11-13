// lib/presentation/widgets/cart_badge.dart
import 'package:flutter/material.dart';

class CartBadge extends StatelessWidget {
  final int itemCount;
  final VoidCallback onPressed;

  const CartBadge({
    Key? key,
    required this.itemCount,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: onPressed,
        ),
        if (itemCount > 0)
          Positioned(
            right: 8,
            top: 8,
            child: CircleAvatar(
              radius: 8,
              backgroundColor: Colors.red,
              child: Text(
                '$itemCount',
                style: TextStyle(fontSize: 10, color: Colors.white),
              ),
            ),
          ),
      ],
    );
  }
}