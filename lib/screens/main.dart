import 'package:flutter/material.dart';
import 'package:fooder_web/screens/based.dart';
import 'package:fooder_web/screens/login.dart';
import 'package:fooder_web/client.dart';
import 'package:fooder_web/models/meal.dart';
import 'package:fooder_web/models/entry.dart';
import 'package:fooder_web/models/diary.dart';
import 'package:fooder_web/widgets/diary.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueGrey,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: MyHomePage(
        apiClient: ApiClient(
          baseUrl: 'https://fooderapi.domandoman.xyz/api',
        ),
        title: 'FOODER',
      ),
    );
  }
}

class MyHomePage extends BasedScreen {
  final String title;

  const MyHomePage({super.key, required super.apiClient, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // login client when button pressed
  void _login() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(apiClient: widget.apiClient),
      ),
    );
  }

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
        title: Text(widget.title),
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
