import 'package:flutter/material.dart';
import 'package:fresh_keeper/pages/home_page.dart';
import 'package:fresh_keeper/pages/splash_page.dart';
import 'package:fresh_keeper/pages/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://uuxakdtrpgehzibjrhiw.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InV1eGFrZHRycGdlaHppYmpyaGl3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTA1ODc2MTAsImV4cCI6MjAyNjE2MzYxMH0.FLyh-u6ZTz6d--iPY-RJi_q9pUCNCztMRNhwA5CizPg',
  );
  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FreshKeeper',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 7, 126, 217),
        ),
      ),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        // Splash page is needed to ensure that authentication and page loading works correctly
        '/': (_) => const SplashPage(),
        '/login': (_) => const LoginPage(),
        '/account': (_) => const HomePage(),
      },
    );
  }
}
