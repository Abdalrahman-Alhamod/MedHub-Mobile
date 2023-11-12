import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  const SquareTile({super.key, required this.onTap, required this.icon});
  final void Function() onTap;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          border: Border.all(color: Colors.white),
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Icon(
          icon,
          size: 50,
        ),
      ),
    );
  }
}
