import 'package:flutter/cupertino.dart';
import 'package:saku/features/auth/login_page.dart';
import 'package:saku/features/home/home_page.dart';
import 'package:saku/features/tagihan/tagihan_page.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    '/': (context) => const HomePage(),
    '/tagihan': (context) => const TagihanPage(),
    '/login': (context) => const LoginPage(),
  };
}
