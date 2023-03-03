import 'package:beatiful_ui/home.dart';
import 'package:beatiful_ui/main.dart';
import 'package:beatiful_ui/profile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final configRouter = GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
            path: '/',
            builder: (context, state) => const RootPage(),
            routes: [
              GoRoute(
                path: 'profile',
                // builder: (context, state) => const ProfilePage(),
                pageBuilder: (context, state) => MaterialPage<void>(
                  key: state.pageKey,
                  child: const ProfilePage(),
                  fullscreenDialog: true,
                ),
              ),
              GoRoute(
                path: 'home',
                // builder: (context, state) => const HomePage(),
                pageBuilder: (context, state) => MaterialPage<void>(
                  key: state.pageKey,
                  child: const HomePage(),
                  fullscreenDialog: true,
                ),
              ),
            ]),
      ],
    );