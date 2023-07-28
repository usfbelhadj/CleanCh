import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final String imagePath;
  final String title;
  const SquareTile({super.key, required this.imagePath, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey[200],
      ),
      child: Row(
        children: [
          Image.network(
            imagePath,
            height: 10,
          ),
          const SizedBox(width: 10),
          Text(title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}
