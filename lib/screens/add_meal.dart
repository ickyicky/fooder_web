import 'package:flutter/material.dart';
import 'package:fooder/screens/based.dart';
import 'package:fooder/models/diary.dart';


class AddMealScreen extends BasedScreen {
  final Diary diary;

  const AddMealScreen({super.key, required super.apiClient, required this.diary});

  @override
  State<AddMealScreen> createState() => _AddMealScreen();
}


class _AddMealScreen extends State<AddMealScreen> {
  final nameController = TextEditingController();

  @override
  void initState () {
    super.initState();
    setState(() {
      nameController.text = "Meal ${widget.diary.meals.length}";
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  void popMeDady() {
    Navigator.pop(
      context,
    );
  }

  void showError(String message)
  {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, textAlign: TextAlign.center),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }

  Future<void> _addMeal() async {
    await widget.apiClient.addMeal(
      name: nameController.text,
      diaryId: widget.diary.id,
      order: widget.diary.meals.length,
    );
    popMeDady();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("🅵🅾🅾🅳🅴🆁"),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 720),
          padding: const EdgeInsets.all(10),
          child: TextFormField(
              decoration: const InputDecoration(
                labelText: 'Meal name',
              ),
              controller: nameController,
            ),
          )
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addMeal,
        child: const Icon(Icons.add),
      ),
    );
  }
}
