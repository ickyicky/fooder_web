import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fooder/screens/based.dart';


class RegisterScreen extends BasedScreen {
  const RegisterScreen({super.key, required super.apiClient});

  @override
  State<RegisterScreen> createState() => _RegisterScreen();
}


class _RegisterScreen extends State<RegisterScreen> {
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
    SystemChannels.textInput.invokeMethod('TextInput.setClientFeatures', <String, dynamic>{
      'setAuthenticationConfiguration': true,
      'setAutofillHints': <String>[
        AutofillHints.username,
        AutofillHints.password,
      ],
    });
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
      popMeDady();
    } on Exception catch (e) {
      showError(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("🅵🅾🅾🅳🅴🆁"),
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
                autofillHints: const [AutofillHints.username],
              ),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                controller: passwordController,
                autofillHints: const [AutofillHints.password],
              ),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirm password',
                ),
                controller: passwordConfirmController,
                onFieldSubmitted: (_) => _register()
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: FilledButton(
                  onPressed: _register,
                  child: const Text('Register'),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
