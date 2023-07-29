import 'package:flutter/material.dart';
import 'package:fooder_web/screens/based.dart';
import 'package:fooder_web/models/meal.dart';
import 'package:fooder_web/models/entry.dart';
import 'package:fooder_web/models/diary.dart';
import 'package:fooder_web/widgets/diary.dart';


class MainScreen extends BasedScreen {
  const MainScreen({super.key, required super.apiClient});

  @override
  State<MainScreen> createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  Diary? diary;

  @override
  Widget build(BuildContext context) {
    var content;

    if (diary != null) {
        content = Container(
          constraints: const BoxConstraints(maxWidth: 600),
          padding: const EdgeInsets.all(10),
          child: DiaryWidget(diary: diary!),
        );
    } else {
      content = const CircularProgressIndicator();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("FOODER"),
      ),
      body: Center(
        child: content,
      ),
    );
  }
}
