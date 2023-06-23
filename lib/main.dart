import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:portfolio/constants/env.dart';
import 'package:portfolio/constants/metrics.dart';
import 'package:portfolio/constants/theme.dart';
import 'package:portfolio/router.dart';
import 'package:portfolio/screens/root.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  // await dotenv.load(fileName: '.env');
  await Supabase.initialize(
    // url: dotenv.env[SupabaseEnv.supabaseUrl] ?? '',
    // anonKey: dotenv.env[SupabaseEnv.supabaseAnonKey] ?? '',
    url: 'https://feipbpcaupqasfwaosft.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZlaXBicGNhdXBxYXNmd2Fvc2Z0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODA5MjIyNjIsImV4cCI6MTk5NjQ5ODI2Mn0.WL_QryIUdfWvMr8vSZMvcBRmSO932RaZJ8MrO5j8z9k',
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
          ResponsiveBreakpoint.autoScaleDown(MOBILE_MAX_WIDTH, name: MOBILE, scaleFactor: .5),
          ResponsiveBreakpoint.autoScaleDown(800, name: 'SMALL_TABLET', scaleFactor: .65),
          ResponsiveBreakpoint.autoScale(1000, name: 'BIG_TABLET', scaleFactor: .85),
          ResponsiveBreakpoint.resize(1200, name: DESKTOP),
        ],
      ),
      routerConfig: router,
    );
  }
}