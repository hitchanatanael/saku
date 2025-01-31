import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:saku/routes/app_routes.dart';

void main() {
  try {
    runApp(const MyApp());
  } catch (e) {
    // print('Error in main : $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: AppRoutes.routes,
    );
  }
}
