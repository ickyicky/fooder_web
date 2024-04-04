import 'package:flutter/material.dart';

class FDropdown<T> extends StatelessWidget {
  final String labelText;
  final List<DropdownMenuItem<T>> items;
  final Function(T?) onChanged;
  final T? value;
  final double padding;

  const FDropdown(
      {super.key,
      required this.labelText,
      this.padding = 8,
      required this.items,
      required this.onChanged,
      this.value});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var colorScheme = theme.colorScheme;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: padding, horizontal: padding),
      child: DropdownButtonFormField<T>(
        onChanged: onChanged,
        items: items,
        value: value,
        decoration: InputDecoration(
          labelText: labelText,
          floatingLabelStyle:
              theme.textTheme.bodyLarge!.copyWith(color: colorScheme.onSurface),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: colorScheme.primary),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: colorScheme.onPrimary),
          ),
        ),
      ),
    );
  }
}
