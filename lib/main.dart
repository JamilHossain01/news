// Packages
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:news71_app/providers/bookmark_provider.dart';
import 'package:provider/provider.dart';

// Screens
import 'package:news71_app/inner_screen/blog_details.dart';
import 'screens/home_screen.dart';

// Consts
import 'consts/theme_data.dart';

// Providers
import 'providers/theme_provider.dart';
import 'providers/news_provider.dart';

// Firebase options
import 'firebase_options.dart'; // Import Firebase options

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Initialize Firebase
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Need it to access the theme Provider
  final ThemeProvider _themeChangeProvider = ThemeProvider();

  @override
  void initState() {
    super.initState();
    _getCurrentAppTheme();
  }

  // Fetch the current theme
  void _getCurrentAppTheme() async {
    _themeChangeProvider.setDarkTheme =
    await _themeChangeProvider.darkThemePreferences.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => _themeChangeProvider,
        ),
        ChangeNotifierProvider<NewsProvider>(
          create: (_) => NewsProvider(),
        ),
        ChangeNotifierProvider<BookMarkProvider>(create:(context) => BookMarkProvider(), )
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeChangeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Blog',
            theme: Styles.themeData(themeChangeProvider.getDarkTheme, context),
            home: const HomeScreen(),
            routes: {
              NewsDetailsScreen.routeName: (context) =>
              const NewsDetailsScreen(),
            },
          );
        },
      ),
    );
  }
}
