import 'package:flutter/material.dart';
import 'package:myapp/screens/faq_screen.dart';
import 'package:myapp/screens/settings_screen.dart';
import 'package:myapp/screens/sos_screen.dart';
import 'package:myapp/text.dart';
import 'package:myapp/widgets/bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1;
  int? _hoveredIndex;

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;

    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const FAQScreen()),
        );
        break;
      case 1:
        // Do nothing, already on the home screen
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SettingsScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final appTexts = AppTexts.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 8.0,
        shadowColor: Colors.black.withAlpha(128),
        automaticallyImplyLeading: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/Aura_logo_home.png',
              height: 70,
            ),
            const SizedBox(width: 8),
            Text(
              appTexts.auraCare,
              style: const TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/info');
            },
            icon: Image.asset('assets/images/info_icon.png', height: 30),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 0.0,
                        ),
                        child: GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: constraints.maxWidth > 600 ? 3 : 2,
                          crossAxisSpacing: 15.0,
                          mainAxisSpacing: 15.0,
                          childAspectRatio: constraints.maxWidth > 600
                              ? 1
                              : 1.1,
                          children: List.generate(6, (index) {
                            final items = [
                              {
                                'image': 'assets/images/Reminder.png',
                                'label': appTexts.reminder,
                                'route': null,
                                'color': Colors.blue,
                              },
                              {
                                'image': 'assets/images/AI_Chat.png',
                                'label': appTexts.aiChat,
                                'route': null,
                                'color': Colors.purple,
                              },
                              {
                                'image': 'assets/images/Health.png',
                                'label': appTexts.healthCare,
                                'route': null,
                                'color': Colors.green,
                              },
                              {
                                'image': 'assets/images/Music.png',
                                'label': appTexts.music,
                                'route': null,
                                'color': Colors.orange,
                              },
                              {
                                'image': 'assets/images/Game.png',
                                'label': appTexts.game,
                                'route': null,
                                'color': Colors.red,
                              },
                              {
                                'image': 'assets/images/SOS.png',
                                'label': 'Emergency',
                                'route': '/sos',
                                'color': Colors.red,
                              },
                            ];
                            return _buildGridItem(
                              context,
                              items[index]['image']! as String,
                              items[index]['label']! as String,
                              index,
                              items[index]['color']! as Color,
                              route: items[index]['route'] as String?,
                              constraints: constraints,
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  Widget _buildGridItem(
    BuildContext context,
    String imagePath,
    String label,
    int index,
    Color color, {
    String? route,
    required BoxConstraints constraints,
  }) {
    final isTablet = constraints.maxWidth > 600;
    final imageHeight = isTablet ? 120.0 : 90.0;
    final fontSize = isTablet ? 18.0 : 15.0;

    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredIndex = index),
      onExit: (_) => setState(() => _hoveredIndex = null),
      child: AnimatedScale(
        scale: _hoveredIndex == index ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: InkWell(
          onTap: () {
            if (route == '/sos') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SOSScreen()),
              );
            } else if (route != null) {
              Navigator.pushNamed(context, route);
            }
          },
          borderRadius: BorderRadius.circular(20.0),
          child: Card(
            elevation: 8.0,
            shadowColor: Theme.of(context).shadowColor.withAlpha(77),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            color: Theme.of(context).cardColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  imagePath,
                  height: imageHeight,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 5.0),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
