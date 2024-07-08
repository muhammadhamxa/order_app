import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'features/orders/presentation/pages/home_page.dart';
import 'services/di.dart';

final getIt = GetIt.instance;

void main() {
  setupDependencyInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Product Order App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomePage(),
    );
  }
}
