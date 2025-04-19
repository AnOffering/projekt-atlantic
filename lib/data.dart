import 'package:flutter/material.dart';

class Concert {
  final String venue;
  final String city;
  final String date;
  final Color color;

  Concert({
    required this.venue,
    required this.city,
    required this.date,
    required this.color,
  });
}

// The Concert class now accepts the dark green and gold colors
// The concert list has been moved to concert_list_screen.dart for simplicity