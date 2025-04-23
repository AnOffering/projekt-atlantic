import 'package:flutter/material.dart';

class Concert {
  final String venue;
  final String city;
  final String date;
  final Color color;
  final String? description; // Added for Easter egg hints

  Concert({
    required this.venue,
    required this.city,
    required this.date,
    required this.color,
    this.description, // Optional field for hints
  });
}