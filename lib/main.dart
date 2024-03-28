import 'package:flutter/material.dart';
import 'package:fooder/screens/login.dart';
import 'package:fooder/client.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FOODER',
      theme: FlexThemeData.light(scheme: FlexScheme.brandBlue),
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.brandBlue),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: LoginScreen(
        apiClient: ApiClient(
          baseUrl: 'https://fooderapi.domandoman.xyz/api',
        ),
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}
