import 'package:flutter/material.dart';

class FAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget> actions;

  const FAppBar({super.key, required this.actions});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: actions,
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
