import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/cart_provider.dart';
import '../widgets/cart_item_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.items.values.toList();
    final totalAmount = cartProvider.totalAmount;
    final currencyFormat = NumberFormat.currency(symbol: '\$');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        actions: [
          if (cartItems.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep),
              onPressed: () {
                showDialog(
                  context: context,
                  builder:
                      (ctx) => AlertDialog(
                        title: const Text('Clear Cart'),
                        content: const Text(
                          'Are you sure you want to remove all items from your cart?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(ctx).pop(),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              cartProvider.clear();
                              Navigator.of(ctx).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Cart cleared'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            },
                            child: const Text(
                              'Clear All',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                );
              },
            ),
        ],
      ),
      body: Column(
        children: [
          // Cart Items List
          Expanded(
            child:
                cartItems.isEmpty
                    ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_cart_outlined,
                            size: 100,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Your cart is empty',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Add some products to your cart',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton.icon(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const Icon(Icons.shopping_bag),
                            label: const Text('Start Shopping'),
                          ),
                        ],
                      ),
                    )
                    : ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder:
                          (ctx, i) => CartItemWidget(cartItem: cartItems[i]),
                    ),
          ),

          // Order Summary
          if (cartItems.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, -3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Order summary
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total (${cartItems.length} item${cartItems.length > 1 ? 's' : ''})',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        currencyFormat.format(totalAmount),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Checkout button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        // Show a confirmation dialog for checkout
                        showDialog(
                          context: context,
                          builder:
                              (ctx) => AlertDialog(
                                title: const Text('Checkout'),
                                content: const Text(
                                  'This is a demo app. In a real app, this would proceed to the checkout process.',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.payment),
                          SizedBox(width: 8),
                          Text(
                            'CHECKOUT',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
