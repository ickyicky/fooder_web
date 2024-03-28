import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fooder/screens/based.dart';
import 'package:fooder/screens/main.dart';
import 'package:fooder/screens/register.dart';
import 'package:fooder/components/text.dart';
import 'package:fooder/components/button.dart';

class LoginScreen extends BasedScreen {
  const LoginScreen({super.key, required super.apiClient});

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends BasedState<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
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
    await widget.apiClient.loadToken();

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
    var theme = Theme.of(context);
    var colorScheme = theme.colorScheme;

    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          padding: const EdgeInsets.all(10),
          child: AutofillGroup(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.lock,
                  size: 100,
                  color: colorScheme.primary,
                ),
                FTextInput(
                  labelText: 'Username',
                  controller: usernameController,
                  autofillHints: const [AutofillHints.username],
                  autofocus: true,
                ),
                FTextInput(
                  labelText: 'Password',
                  controller: passwordController,
                  onFieldSubmitted: (_) => _login(),
                  autofillHints: const [AutofillHints.password],
                  obscureText: true,
                ),
                FButton(
                  labelText: 'Sign In',
                  onPressed: _login,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
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
