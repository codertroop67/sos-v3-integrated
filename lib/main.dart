import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:myapp/classes.dart';
import 'package:myapp/locale_provider.dart';
// import 'package:myapp/screens/emergency_screen.dart';
import 'package:myapp/screens/faq_screen.dart';
import 'package:myapp/screens/home_screen.dart';
import 'package:myapp/screens/info_screen.dart';
// import 'package:myapp/screens/memory_game/memory_game_screen.dart';
// import 'package:myapp/screens/reminder_screen.dart';
import 'package:myapp/screens/settings_screen.dart';
import 'package:myapp/screens/splash_screen.dart';
// import 'package:myapp/services/notification_service.dart';
import 'package:myapp/text.dart';
import 'package:myapp/theme_provider.dart';
import 'package:provider/provider.dart';

// final NotificationService notificationService = NotificationService();

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await notificationService.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LocaleProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // _configureSelectNotificationSubject();
  }

  // void _configureSelectNotificationSubject() {
  //   selectNotificationStream.stream.listen((String? payload) async {
  //     if (payload != null) {
  //       navigatorKey.currentState?.pushNamed(payload);
  //     }
  //   });
  // }

  @override
  void dispose() {
    // selectNotificationStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<LocaleProvider, ThemeProvider>(
      builder: (context, localeProvider, themeProvider, child) {
        return MaterialApp(
          locale: localeProvider.locale,
          supportedLocales: Language.allLocales,
          localizationsDelegates: const [
            AppTexts.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale?.languageCode &&
                  supportedLocale.countryCode == locale?.countryCode) {
                return supportedLocale;
              }
            }
            return supportedLocales.first;
          },
          navigatorKey: navigatorKey,
          title: 'AuraCare',
          themeMode: themeProvider.themeMode,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 121, 26, 139),
              brightness: Brightness.light,
            ),
            visualDensity: VisualDensity.adaptivePlatformDensity,
            scaffoldBackgroundColor: const Color(0xFFF3E5F5),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color.fromARGB(255, 121, 26, 139),
            ),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Color.fromARGB(255, 121, 26, 139),
            ),
            fontFamily: 'Roboto',
            textTheme: const TextTheme(
              bodyLarge: TextStyle(color: Colors.black),
              bodyMedium: TextStyle(color: Colors.black),
              titleMedium: TextStyle(color: Colors.black),
            ),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 121, 26, 139),
              brightness: Brightness.dark,
            ),
            visualDensity: VisualDensity.adaptivePlatformDensity,
            scaffoldBackgroundColor: Colors.grey[900],
            appBarTheme: AppBarTheme(backgroundColor: Colors.grey[800]),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: Colors.grey[800],
            ),
            fontFamily: 'Roboto',
            textTheme: const TextTheme(
              bodyLarge: TextStyle(color: Colors.white),
              bodyMedium: TextStyle(color: Colors.white),
              titleMedium: TextStyle(color: Colors.white),
            ),
          ),
          initialRoute: '/splash',
          routes: {
            '/splash': (context) => const SplashScreen(),
            '/': (context) => const HomeScreen(),
            '/home': (context) => const HomeScreen(),
            '/faq': (context) => const FAQScreen(),
            '/settings': (context) => const SettingsScreen(),
            // '/reminder': (context) => const ReminderScreen(),
            // '/memory_game': (context) => const MemoryGameScreen(),
            '/info': (context) => const InfoScreen(),
            // '/emergency': (context) => const EmergencyScreen(),
          },
        );
      },
    );
  }
}
