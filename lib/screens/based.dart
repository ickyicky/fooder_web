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
