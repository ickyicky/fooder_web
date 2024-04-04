import 'package:flutter/material.dart';
import 'package:fooder/screens/based.dart';
import 'package:fooder/screens/add_entry.dart';
import 'package:fooder/screens/add_meal.dart';
import 'package:fooder/models/diary.dart';
import 'package:fooder/widgets/summary.dart';
import 'package:fooder/widgets/meal.dart';
import 'package:fooder/components/sliver.dart';
import 'package:fooder/components/date_picker.dart';
import 'package:fooder/components/floating_action_button.dart';

class MainScreen extends BasedScreen {
  const MainScreen({super.key, required super.apiClient});

  @override
  State<MainScreen> createState() => _MainScreen();
}

class _MainScreen extends BasedState<MainScreen> {
  Diary? diary;
  DateTime date = DateTime.now();

  @override
  void initState() {
    super.initState();
    _asyncInitState().then((value) => null);
  }

  Future<void> _asyncInitState() async {
    var diaryMap = await widget.apiClient.getDiary(date: date);

    setState(() {
      diary = Diary.fromJson(diaryMap);
      date = date;
    });
  }

  Future<void> _pickDate(DateTime date) async {
    setState(() {
      this.date = date;
    });

    await _asyncInitState();
  }

  Future<void> _addEntry() async {
    if (diary == null) {
      return;
    }

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            AddEntryScreen(apiClient: widget.apiClient, diary: diary!),
      ),
    ).then((_) => _asyncInitState());
  }

  Future<void> _addMeal(context) async {
    if (diary == null) {
      return;
    }

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddMealScreen(
          apiClient: widget.apiClient,
          diary: diary!,
        ),
      ),
    ).then((_) => _asyncInitState());
  }

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (diary != null) {
      content = CustomScrollView(slivers: <Widget>[
        SliverPersistentHeader(
          delegate: FSliverAppBar(
              child: FDatePickerWidget(date: date, onDatePicked: _pickDate)),
          pinned: true,
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              SummaryWidget(
                diary: diary!,
                apiClient: widget.apiClient,
                refreshParent: _asyncInitState,
              ),
              for (var (i, meal) in diary!.meals.indexed)
                MealWidget(
                  meal: meal,
                  apiClient: widget.apiClient,
                  refreshParent: _asyncInitState,
                  initiallyExpanded: i == 0,
                  showText: showText,
                ),
              const SizedBox(height: 200),
            ],
          ),
        ),
      ]);
    } else {
      content = const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: content,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: appBar(),
      bottomNavigationBar: navBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FActionButton(
            icon: Icons.playlist_add,
            onPressed: () => _addMeal(context),
          ),
          const SizedBox(width: 10),
          FActionButton(
              icon: Icons.library_add, onPressed: _addEntry, tag: "fap2"),
        ],
      ),
    );
  }
}
