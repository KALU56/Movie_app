import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final ValueChanged<String> onSearch;
  final VoidCallback onMenuPressed;
  final VoidCallback onClearSearch;

  const SearchBar({
    super.key,
    required this.onSearch,
    required this.onMenuPressed,
    required this.onClearSearch,
  });

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _controller = TextEditingController();
  bool _showClearButton = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Search icon
          const Icon(Icons.search, color: Colors.grey),
          const SizedBox(width: 10),

          // TextField for user input
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Search movies...',
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                setState(() {
                  _showClearButton = value.isNotEmpty;
                });
                widget.onSearch(value); // Trigger parent callback
              },
            ),
          ),

          // Conditional buttons: Clear or Menu
          _showClearButton
              ? IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    _controller.clear(); // Clear text field
                    setState(() => _showClearButton = false);
                    widget.onClearSearch(); // Callback to parent
                  },
                )
              : IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: widget.onMenuPressed, // Callback to parent
                ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose controller to avoid memory leaks
    super.dispose();
  }
}
