import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fooder/screens/based.dart';
import 'package:fooder/screens/main.dart';
import 'package:fooder/screens/register.dart';

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

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, textAlign: TextAlign.center),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }

  void showText(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text, textAlign: TextAlign.center),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  void popMeDaddy() {
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
      popMeDaddy();
    } on Exception catch (e) {
      showError(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    SystemChannels.textInput
        .invokeMethod('TextInput.setClientFeatures', <String, dynamic>{
      'setAuthenticationConfiguration': true,
      'setAutofillHints': <String>[
        AutofillHints.username,
        AutofillHints.password,
      ],
    });
    _asyncInitState().then((value) => null);
  }

  Future<void> _asyncInitState() async {
    if (widget.apiClient.refreshToken == null) {
      return;
    }

    try {
      await widget.apiClient.refresh();
      showText("Welcome back!");
      popMeDaddy();
    } on Exception catch (_) {
      showError("Session is not longer valid, please log in again");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("🅵🅾🅾🅳🅴🆁", style: logoStyle(context)),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          padding: const EdgeInsets.all(10),
          child: AutofillGroup(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Username',
                  ),
                  controller: usernameController,
                  autofillHints: const [AutofillHints.username],
                  autofocus: true,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                  controller: passwordController,
                  onFieldSubmitted: (_) => _login(),
                  autofillHints: const [AutofillHints.password],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: FilledButton(
                    onPressed: _login,
                    child: const Text('Login'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              RegisterScreen(apiClient: widget.apiClient),
                        ),
                      );
                    },
                    child: const Text('Don\'t have an account? Register here!'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
