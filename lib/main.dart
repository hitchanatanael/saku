import 'package:flutter/material.dart';
import 'package:saku/routes/app_routes.dart';
// import 'package:logger/logger.dart';

// final logger = Logger();

void main() {
  try {
    runApp(const MyApp());
  } catch (e) {
    print('Error in main : $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: AppRoutes.routes,
    );
  }
}
