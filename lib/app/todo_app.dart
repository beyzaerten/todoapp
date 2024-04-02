import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/config/routes/routes_provider.dart';
import 'package:todoapp/config/theme/app_theme.dart';
import 'package:todoapp/screens/home_screen.dart';

class TodoApp extends ConsumerWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routeConfig = ref.watch(routesProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: routeConfig,
    );
  }
}
