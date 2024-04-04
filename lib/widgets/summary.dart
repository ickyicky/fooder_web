import 'package:flutter/material.dart';
import 'package:fooder/models/diary.dart';
import 'package:fooder/widgets/macro.dart';
import 'package:fooder/client.dart';
import 'dart:core';

class SummaryHeader extends StatelessWidget {
  final Diary diary;

  const SummaryHeader({super.key, required this.diary});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            "Summary",
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}

class SummaryWidget extends StatelessWidget {
  static const maxWidth = 920.0;

  final Diary diary;
  final ApiClient apiClient;
  final Function() refreshParent;

  const SummaryWidget(
      {super.key,
      required this.diary,
      required this.apiClient,
      required this.refreshParent});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var colorScheme = theme.colorScheme;

    var widthAvail = MediaQuery.of(context).size.width;
    var width = widthAvail > maxWidth ? maxWidth : widthAvail;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Container(
            constraints: BoxConstraints(maxWidth: width),
            color: colorScheme.surface.withOpacity(0.2),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              child: Column(
                children: <Widget>[
                  SummaryHeader(diary: diary),
                  const MacroHeaderWidget(
                    calories: true,
                  ),
                  MacroEntryWidget(
                    protein: diary.protein,
                    carb: diary.carb,
                    fat: diary.fat,
                    calories: diary.calories,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
