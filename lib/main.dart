import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:portfolio/constants/env.dart';
import 'package:portfolio/constants/theme.dart';
import 'package:portfolio/router.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'helpers/scroll_overseer.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  await Supabase.initialize(
    url: dotenv.env[SupabaseEnv.supabaseUrl] ?? '',
    anonKey: dotenv.env[SupabaseEnv.supabaseAnonKey] ?? '',
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ScrollOverseer()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: lightTheme,
      // darkTheme: darkTheme,
      debugShowCheckedModeBanner: false,
      builder: (context, child) => ResponsiveWrapper.builder(
        child,
        maxWidth: 1440,
        minWidth: 1200,
        background: Container(color: Theme.of(context).colorScheme.tertiary,),
        breakpoints: [
          ResponsiveBreakpoint.resize(480, name: MOBILE),
          ResponsiveBreakpoint.autoScale(800, name: TABLET),
          ResponsiveBreakpoint.resize(1200, name: DESKTOP),
        ],
      ),
      routerConfig: router,
    );
  }
}