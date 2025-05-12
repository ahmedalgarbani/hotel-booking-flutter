import 'package:flutter/material.dart';

Widget reviewDetail({required String namerating, required int rating}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    padding: const EdgeInsets.all(6),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          namerating,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            5,
            (index) => Icon(
              index < rating ? Icons.star : Icons.star_border,
              size: 16,
              color: Colors.amber,
            ),
          ),
        ),
      ],
    ),
  );
}
