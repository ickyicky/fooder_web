import 'package:flutter/material.dart';
import 'package:fooder/client.dart';

TextStyle logoStyle(context) {
  return Theme.of(context).textTheme.labelLarge!.copyWith(
        color: Theme.of(context).colorScheme.secondary,
      );
}

abstract class BasedScreen extends StatefulWidget {
  final ApiClient apiClient;

  const BasedScreen({super.key, required this.apiClient});
}

abstract class BasedState<T extends BasedScreen> extends State<T> {
  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }

  void showText(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
