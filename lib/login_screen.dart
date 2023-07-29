import 'package:flutter/material.dart';
import 'package:fooder_web/based.dart';


class LoginScreen extends BasedScreen {
  LoginScreen({super.key, required super.apiClient});

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

  // login client when button pressed
  void _login() async {
    widget.apiClient.login(
      usernameController.text,
      passwordController.text,
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("ANALUJ"),
      ),
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 600),
          padding: EdgeInsets.all(10),
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
                child: Text('Login'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
