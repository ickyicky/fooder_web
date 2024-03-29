import 'package:flutter/material.dart';
import 'package:fooder/screens/based.dart';
import 'package:fooder/screens/add_entry.dart';
import 'package:fooder/screens/add_meal.dart';
import 'package:fooder/models/diary.dart';
import 'package:fooder/widgets/diary.dart';
import 'package:fooder/widgets/summary.dart';
import 'package:fooder/widgets/meal.dart';
import 'package:fooder/widgets/macroEntry.dart';
import 'package:fooder/components/sliver.dart';
import 'package:fooder/components/datePicker.dart';
import 'package:blur/blur.dart';

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
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            AddEntryScreen(apiClient: widget.apiClient, diary: diary!),
      ),
    ).then((_) => _asyncInitState());
  }

  Widget floatingActionButton(BuildContext context) {
    var theme = Theme.of(context);
    var colorScheme = theme.colorScheme;

    return Container(
        height: 64,
        width: 64,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: colorScheme.primary.withOpacity(0.3),
              blurRadius: 5,
              offset: const Offset(0, 5),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: Stack(
            children: [
              Blur(
                blur: 10,
                blurColor: colorScheme.primary.withOpacity(0.1),
                child: Container(
                  height: 64,
                  width: 64,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        colorScheme.primary.withOpacity(0.1),
                        colorScheme.secondary.withOpacity(0.1),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 64,
                width: 64,
                child: FloatingActionButton(
                  elevation: 0,
                  onPressed: _addEntry,
                  backgroundColor: Colors.transparent,
                  child: Icon(
                    Icons.library_add,
                    color: colorScheme.onPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (diary != null) {
      content = CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            delegate: FSliverAppBar(child: FDatePickerWidget(date: date, onDatePicked: _pickDate)),
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
                  ),
              ],
            ),
          ),
        ]
      );
    } else {
      content = const Center(child: const CircularProgressIndicator());
    }


    return Scaffold(
      body: content,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: appBar(),
      bottomNavigationBar: navBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: floatingActionButton(context),
    );
  }
}
