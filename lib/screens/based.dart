import 'package:flutter/material.dart';
import 'package:fooder/client.dart';
import 'package:fooder/components/app_bar.dart';
import 'package:fooder/components/navigation_bar.dart';
import 'package:fooder/screens/login.dart';
import 'package:fooder/screens/main.dart';

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
  void _logout() async {
    await widget.apiClient.logout();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(apiClient: widget.apiClient),
      ),
    );
  }

  void backToDiary() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainScreen(apiClient: widget.apiClient),
      ),
    );
  }

  FAppBar appBar() {
    return FAppBar(
      actions: [
        IconButton(
          icon: Icon(
            Icons.logout,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          onPressed: _logout,
        ),
      ],
    );
  }

  FNavBar navBar() {
    return FNavBar(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(
                Icons.menu_book,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              onPressed: backToDiary,
            ),
            IconButton(
              icon: Icon(
                Icons.dinner_dining,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                Icons.lunch_dining,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                Icons.person,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onError,
              ),
        ),
        backgroundColor: Theme.of(context).colorScheme.error.withOpacity(0.8),
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
                color: Theme.of(context).colorScheme.onPrimary,
              ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.8),
      ),
    );
  }
}
