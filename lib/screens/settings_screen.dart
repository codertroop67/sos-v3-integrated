import 'package:flutter/material.dart';
import 'package:myapp/classes.dart';
import 'package:myapp/locale_provider.dart';
import 'package:myapp/screens/faq_screen.dart';
import 'package:myapp/screens/home_screen.dart';
import 'package:myapp/text.dart';
import 'package:myapp/theme_provider.dart';
import 'package:myapp/widgets/bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int _selectedIndex = 2;
  Locale? _selectedLocale;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _selectedLocale ??= Provider.of<LocaleProvider>(context).locale;
  }

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
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
        break;
      case 2:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final appTexts = AppTexts.of(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

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
        title: Center(
          child: Text(
            appTexts.settings,
            style: const TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isTablet = constraints.maxWidth > 600;

          return ListView(
            padding: EdgeInsets.all(isTablet ? 24.0 : 16.0),
            children: [
              _buildSectionHeader(context, appTexts.selectMode, isTablet),
              _buildDarkModeTile(context, themeProvider, isTablet),
              const Divider(),
              _buildSectionHeader(context, appTexts.language, isTablet),
              _buildLanguageSelection(context, isTablet),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    String title,
    bool isTablet,
  ) {
    final fontSize = isTablet ? 22.0 : 18.0;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: fontSize,
        ),
      ),
    );
  }

  Widget _buildDarkModeTile(
    BuildContext context,
    ThemeProvider themeProvider,
    bool isTablet,
  ) {
    final appTexts = AppTexts.of(context);
    final fontSize = isTablet ? 18.0 : 16.0;
    final iconSize = isTablet ? 30.0 : 24.0;

    bool isDarkMode;
    if (themeProvider.themeMode == ThemeMode.system) {
      isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
    } else {
      isDarkMode = themeProvider.themeMode == ThemeMode.dark;
    }

    return SwitchListTile(
      title: Text(
        appTexts.darkMode,
        style: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(fontSize: fontSize),
      ),
      secondary: Icon(Icons.dark_mode, size: iconSize),
      value: isDarkMode,
      onChanged: (value) {
        themeProvider.toggleTheme(value);
      },
    );
  }

  Widget _buildLanguageSelection(BuildContext context, bool isTablet) {
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    final double flagSize = isTablet ? 40 : 30;
    final double fontSize = isTablet ? 18 : 16;

    return Column(
      children: Language.languageList().map((language) {
        return ListTile(
          onTap: () {
            if (language.locale != _selectedLocale) {
              setState(() {
                _selectedLocale = language.locale;
              });
              localeProvider.setLocale(language.locale);
            }
          },
          leading: Icon(
            _selectedLocale == language.locale
                ? Icons.radio_button_checked
                : Icons.radio_button_unchecked,
            color: Theme.of(context).colorScheme.primary,
          ),
          title: Row(
            children: [
              ClipOval(
                child: Image.asset(
                  language.flag,
                  width: flagSize,
                  height: flagSize,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                language.name,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontSize: fontSize),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
