import 'package:flutter/material.dart';
import 'package:fooder_web/screens/login.dart';
import 'package:fooder_web/client.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
