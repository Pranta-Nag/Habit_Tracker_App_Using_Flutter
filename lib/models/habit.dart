import 'package:flutter/material.dart';

class Habit {
  final String name;
  final String goal;
  final IconData icon;
  final String streak;

  Habit({
    required this.name,
    required this.goal,
    required this.icon,
    required this.streak,
  });
}