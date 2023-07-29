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
  @override
  Widget build(BuildContext context) {
    var testDiary = Diary(
      meals: <Meal>[
        Meal(
          entries: <Entry>[
            Entry(
              name: "DUPA",
              calories: 123.21,
              protein: 20.13,
              fat: 99.99,
              carb: -15.02,
            ),
            Entry(
              name: "SRAKA",
              calories: 123.21,
              protein: 20.13,
              fat: 99.99,
              carb: -15.02,
            ),
          ]
        ),
        Meal(
          entries: <Entry>[
            Entry(
              name: "MADA",
              calories: 123.21,
              protein: 20.13,
              fat: 99.99,
              carb: -15.02,
            ),
            Entry(
              name: "FAKA",
              calories: 123.21,
              protein: 20.13,
              fat: 99.99,
              carb: -15.02,
            ),
          ]
        ),
      ]
    );
     
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("FOODER"),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          padding: const EdgeInsets.all(10),
          child: DiaryWidget(diary: testDiary),
        ),
      ),
    );
  }
}
