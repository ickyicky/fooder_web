import 'package:flutter/material.dart';
import 'package:fooder/screens/based.dart';
import 'package:fooder/screens/login.dart';
import 'package:fooder/screens/add_entry.dart';
import 'package:fooder/models/diary.dart';
import 'package:fooder/widgets/diary.dart';
import 'package:fooder/widgets/meal.dart';
import 'package:fooder/components/appBar.dart';
import 'package:fooder/components/sliver.dart';
import 'package:fooder/components/datePicker.dart';

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

  void _logout() async {
    await widget.apiClient.logout();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(apiClient: widget.apiClient),
      ),
    );
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

  @override
  Widget build(BuildContext context) {
    Widget content;
    Widget title;

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
                for (var meal in diary!.meals)
                  MealWidget(
                    meal: meal,
                    apiClient: widget.apiClient,
                    refreshParent: _asyncInitState,
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
      appBar: FAppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: _addEntry,
        child: const Icon(Icons.add),
      ),
    );
  }
}
