import 'package:flutter/material.dart';

class FAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var colorScheme = theme.colorScheme;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      )
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56);
}
