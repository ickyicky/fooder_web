import 'package:flutter/material.dart';
import 'package:fooder_web/models/entry.dart';
import 'dart:core';


class EntryWidget extends StatelessWidget {
  final Entry entry;

  const EntryWidget({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Text(entry.name),
    );
  }
}
