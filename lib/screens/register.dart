import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fooder/screens/based.dart';
import 'package:fooder/components/text.dart';
import 'package:fooder/components/button.dart';

class RegisterScreen extends BasedScreen {
  const RegisterScreen({super.key, required super.apiClient});

  @override
  State<RegisterScreen> createState() => _RegisterScreen();
}

class _RegisterScreen extends BasedState<RegisterScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    super.dispose();
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
  }

  void popMeDaddy() {
    Navigator.pop(context);
  }

  // login client when button pressed
  Future<void> _register() async {
    if (passwordController.text != passwordConfirmController.text) {
      showError("Passwords don't match");
      return;
    }

    try {
      await widget.apiClient.register(
        usernameController.text,
        passwordController.text,
      );
      showText("Created account. You can now log in.");
      popMeDaddy();
    } on Exception catch (e) {
      showError(e.toString());
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
                  Icons.group_add,
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
                  autofillHints: const [AutofillHints.password],
                  obscureText: true,
                ),
                FTextInput(
                  labelText: 'Confirm password',
                  controller: passwordConfirmController,
                  autofillHints: const [AutofillHints.password],
                  onFieldSubmitted: (_) => _register(),
                  obscureText: true,
                ),
                FButton(
                  labelText: 'Register account',
                  onPressed: _register,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
