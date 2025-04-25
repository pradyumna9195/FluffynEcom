import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../providers/product_provider.dart';
import '../screens/add_edit_product_screen.dart';
import '../screens/cart_screen.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({Key? key, required this.product})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final productProvider = Provider.of<ProductProvider>(
      context,
      listen: false,
    );
    final isUserAdded = product.isUserAdded;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          if (isUserAdded)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                // Navigate to edit product screen
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => AddEditProductScreen(product: product),
                  ),
                );
              },
            ),
          if (isUserAdded)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                showDialog(
                  context: context,
                  builder:
                      (ctx) => AlertDialog(
                        title: const Text('Delete Product'),
                        content: const Text(
                          'Are you sure you want to delete this product?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                            },
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              productProvider.deleteProduct(product.id!);
                              Navigator.of(ctx).pop();
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Product deleted'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            },
                            child: const Text(
                              'Delete',
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Hero(
                tag: 'product-${product.id}',
                child: CachedNetworkImage(
                  imageUrl: product.image,
                  fit: BoxFit.contain,
                  placeholder:
                      (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                  errorWidget:
                      (context, url, error) => Container(
                        color: Colors.grey[200],
                        child: const Icon(Icons.image, size: 100),
                      ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (product.rating != null)
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber),
                            const SizedBox(width: 4),
                            Text(
                              '${product.rating!.rate} (${product.rating!.count})',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Category
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.secondary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      product.category.toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Description
                  const Text(
                    'Description',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                  const SizedBox(height: 24),
                  // Add to cart button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        cartProvider.addItem(product);
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Added item to cart!'),
                            duration: const Duration(seconds: 2),
                            action: SnackBarAction(
                              label: 'VIEW CART',
                              onPressed: () {
                                // Navigate to cart screen
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (ctx) => const CartScreen(),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.shopping_cart),
                      label: const Text('ADD TO CART'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
