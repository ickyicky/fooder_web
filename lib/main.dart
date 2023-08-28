import 'package:flutter/material.dart';
import 'package:fooder/screens/login.dart';
import 'package:fooder/client.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FOODER',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueGrey,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
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
