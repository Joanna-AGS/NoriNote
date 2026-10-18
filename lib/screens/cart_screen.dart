import 'package:flutter/material.dart';

// ============================================================================
// KANTINKU: CART SCREEN (Week 8: Reading Shared State from Parent)
// Alta Global School | IT Grade 10 & 11 (SHS)
//
// WEEK 8 CONCEPTS DEMONSTRATED HERE:
// 1. Receiving State via Constructor: CartScreen receives `cartItems` from HomeScreen.
// 2. Stateless Architecture: CartScreen does not need its own state,
//    it simply renders the data owned and shared by HomeScreen (Lifting State Up).
// 3. Data Aggregation: Calculates total order price using `fold()`.
// 4. Empty State Handling: Friendly UI when the cart has no items.
//
// Look for '// [CHANGE HERE]' comments to customize your team's cart screen!
// ============================================================================

class CartScreen extends StatelessWidget {
  // [CHANGE HERE]: Receives cart items stored in HomeScreen
  final List<Map<String, dynamic>> cartItems;

  const CartScreen({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    const Color brandTeal = Color(0xFFF6DB56);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F2EC),
      appBar: AppBar(
        title: const Text(
          'Recently Done',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: brandTeal,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: cartItems.isEmpty
          ? _buildEmptyState(context, brandTeal)
    : _buildCartList(brandTeal),
        ),
      );
   }

  // --------------------------------------------------------------------------
  // Empty state view when cart contains no items
  // --------------------------------------------------------------------------
  Widget _buildEmptyState(BuildContext context, Color brandColor) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Color(0xFFE8F4FD),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.sentiment_satisfied, size: 64, color: brandColor),
            ),
            const SizedBox(height: 20),
            const Text(
              'No completed tasks yet!', // [CHANGE HERE]: Empty state title
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFFF6DB56)),
            ),
            const SizedBox(height: 8),
            const Text(
              'Tasks you check off will appear here.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Color(0xFFF6DB56)),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              label: const Text('Back', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: brandColor,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        ),
      ),
    );
  }
 // --------------------------------------------------------------------------
// Completed tasks list
// --------------------------------------------------------------------------
Widget _buildCartList(Color brandColor) {
  return Column(
    children: [
      Expanded(
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: cartItems.length,
          separatorBuilder: (context, index) =>
              const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final item = cartItems[index];

            return Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(
                  color: Color(0xFF8E9AAF),
                  width: 0.5,
                ),
              ),
              child: ListTile(
                leading: Container(
                  width: 44,
                  height: 44,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFAFAF7),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    item['emoji'] as String? ?? '✅',
                    style: const TextStyle(fontSize: 22),
                  ),
                ),
                title: Text(
                  item['name'] as String? ?? 'Untitled Task',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                subtitle: Text(
                  item['desc'] as String? ?? 'Completed task',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF607D8B),
                  ),
                ),
                trailing: Icon(
                  Icons.check_circle,
                  color: brandColor,
                ),
              ),
            );
          },
        ),
      ),
    ],
  );
}
}