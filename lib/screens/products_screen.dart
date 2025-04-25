import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../providers/product_provider.dart';
import '../widgets/product_grid.dart';
import '../widgets/product_list_item.dart';
import '../widgets/cart_badge.dart';
import '../widgets/theme_switch.dart';
import 'cart_screen.dart';
import 'profile_screen.dart';
import 'add_edit_product_screen.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  bool _isInit = true;
  bool _isGrid = true; // Toggle between grid and list view
  String _selectedCategory = 'All'; // Current selected category filter

  // Pet shop categories
  final List<String> _categories = [
    'All',
    'Dogs',
    'Cats',
    'Food',
    'Toys',
    'Accessories',
  ];

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<ProductProvider>(context).fetchProducts();
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final apiProducts =
        productProvider.products.where((p) => !p.isUserAdded).toList();
    final userProducts = productProvider.userAddedProducts;
    final isLoading = productProvider.isLoading;
    final error = productProvider.error;

    // Filter products by category if not 'All'
    final displayedProducts =
        _selectedCategory == 'All'
            ? apiProducts
            : apiProducts.where((p) {
              // This is a simple filter, in a real app you'd have proper category data
              final name = p.title.toLowerCase();
              final category = _selectedCategory.toLowerCase();
              return name.contains(category);
            }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Fluffyn ',
              style: Theme.of(
                context,
              ).textTheme.titleLarge!.copyWith(color: Colors.white),
            ),
            const Text('🐾', style: TextStyle(fontSize: 24)),
          ],
        ),
        actions: [
          // Toggle view button
          IconButton(
            icon: Icon(_isGrid ? Icons.list : Icons.grid_view),
            onPressed: () {
              setState(() {
                _isGrid = !_isGrid;
              });
            },
          ),
          // Theme switch
          const Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: ThemeSwitch(),
          ),
          // Cart button with badge
          const CartBadge(),
          // Profile button
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => const ProfileScreen()),
              );
            },
          ),
        ],
      ),
      body:
          isLoading
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator()
                        .animate(onPlay: (controller) => controller.repeat())
                        .shimmer(
                          duration: 1200.ms,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                    const SizedBox(height: 16),
                    Text(
                      'Fetching pet products...',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              )
              : error.isNotEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error,
                      size: 60,
                      color: Colors.red,
                    ).animate().scale(
                      duration: 700.ms,
                      curve: Curves.easeOut,
                      begin: const Offset(0.5, 0.5),
                      end: const Offset(1.0, 1.0),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Error loading products',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(error),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isInit = true;
                          didChangeDependencies();
                        });
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              )
              : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Welcome banner
                    Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          margin: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            gradient: LinearGradient(
                              colors: [
                                Theme.of(context).colorScheme.primary,
                                Theme.of(
                                  context,
                                ).colorScheme.primary.withOpacity(0.7),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    '🐕',
                                    style: TextStyle(fontSize: 24),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Welcome to Fluffyn!',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.headlineSmall!.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Find the best products for your furry friends',
                                style: Theme.of(context).textTheme.bodyLarge!
                                    .copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        )
                        .animate()
                        .fadeIn(duration: 500.ms)
                        .slideY(
                          begin: 0.2,
                          end: 0,
                          duration: 500.ms,
                          curve: Curves.easeOutCubic,
                        ),

                    // Category filter scrollable row
                    Container(
                      height: 60,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _categories.length,
                        itemBuilder: (ctx, index) {
                          final category = _categories[index];
                          final isSelected = category == _selectedCategory;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedCategory = category;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 12),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    isSelected
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context).colorScheme.surface,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color:
                                      isSelected
                                          ? Theme.of(
                                            context,
                                          ).colorScheme.primary
                                          : Theme.of(context)
                                              .colorScheme
                                              .secondary
                                              .withOpacity(0.3),
                                  width: 1.5,
                                ),
                                boxShadow:
                                    isSelected
                                        ? [
                                          BoxShadow(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary
                                                .withOpacity(0.3),
                                            blurRadius: 8,
                                            offset: const Offset(0, 3),
                                          ),
                                        ]
                                        : null,
                              ),
                              child: Row(
                                children: [
                                  // Add an appropriate emoji for each category
                                  if (category == 'Dogs')
                                    const Text(
                                      '🐕 ',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  if (category == 'Cats')
                                    const Text(
                                      '🐈 ',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  if (category == 'Food')
                                    const Text(
                                      '🍖 ',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  if (category == 'Toys')
                                    const Text(
                                      '🧸 ',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  if (category == 'Accessories')
                                    const Text(
                                      '🧣 ',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  if (category == 'All')
                                    const Text(
                                      '🐾 ',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  Text(
                                    category,
                                    style: TextStyle(
                                      fontWeight:
                                          isSelected
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                      color: isSelected ? Colors.white : null,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ).animate().fadeIn(duration: 400.ms, delay: 200.ms),

                    // API Products
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 16,
                        bottom: 8,
                      ),
                      child: Row(
                        children: [
                          const Text('🐾', style: TextStyle(fontSize: 18)),
                          const SizedBox(width: 8),
                          Text(
                            _selectedCategory == 'All'
                                ? 'All Products'
                                : '${_selectedCategory} Products',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(
                                context,
                              ).colorScheme.primary.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              '${displayedProducts.length} items',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: _isGrid ? 500 : 400,
                      child:
                          displayedProducts.isEmpty
                              ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      '😿',
                                      style: TextStyle(fontSize: 48),
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      'No products found',
                                      style:
                                          Theme.of(
                                            context,
                                          ).textTheme.titleLarge,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Try a different category',
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                  ],
                                ),
                              )
                              : _isGrid
                              ? ProductGrid(products: displayedProducts)
                              : ListView.builder(
                                padding: const EdgeInsets.all(8),
                                itemCount: displayedProducts.length,
                                itemBuilder:
                                    (ctx, i) => ProductListItem(
                                          product: displayedProducts[i],
                                        )
                                        .animate(delay: (50 * i).ms)
                                        .fadeIn(
                                          duration: 300.ms,
                                          curve: Curves.easeOut,
                                        )
                                        .slideY(
                                          begin: 0.1,
                                          end: 0,
                                          curve: Curves.easeOut,
                                          duration: 300.ms,
                                        ),
                              ),
                    ),

                    // User Added Products
                    if (userProducts.isNotEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                          top: 24,
                          bottom: 8,
                        ),
                        child: Row(
                          children: [
                            const Text('👤', style: TextStyle(fontSize: 18)),
                            const SizedBox(width: 8),
                            Text(
                              'My Products',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${userProducts.length}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: _isGrid ? 350 : 250,
                        child:
                            _isGrid
                                ? ProductGrid(products: userProducts)
                                : ListView.builder(
                                  padding: const EdgeInsets.all(8),
                                  itemCount: userProducts.length,
                                  itemBuilder:
                                      (ctx, i) => ProductListItem(
                                            product: userProducts[i],
                                          )
                                          .animate(delay: (50 * i).ms)
                                          .fadeIn(
                                            duration: 300.ms,
                                            curve: Curves.easeOut,
                                          )
                                          .slideY(
                                            begin: 0.1,
                                            end: 0,
                                            curve: Curves.easeOut,
                                            duration: 300.ms,
                                          ),
                                ),
                      ),
                    ],

                    // Pet care tips
                    Container(
                      margin: const EdgeInsets.all(16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.secondary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: Theme.of(
                            context,
                          ).colorScheme.secondary.withOpacity(0.3),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text('💡', style: TextStyle(fontSize: 20)),
                              const SizedBox(width: 8),
                              Text(
                                'Pet Care Tip',
                                style: Theme.of(
                                  context,
                                ).textTheme.titleMedium!.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Regular grooming is important for your pet\'s health. Brush your pet\'s fur at least once a week.',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ).animate().fadeIn(duration: 400.ms, delay: 500.ms),

                    const SizedBox(height: 40), // Bottom padding
                  ],
                ),
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (ctx) => const AddEditProductScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
