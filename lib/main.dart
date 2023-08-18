import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:portfolio/constants/env.dart';
import 'package:portfolio/constants/metrics.dart';
import 'package:portfolio/constants/theme.dart';
import 'package:portfolio/router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  // await dotenv.load(fileName: '.env');
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: 'AIzaSyA6fR2TQn8OxSxlACKpWkGRqbQM0zD_Cek',
          appId: '1:298069639803:web:1ecd57dfa02acb7fc118de',
          messagingSenderId: '298069639803',
          projectId: 'portfolio-e6526'));
  /// Remove hash (#) icon from url
  setPathUrlStrategy();
  await Supabase.initialize(
    // url: dotenv.env[SupabaseEnv.supabaseUrl] ?? '',
    // anonKey: dotenv.env[SupabaseEnv.supabaseAnonKey] ?? '',
    url: 'https://feipbpcaupqasfwaosft.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZlaXBicGNhdXBxYXNmd2Fvc2Z0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODA5MjIyNjIsImV4cCI6MTk5NjQ5ODI2Mn0.WL_QryIUdfWvMr8vSZMvcBRmSO932RaZJ8MrO5j8z9k',
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      builder: (context, child) => ResponsiveWrapper.builder(
        child,
        background: Container(color: Theme.of(context).colorScheme.background),
        minWidth: MOBILE_MAX_WIDTH,
        maxWidth: 1400,
        breakpoints: [
          ResponsiveBreakpoint.autoScaleDown(MOBILE_MAX_WIDTH,
              name: MOBILE, scaleFactor: .5),
          ResponsiveBreakpoint.autoScaleDown(800,
              name: 'SMALL_TABLET', scaleFactor: .65),
          ResponsiveBreakpoint.autoScale(1000,
              name: 'BIG_TABLET', scaleFactor: .85),
          ResponsiveBreakpoint.resize(1200, name: DESKTOP),
        ],
      ),
      routerConfig: router,
    );
  }
}
