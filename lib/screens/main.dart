import 'package:flutter/material.dart';
import 'package:fooder/screens/based.dart';
import 'package:fooder/screens/login.dart';
import 'package:fooder/screens/add_entry.dart';
import 'package:fooder/models/diary.dart';
import 'package:fooder/widgets/diary.dart';

class MainScreen extends BasedScreen {
  const MainScreen({super.key, required super.apiClient});

  @override
  State<MainScreen> createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
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

  Future<void> _pickDate() async {
    date = (await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(2020),
      lastDate: DateTime(DateTime.now().year + 1),
    ))!;
    await _asyncInitState();
  }

  void _logout() async {
    widget.apiClient.logout();
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
      content = Container(
        constraints: const BoxConstraints(maxWidth: 720),
        padding: const EdgeInsets.all(10),
        child: DiaryWidget(
            diary: diary!,
            apiClient: widget.apiClient,
            refreshParent: _asyncInitState),
      );
      title = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextButton(
            child: Text(
              "🅵🅾🅾🅳🅴🆁",
              style: logoStyle(context),
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        MainScreen(apiClient: widget.apiClient)),
              ).then((_) => _asyncInitState());
            },
          ),
          const Spacer(),
          Text(
            "${date.year}-${date.month}-${date.day}",
            style: const TextStyle(fontSize: 20),
          ),
          IconButton(
            icon: const Icon(Icons.calendar_month),
            onPressed: _pickDate,
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      );
    } else {
      content = const CircularProgressIndicator();
      title = Text("🅵🅾🅾🅳🅴🆁", style: logoStyle(context));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: title,
      ),
      body: Center(
        child: content,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addEntry,
        child: const Icon(Icons.add),
      ),
    );
  }
}
