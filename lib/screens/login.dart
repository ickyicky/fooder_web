import 'package:flutter/material.dart';
import 'package:fooder_web/screens/based.dart';
import 'package:fooder_web/screens/main.dart';


class LoginScreen extends BasedScreen {
  const LoginScreen({super.key, required super.apiClient});

  @override
  State<LoginScreen> createState() => _LoginScreen();
}


class _LoginScreen extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void showError(String message)
  {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, textAlign: TextAlign.center),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }

  void showText(String text)
  {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text, textAlign: TextAlign.center),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  void popMeDady() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainScreen(apiClient: widget.apiClient),
      ),
    );
  }

  // login client when button pressed
  Future<void> _login() async {
    try {
      await widget.apiClient.login(
        usernameController.text,
        passwordController.text,
      );
      showText("Logged in");
      popMeDady();
    } on Exception catch (e) {
      showError(e.toString());
    }
  }

  @override
  void initState () {
    super.initState();
    _asyncInitState().then((value) => null);
  }

  Future<void> _asyncInitState() async {
    try {
      await widget.apiClient.refresh();
      showText("Welcome back!");
      popMeDady();
    } on Exception catch (_) {
      showError("Session is not longer valid, please log in again");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("FOODER"),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
               TextFormField(
                 decoration: const InputDecoration(
                   labelText: 'Username',
                 ),
                 controller: usernameController,
               ),
               TextFormField(
                 obscureText: true,
                 decoration: const InputDecoration(
                   labelText: 'Password',
                 ),
                 controller: passwordController,
               ),
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
