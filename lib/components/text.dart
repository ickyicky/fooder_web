import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FTextInput extends StatelessWidget {
  final String labelText;
  final double padding;
  final TextEditingController controller;
  final List<String>? autofillHints;
  final bool autofocus;
  final bool obscureText;
  final Function(String)? onFieldSubmitted;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;

  const FTextInput(
      {super.key,
      required this.labelText,
      this.padding = 8,
      required this.controller,
      this.autofillHints,
      this.autofocus = false,
      this.onFieldSubmitted,
      this.obscureText = false,
      this.keyboardType,
      this.inputFormatters,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var colorScheme = theme.colorScheme;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: padding, horizontal: padding),
      child: TextFormField(
        obscureText: obscureText,
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
        controller: controller,
        autofillHints: autofillHints,
        autofocus: autofocus,
        onFieldSubmitted: onFieldSubmitted,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        onChanged: onChanged,
      ),
    );
  }
}
