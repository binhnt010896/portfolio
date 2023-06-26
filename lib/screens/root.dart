import 'package:flutter/material.dart';
import 'package:firebase_analytics_web/firebase_analytics_web.dart';
import 'package:portfolio/screens/home/home_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HomeScreen();
  }
}
