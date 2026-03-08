import 'package:flutter/material.dart';
import 'package:myapp/text.dart';

class LevelCompleteDialog extends StatelessWidget {
  final int moves;
  final String time;
  final VoidCallback onReplay;

  const LevelCompleteDialog({
    super.key,
    required this.moves,
    required this.time,
    required this.onReplay,
  });

  @override
  Widget build(BuildContext context) {
    final appTexts = AppTexts.of(context);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context, appTexts),
    );
  }

  Widget contentBox(BuildContext context, AppTexts appTexts) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(
            left: 20,
            top: 65,
            right: 20,
            bottom: 20,
          ),
          margin: const EdgeInsets.only(top: 45),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: const Color(0xFFE6E6FA), // Light purple background
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFFC8A2C8), // Lilac border
              width: 4,
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                appTexts.youWin,
                style: const TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                  color: Color(0xFF4B0082), // Indigo
                ),
              ),
              const SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  return const Icon(
                    Icons.star,
                    color: Color(0xFFFFD700), // Gold
                    size: 40.0,
                  );
                }),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        appTexts.moves,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'Poppins',
                          color: Color(0xFF4B0082), // Indigo
                        ),
                      ),
                      Text(
                        '$moves',
                        style: const TextStyle(
                          fontSize: 36.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Oswald',
                          color: Color(0xFF4B0082), // Indigo
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        appTexts.time,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'Poppins',
                          color: Color(0xFF4B0082), // Indigo
                        ),
                      ),
                      Text(
                        time,
                        style: const TextStyle(
                          fontSize: 36.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Oswald',
                          color: Color(0xFF4B0082), // Indigo
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 25.0),
              FloatingActionButton(
                onPressed: onReplay,
                backgroundColor: const Color(0xFF9370DB), // MediumPurple
                child: const Icon(Icons.refresh, color: Colors.white),
              ),
            ],
          ),
        ),
        Positioned(
          left: 20,
          right: 20,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: const Color(0xFFFFD700), // Gold
              borderRadius: BorderRadius.circular(25.0),
              border: Border.all(color: Colors.white, width: 3),
            ),
            child: Text(
              appTexts.levelComplete,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Oswald',
                color: Color(0xFF4B0082), // Indigo
              ),
            ),
          ),
        ),
      ],
    );
  }
}
