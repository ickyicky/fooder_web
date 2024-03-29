import 'package:flutter/material.dart';

class FAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget> actions;

  const FAppBar({super.key, required this.actions});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var colorScheme = theme.colorScheme;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: actions,
      )
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56);
}
