import 'package:flutter/material.dart';
import 'package:myapp/text.dart';

class GameTheme {
  final String name;
  final IconData icon;
  final List<String> items;

  GameTheme({required this.name, required this.icon, required this.items});
}

List<GameTheme> getGameThemes(BuildContext context) {
  final appTexts = AppTexts.of(context);
  return [
    GameTheme(
      name: appTexts.fruits,
      icon: Icons.apple,
      items: ['🍎', '🍌', '🍇', '🍉', '🍓', '🍒', '🍑', '🍍'],
    ),
    GameTheme(
      name: appTexts.animals,
      icon: Icons.pets,
      items: ['🐶', '🐱', '🐭', '🐹', '🐰', '🦊', '🐻', '🐼'],
    ),
    GameTheme(
      name: appTexts.vehicles,
      icon: Icons.directions_car,
      items: ['🚗', '🚕', '🚙', '🚌', '🚎', '🏎️', '🚓', '🚑'],
    ),
    GameTheme(
      name: appTexts.shapes,
      icon: Icons.category,
      items: ['❤️', '⭐️', '🔵', '🔺', '🟢', '🔶', '🔷', '🔳'],
    ),
    GameTheme(
      name: appTexts.colors,
      icon: Icons.color_lens,
      items: ['🔴', '🟠', '🟡', '🟢', '🔵', '🟣', '⚫️', '⚪️'],
    ),
    GameTheme(
      name: appTexts.numbers,
      icon: Icons.format_list_numbered,
      items: ['1', '2', '3', '4', '5', '6', '7', '8'],
    ),
  ];
}
