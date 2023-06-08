import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/screens/projects/ralali_connect.dart';
import 'package:portfolio/screens/root.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) => Root(),
      routes: <RouteBase>[
        GoRoute(
          path: 'projects/ralali-connect',
          builder: (BuildContext context, GoRouterState state) {
            return const RalaliConnectProject();
          },
        ),
      ],
    ),
  ],
);