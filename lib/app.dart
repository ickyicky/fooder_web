import 'package:flutter/material.dart';
import 'package:fooder_web/based.dart';
import 'package:fooder_web/login_screen.dart';
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
      home: MyHomePage(
        apiClient: ApiClient(
          baseUrl: 'https://fooderapi.domandoman.xyz/api',
        ),
        title: 'FOODER',
      ),
    );
  }
}

class MyHomePage extends BasedScreen {
  final String title;

  const MyHomePage({super.key, required super.apiClient, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // login client when button pressed
  void _login() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(apiClient: widget.apiClient),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
               FilledButton(
                onPressed: _login,
                child: const Text('Login'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
