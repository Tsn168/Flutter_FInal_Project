import 'package:flutter/material.dart';
// Make sure to import your CustomButton
import '../widgets/custom_button.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CustomButtonDemo(),
  ));
}

class CustomButtonDemo extends StatelessWidget {
  const CustomButtonDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CustomButton Demo'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // 1. TEXT BUTTONS - SOLID COLORS
            _buildSection('1. Text Buttons (Solid Colors)'),
            
            CustomButton.text(
              text: 'Find Recipes',
              onPressed: () => _showMessage(context, 'Finding recipes...'),
              backgroundColor: Colors.green,
              fullWidth: true,
              borderRadius: 12,
            ),
            
            const SizedBox(height: 12),
            
            CustomButton.text(
              text: 'Save Recipe',
              onPressed: () => _showMessage(context, 'Recipe saved!'),
              backgroundColor: Colors.blue,
              width: 200,
              borderRadius: 20, // Pill shape
            ),
            
            const SizedBox(height: 12),
            
            CustomButton.text(
              text: 'Square Button',
              onPressed: () => _showMessage(context, 'Square button pressed'),
              backgroundColor: Colors.orange,
              borderRadius: 0, // Square corners
            ),
            
            const SizedBox(height: 12),
            
            CustomButton.text(
              text: 'Disabled',
              onPressed: () {}, // Disabled: pass empty function to match VoidCallback
              backgroundColor: Colors.grey[300],
              textColor: Colors.grey[600] ?? Colors.grey,
              fullWidth: true,
            ),

            const SizedBox(height: 30),

            // 2. TEXT BUTTONS - GRADIENTS
            _buildSection('2. Text Buttons (Gradients)'),
            
            CustomButton.text(
              text: 'Premium Recipes',
              onPressed: () => _showMessage(context, 'Premium access'),
              gradientColors: [Colors.purple, Colors.pink],
              fullWidth: true,
              borderRadius: 20,
            ),
            
            const SizedBox(height: 12),
            
            CustomButton.text(
              text: 'Special Offer',
              onPressed: () => _showMessage(context, 'Special offer!'),
              gradientColors: [Colors.orange, Colors.red],
              width: 250,
            ),
            
            const SizedBox(height: 12),
            
            CustomButton.text(
              text: 'Square Gradient',
              onPressed: () => _showMessage(context, 'Square gradient'),
              gradientColors: [Colors.blue, Colors.green],
              borderRadius: 0, // Square with gradient
            ),
            
            const SizedBox(height: 12),
            
            CustomButton.text(
              text: 'Multi-Color Gradient',
              onPressed: () => _showMessage(context, 'Colorful!'),
              gradientColors: [Colors.red, Colors.orange, Colors.yellow],
              fullWidth: true,
            ),

            const SizedBox(height: 30),

            // 3. ICON + TEXT BUTTONS - SOLID COLORS
            _buildSection('3. Icon + Text Buttons (Solid Colors)'),
            
            CustomButton.iconText(
              text: 'Search Recipes',
              icon: Icons.search,
              onPressed: () => _showMessage(context, 'Searching...'),
              backgroundColor: Colors.deepPurple,
              fullWidth: true,
            ),
            
            const SizedBox(height: 12),
            
            CustomButton.iconText(
              text: 'Add to Favorites',
              icon: Icons.favorite_border,
              onPressed: () => _showMessage(context, 'Added to favorites'),
              backgroundColor: Colors.red,
              iconLeft: false, // Icon on right
            ),
            
            const SizedBox(height: 12),
            
            CustomButton.iconText(
              text: 'Save & Close',
              icon: Icons.save,
              onPressed: () => _showMessage(context, 'Saved and closed'),
              backgroundColor: Colors.teal,
              borderRadius: 0, // Square
            ),
            
            const SizedBox(height: 12),
            
            CustomButton.iconText(
              text: 'Small Icon Button',
              icon: Icons.download,
              onPressed: () => _showMessage(context, 'Downloading...'),
              backgroundColor: Colors.blueGrey,
              width: 180,
              iconSize: 16,
              spacing: 6,
            ),

            const SizedBox(height: 30),

            // 4. ICON + TEXT BUTTONS - GRADIENTS
            _buildSection('4. Icon + Text Buttons (Gradients)'),
            
            CustomButton.iconText(
              text: 'Share Recipe',
              icon: Icons.share,
              onPressed: () => _showMessage(context, 'Sharing recipe...'),
              gradientColors: [Colors.blue, Colors.purple],
              fullWidth: true,
              borderRadius: 16,
            ),
            
            const SizedBox(height: 12),
            
            CustomButton.iconText(
              text: 'Rate App',
              icon: Icons.star,
              onPressed: () => _showMessage(context, 'Rating the app'),
              gradientColors: [Colors.orange, Colors.yellow],
              textColor: Colors.black, // Dark text for light gradient
              iconColor: Colors.black,
              width: 200,
            ),
            
            const SizedBox(height: 12),
            
            CustomButton.iconText(
              text: 'Contact Support',
              icon: Icons.support_agent,
              onPressed: () => _showMessage(context, 'Contacting support'),
              gradientColors: [Colors.green, Colors.teal],
              iconLeft: false,
              borderRadius: 8,
            ),
            
            const SizedBox(height: 12),
            
            CustomButton.iconText(
              text: 'Square Gradient Icon',
              icon: Icons.settings,
              onPressed: () => _showMessage(context, 'Settings'),
              gradientColors: [Colors.deepPurple, Colors.pink],
              borderRadius: 0, // Square gradient with icon
            ),

            const SizedBox(height: 30),

            // 5. ICON ONLY BUTTONS
            _buildSection('5. Icon Only Buttons'),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Back button (square)
                CustomButton.iconOnly(
                  icon: Icons.arrow_back,
                  onPressed: () => _showMessage(context, 'Going back'),
                  backgroundColor: Colors.grey[200]!,
                  iconColor: Colors.black,
                  borderRadius: 0,
                ),
                
                // Settings (rounded square)
                CustomButton.iconOnly(
                  icon: Icons.settings,
                  onPressed: () => _showMessage(context, 'Settings'),
                  backgroundColor: Colors.blue,
                  borderRadius: 8,
                ),
                
                // Favorite (circular)
                CustomButton.iconOnly(
                  icon: Icons.favorite,
                  onPressed: () => _showMessage(context, 'Liked!'),
                  backgroundColor: Colors.red,
                  circular: true, // Perfect circle
                ),
                
                // Add (small circular)
                CustomButton.iconOnly(
                  icon: Icons.add,
                  onPressed: () => _showMessage(context, 'Add item'),
                  backgroundColor: Colors.green,
                  size: 50,
                  borderRadius: 25, // Half size = circle
                ),
              ],
            ),

            const SizedBox(height: 30),

            // 6. RECIPE APP SPECIFIC EXAMPLES
            _buildSection('6. Recipe App Examples'),
            
            // Ingredient tags
            const Text(
              'Ingredient Tags:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                CustomButton.text(
                  text: 'Bread',
                  onPressed: () => _showMessage(context, 'Bread selected'),
                  backgroundColor: Colors.brown[300]!,
                  borderRadius: 6,
                  height: 35,
                  width: 80,
                ),
                CustomButton.text(
                  text: 'Cheese',
                  onPressed: () => _showMessage(context, 'Cheese selected'),
                  backgroundColor: Colors.yellow[300]!,
                  borderRadius: 6,
                  height: 35,
                  width: 90,
                ),
                CustomButton.text(
                  text: 'Eggs',
                  onPressed: () => _showMessage(context, 'Eggs selected'),
                  backgroundColor: Colors.orange[200]!,
                  borderRadius: 6,
                  height: 35,
                  width: 70,
                ),
                CustomButton.text(
                  text: 'Tomato',
                  onPressed: () => _showMessage(context, 'Tomato selected'),
                  backgroundColor: Colors.red[200]!,
                  borderRadius: 6,
                  height: 35,
                  width: 90,
                ),
                CustomButton.text(
                  text: 'Chicken',
                  onPressed: () => _showMessage(context, 'Chicken selected'),
                  backgroundColor: Colors.brown[200]!,
                  borderRadius: 6,
                  height: 35,
                  width: 90,
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Recipe cards
            const Text(
              'Recipe Cards:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            CustomButton.iconText(
              text: 'Grilled Cheese Sandwich',
              icon: Icons.restaurant,
              onPressed: () => _showMessage(context, 'Opening Grilled Cheese recipe'),
              backgroundColor: Colors.orange[50]!,
              textColor: Colors.orange[900]!,
              iconColor: Colors.orange[800]!,
              fullWidth: true,
              borderRadius: 16,
              elevation: 1,
            ),
            
            const SizedBox(height: 12),
            
            CustomButton.iconText(
              text: 'Vegetable Omelette',
              icon: Icons.breakfast_dining,
              onPressed: () => _showMessage(context, 'Opening Omelette recipe'),
              gradientColors: [Colors.green[300]!, Colors.green[600]!],
              fullWidth: true,
              borderRadius: 16,
            ),
            
            const SizedBox(height: 12),
            
            CustomButton.iconText(
              text: 'Chicken Salad',
              icon: Icons.emoji_food_beverage,
              onPressed: () => _showMessage(context, 'Opening Chicken Salad recipe'),
              backgroundColor: Colors.lightGreen[50]!,
              textColor: Colors.green[900]!,
              iconColor: Colors.green[800]!,
              fullWidth: true,
              borderRadius: 16,
            ),

            const SizedBox(height: 30),

            // 7. ACTION BUTTONS
            _buildSection('7. Action Buttons'),
            
            // Cancel/Save pair
            Row(
              children: [
                Expanded(
                  child: CustomButton.text(
                    text: 'Cancel',
                    onPressed: () => _showMessage(context, 'Cancelled'),
                    backgroundColor: Colors.grey,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomButton.text(
                    text: 'Save',
                    onPressed: () => _showMessage(context, 'Saved'),
                    backgroundColor: Colors.green,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),
            
            // Main action button
            CustomButton.iconText(
              text: 'Find Matching Recipes',
              icon: Icons.search,
              onPressed: () => _showMessage(context, 'Finding matching recipes...'),
              gradientColors: [Colors.green, Colors.teal],
              fullWidth: true,
              borderRadius: 12,
            ),

            const SizedBox(height: 12),
            
            // Clear selection
            CustomButton.iconText(
              text: 'Clear All Ingredients',
              icon: Icons.clear_all,
              onPressed: () => _showMessage(context, 'Cleared all ingredients'),
              backgroundColor: Colors.red[100]!,
              textColor: Colors.red[900]!,
              iconColor: Colors.red[800]!,
              fullWidth: true,
            ),

            const SizedBox(height: 30),

            // 8. SIZING EXAMPLES
            _buildSection('8. Different Sizes'),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton.text(
                  text: 'XS',
                  onPressed: () => _showMessage(context, 'Extra small'),
                  backgroundColor: Colors.blue,
                  width: 60,
                  height: 30,
                  borderRadius: 6,
                ),
                CustomButton.text(
                  text: 'S',
                  onPressed: () => _showMessage(context, 'Small'),
                  backgroundColor: Colors.green,
                  width: 80,
                  height: 40,
                ),
                CustomButton.text(
                  text: 'M',
                  onPressed: () => _showMessage(context, 'Medium'),
                  backgroundColor: Colors.orange,
                  width: 120,
                  height: 50,
                ),
                CustomButton.text(
                  text: 'L',
                  onPressed: () => _showMessage(context, 'Large'),
                  backgroundColor: Colors.purple,
                  width: 150,
                  height: 60,
                ),
              ],
            ),

            const SizedBox(height: 40),

            // USAGE GUIDE
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue[100]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '📘 How to Use CustomButton:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  
                  _buildCodeExample(
                    '// Text button with solid color\n'
                    'CustomButton.text(\n'
                    '  text: "Find Recipes",\n'
                    '  onPressed: () {},\n'
                    '  backgroundColor: Colors.green,\n'
                    '  fullWidth: true,\n'
                    ')',
                  ),
                  
                  _buildCodeExample(
                    '// Text button with gradient\n'
                    'CustomButton.text(\n'
                    '  text: "Premium",\n'
                    '  onPressed: () {},\n'
                    '  gradientColors: [Colors.purple, Colors.pink],\n'
                    '  borderRadius: 20,\n'
                    ')',
                  ),
                  
                  _buildCodeExample(
                    '// Icon + Text button\n'
                    'CustomButton.iconText(\n'
                    '  text: "Search",\n'
                    '  icon: Icons.search,\n'
                    '  onPressed: () {},\n'
                    '  backgroundColor: Colors.blue,\n'
                    '  iconLeft: false,\n'
                    ')',
                  ),
                  
                  _buildCodeExample(
                    '// Icon only button (back button)\n'
                    'CustomButton.iconOnly(\n'
                    '  icon: Icons.arrow_back,\n'
                    '  onPressed: () => Navigator.pop(context),\n'
                    '  backgroundColor: Colors.transparent,\n'
                    '  iconColor: Colors.black,\n'
                    '  borderRadius: 0,\n'
                    ')',
                  ),
                  
                  const SizedBox(height: 12),
                  const Text(
                    '🎨 Tip: Use borderRadius: 0 for square, 20+ for pill shapes',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }

  Widget _buildCodeExample(String code) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Text(
        code,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 12,
          color: Colors.blue[900],
        ),
      ),
    );
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(milliseconds: 800),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}