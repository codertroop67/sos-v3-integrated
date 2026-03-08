import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    final logicalIndex = selectedIndex;

    final items = <Widget>[
      Icon(Icons.help_outline,
          size: 30, color: logicalIndex == 0 ? Colors.amber : Colors.white),
      Icon(Icons.home,
          size: 30, color: logicalIndex == 1 ? Colors.amber : Colors.white),
      Icon(Icons.settings,
          size: 30, color: logicalIndex == 2 ? Colors.amber : Colors.white),
    ];

    // The visual index for the CurvedNavigationBar must be valid (0, 1, or 2).
    // If nothing is logically selected (logicalIndex = -1), 
    // we'll place the curve in the middle as a neutral default to prevent a crash.
    final visualIndex = (logicalIndex >= 0 && logicalIndex < items.length) ? logicalIndex : 1;

    return CurvedNavigationBar(
      index: visualIndex,
      height: 60.0,
      items: items,
      color: Theme.of(context).bottomNavigationBarTheme.backgroundColor!,
      buttonBackgroundColor:
          Theme.of(context).bottomNavigationBarTheme.backgroundColor!,
      backgroundColor: Colors.transparent,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 600),
      onTap: onItemTapped,
      letIndexChange: (index) => true,
    );
  }
}
