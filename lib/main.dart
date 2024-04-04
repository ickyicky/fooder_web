import 'package:flutter/material.dart';
import 'package:fooder/screens/login.dart';
import 'package:fooder/client.dart';
import 'package:fooder/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FOODER',
      theme: MainTheme.light(),
      darkTheme: MainTheme.dark(),
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
