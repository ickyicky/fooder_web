import 'package:flutter/material.dart';
import 'package:fooder/screens/based.dart';
import 'package:fooder/models/diary.dart';
import 'package:fooder/models/preset.dart';
import 'package:fooder/widgets/preset.dart';

class AddMealScreen extends BasedScreen {
  final Diary diary;

  const AddMealScreen(
      {super.key, required super.apiClient, required this.diary});

  @override
  State<AddMealScreen> createState() => _AddMealScreen();
}

class _AddMealScreen extends State<AddMealScreen> {
  final nameController = TextEditingController();
  final presetNameController = TextEditingController();
  bool nameChanged = false;
  List<Preset> presets = [];

  Future<void> _getPresets() async {
    var presetsMap =
        await widget.apiClient.getPresets(presetNameController.text);

    setState(() {
      presets = (presetsMap['presets'] as List<dynamic>)
          .map((e) => Preset.fromJson(e as Map<String, dynamic>))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      nameController.text = "Meal ${widget.diary.meals.length}";
    });
    _getPresets();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  void popMeDaddy() {
    Navigator.pop(
      context,
    );
  }

  void showError(String message) {
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
    popMeDaddy();
  }

  Future<void> _deletePreset(context, Preset preset) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm deletion of the preset'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.cancel),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                widget.apiClient.deletePreset(preset.id);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _addMealFromPreset() async {
    if (presets.length != 1) {
      _addMeal();
      return;
    }

    await widget.apiClient.addMealFromPreset(
      name: nameChanged ? nameController.text : presets[0].name,
      diaryId: widget.diary.id,
      order: widget.diary.meals.length,
      presetId: presets[0].id,
    );
    popMeDaddy();
  }

  @override
  Widget build(BuildContext context) {
    _getPresets();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("🅵🅾🅾🅳🅴🆁", style: logoStyle(context)),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 720),
          padding: const EdgeInsets.all(10),
          child: ListView(children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Meal name',
              ),
              controller: nameController,
              onChanged: (_) => setState(() {
                nameChanged = true;
              }),
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Search presets',
              ),
              controller: presetNameController,
              onChanged: (_) => _getPresets(),
            ),
            for (var preset in presets)
              ListTile(
                onTap: () {
                  setState(() {
                    presets = [preset];
                    presetNameController.text = preset.name;
                  });
                  _addMealFromPreset();
                },
                onLongPress: () {
                  _deletePreset(context, preset);
                },
                title: PresetWidget(
                  preset: preset,
                ),
              ),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addMealFromPreset,
        child: const Icon(Icons.add),
      ),
    );
  }
}
