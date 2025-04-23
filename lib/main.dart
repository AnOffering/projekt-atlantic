import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/splash_screen.dart';
import 'screens/concert_list_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set preferred orientations
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Color(0xFF294734), // Hunter green
    systemNavigationBarIconBrightness: Brightness.light,
  ));
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Projekt Atlantic',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF1E2D23), // Hunter green background
        textTheme: GoogleFonts.ralewayTextTheme(ThemeData.dark().textTheme).apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF294734), // Deeper hunter green
            foregroundColor: const Color(0xFFDAB85A), // Muted gold text
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        // Add other mystical gothic theme elements
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xFF1E2D23), // Hunter green
          elevation: 0,
          iconTheme: IconThemeData(
            color: const Color(0xFFD4AF37), // Gold icons
          ),
        ),
        colorScheme: ColorScheme.dark(
          primary: const Color(0xFFDAB85A), // Muted gold as primary
          secondary: const Color(0xFF557053), // Medium hunter green as secondary
          tertiary: Colors.black87, // Hunter green background
          surface: const Color(0xFF294734), // Deeper hunter green surface
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/concerts': (context) => ConcertListScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}