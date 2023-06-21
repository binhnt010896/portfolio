import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:portfolio/constants/env.dart';
import 'package:portfolio/constants/theme.dart';
import 'package:portfolio/router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  // await dotenv.load(fileName: '.env');
  // await Supabase.initialize(
  //   url: dotenv.env[SupabaseEnv.supabaseUrl] ?? '',
  //   anonKey: dotenv.env[SupabaseEnv.supabaseAnonKey] ?? '',
  // );
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
        minWidth: 800,
        maxWidth: 1400,
        breakpoints: [
          ResponsiveBreakpoint.autoScaleDown(800, name: 'SMALL_TABLET', scaleFactor: .65),
          ResponsiveBreakpoint.autoScale(1000, name: 'BIG_TABLET', scaleFactor: .85),
          ResponsiveBreakpoint.resize(1200, name: DESKTOP),
        ],
      ),
      routerConfig: router,
    );
  }
}