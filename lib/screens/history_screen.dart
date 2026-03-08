import 'package:flutter/material.dart';
import 'package:myapp/screens/map_screen.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final List<Map<String, dynamic>> _events = [
    {
      'type': 'SOS activated',
      'date': '06 Mar 2026',
      'time': '04:20:42',
      'category': 'Custom',
      'icon': Icons.warning,
      'color': Colors.orange,
      'latitude': 37.422,
      'longitude': -122.084,
    },
    {
      'type': 'Dismissed',
      'date': '06 Mar 2026',
      'time': '04:19:33',
      'category': 'Custom',
      'icon': Icons.check_circle,
      'color': Colors.green,
      'latitude': 37.422,
      'longitude': -122.084,
    },
    {
      'type': 'Dismissed',
      'date': '06 Mar 2026',
      'time': '04:19:19',
      'category': 'Custom',
      'icon': Icons.check_circle,
      'color': Colors.green,
      'latitude': 37.422,
      'longitude': -122.084,
    },
    {
      'type': 'Alert sent',
      'date': '06 Mar 2026',
      'time': '04:18:27',
      'category': 'Custom',
      'icon': Icons.error,
      'color': Colors.red,
      'latitude': 37.422,
      'longitude': -122.084,
    },
    {
      'type': 'Dismissed',
      'date': '05 Mar 2026',
      'time': '23:28:32',
      'category': 'Elderly / Home',
      'icon': Icons.check_circle,
      'color': Colors.green,
      'latitude': 37.422,
      'longitude': -122.084,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'History',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Text(
                '${_events.length} events',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _events.length,
              itemBuilder: (context, index) {
                final event = _events[index];
                return Card(
                  color: const Color(0xFF1E1E1E),
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: Icon(event['icon'], color: event['color']),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${event['date']}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          event['time'],
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event['type'],
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: event['color'],
                          ),
                        ),
                        const Text(
                          'category',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.location_pin, color: Colors.green),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MapScreen(
                              latitude: event['latitude'],
                              longitude: event['longitude'],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _events.clear();
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2C2C2C),
                foregroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                'Clear History',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
