import 'package:flutter/material.dart';

// ============================================================================
// KANTINKU: MENU SCREEN (Week 8: Receiving Data & Returning Updates)
// Alta Global School | IT Grade 10 & 11 (SHS)
//
// WEEK 8 CONCEPTS DEMONSTRATED HERE:
// 1. Constructor Parameter: Receives `cartSaatIni` from HomeScreen.
// 2. initState(): Copies constructor data into local state `_localCart`.
// 3. setState(): Adds food items to local cart when 'Add' button is pressed.
// 4. Navigator.pop(context, _localCart): Returns updated cart list back to
//    HomeScreen when 'Complete Order' button is tapped.
//
// Look for '// [CHANGE HERE]' comments to customize your team's canteen menu!
// ============================================================================

class MenuScreen extends StatefulWidget {
  // [CHANGE HERE]: Receives current cart data from HomeScreen
  final List<Map<String, dynamic>> cartSaatIni;
  final String? userName;

  const MenuScreen({
    super.key,
    this.cartSaatIni = const [],
    this.userName,
  });

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  // Local temporary cart list on MenuScreen
  late List<Map<String, dynamic>> _localCart;

  // [CHANGE HERE]: Canteen menu catalog (customize name, price, emoji, description)
  final List<Map<String, dynamic>> kantinMenu = [
  {
    'name': 'Math Assignment',
    'deadline': '08:30, Tuesday',
    'emoji': '📝',
    'desc': 'Complete the math assignment',
    'isCompleted':false
  },
  {
    'name': 'English Essay',
    'deadline': '02:00, Due in 2 days',
    'emoji': '✏️',
    'desc': 'Finish the assigned work',
    'isCompleted':false
  },
];

 // ---------------------------------------------------------
  // LIFECYCLE 1: initState()
  // Receive the existing task list from HomeScreen.
  // Copy the tasks into _localCart for local editing.
  // ---------------------------------------------------------
  
  @override
void initState() {
  super.initState();

  // Copy tasks received from HomeScreen.
  _localCart = widget.cartSaatIni
      .map((task) => Map<String, dynamic>.from(task))
      .toList();

  // Load default tasks if the cart is empty.
  if (_localCart.isEmpty) {
    _localCart = [
      {
        'name': 'Math Assignment',
        'deadline': '08:30, Tuesday',
        'emoji': '📝',
        'desc': 'Complete the math assignment',
        'isCompleted': false,
      },
      {
        'name': 'English Essay',
        'deadline': 'Due in 2 days',
        'emoji': '✏️',
        'desc': 'Finish the assigned work',
        'isCompleted': false,
      },
    ];
  }

  // Ensure every task has a completion status.
  for (final task in _localCart) {
    task['isCompleted'] = task['isCompleted'] == true;
  }
}
  // ---------------------------------------------------------
  // LIFECYCLE 2: dispose()
  // Runs when the To-Do List screen is removed.
  // ---------------------------------------------------------
  @override
  void dispose() {
    // ignore: avoid_print
    print('=== To-Do List closed (dispose) ===');

    super.dispose();
  }
 
 // ---------------------------------------------------------
// ACTION: Toggle task completion using setState()
// ---------------------------------------------------------
void _toggleTask(int index, bool? value) {
  setState(() {
    _localCart[index]['isCompleted'] = value ?? false;
  });
}

@override
Widget build(BuildContext context) {
  const Color brandTeal = Color(0xFFF6DB56);

  return Scaffold(
    backgroundColor: const Color(0xFFFFFFFF),

    appBar: AppBar(
      title: Text(
        widget.userName != null
            ? 'To-Do List (${widget.userName})'
            : 'My To-Do List',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      backgroundColor: brandTeal,

      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          // Return the updated task list to HomeScreen.
          Navigator.pop(context, _localCart);
        },
      ),

      actions: [
        // Task count badge in AppBar.
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFFFD166),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.checklist,
                    size: 18,
                    color: Color(0xFF1A1A2E),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${_localCart.length}',
                    style: const TextStyle(
                      color: Color(0xFF1A1A2E),
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),

      
body: SafeArea(
  child: Column(
    children: [
      // Top helper banner
      Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        color: const Color(0xFFE8F4FD),
        child: const Row(
          children: [
            Icon(Icons.touch_app, size: 20, color: brandTeal),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'Check the tasks you have done',
                style: TextStyle(
                  fontSize: 12.5,
                  color: Color(0xFF0A5A61),
                ),
              ),
            ),
          ],
        ),
      ),

      // List of Menu Items
      Expanded(
        child: ListView.builder(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
          itemCount: _localCart.length,
          itemBuilder: (context, index) {
            final item = _localCart[index];

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: const BorderSide(
                  color: Color(0xFF8E9AAF),
                  width: 0.5,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    // Emoji box
                    Container(
                      width: 52,
                      height: 52,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAFAF7),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        item['emoji'] as String,
                        style: const TextStyle(fontSize: 28),
                      ),
                    ),
                    const SizedBox(width: 14),

                    // Task details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['name'] as String,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            item['desc'] as String,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF607D8B),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Deadline: ${item['deadline']}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0E7C86),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Checkbox
                    Checkbox(
                      value: item['isCompleted'] == true,
                      activeColor: brandTeal,
                      onChanged: (bool? value) {
                        _toggleTask(index, value);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ],
  ),
),
                         

      // ----------------------------------------------------------------------
      // FLOATING ACTION BUTTON: Save Tasks (Returns data to HomeScreen)
      // ----------------------------------------------------------------------
             floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pop(context, _localCart);
        },
        icon: const Icon(
          Icons.save,
          color: Colors.white,
        ),
        label: Text(
          'Save Tasks (${_localCart.length})',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: brandTeal,
      ),
    );
  }
}
