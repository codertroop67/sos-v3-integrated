import 'package:flutter/material.dart';

class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency'),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        titleTextStyle: Theme.of(context).appBarTheme.titleTextStyle,
        iconTheme: Theme.of(context).iconTheme,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final imageSize = constraints.maxWidth * 0.5;
          final headerFontSize = constraints.maxWidth > 600 ? 34.0 : 28.0;
          final bodyFontSize = constraints.maxWidth > 600 ? 22.0 : 18.0;

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/SOS.png',
                    width: imageSize,
                    height: imageSize,
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'Emergency!',
                    style: TextStyle(
                      fontSize: headerFontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Tap the button below to call for immediate assistance.',
                    style: TextStyle(
                      fontSize: bodyFontSize,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton.icon(
                    onPressed: () {
                      // In a real app, this would trigger a phone call.
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Emergency Call'),
                          content: const Text(
                            'This would normally initiate a call to emergency services.',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    },
                    icon: const Icon(Icons.call, size: 30),
                    label: const Text('CALL FOR HELP'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 20,
                      ),
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
