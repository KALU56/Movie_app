import 'package:flutter/material.dart';
import '../core/movie_colors.dart';

class CategoryButton extends StatefulWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  const CategoryButton({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  State<CategoryButton> createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<CategoryButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: widget.isSelected ? MovieColors.accent : Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: widget.isSelected
                ? [
                    BoxShadow(
                      color: MovieColors.accent.withOpacity(0.4),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
            border: Border.all(color: MovieColors.accent),
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              color: widget.isSelected ? Colors.white : MovieColors.accent,
              fontWeight: widget.isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
