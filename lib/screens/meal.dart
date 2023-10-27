import 'package:flutter/material.dart';
import 'package:fooder/screens/based.dart';
import 'package:fooder/models/meal.dart';
import 'package:fooder/widgets/macro.dart';

class MealScreen extends BasedScreen {
  final Meal meal;
  final Function() refresh;

  const MealScreen({super.key, required super.apiClient, required this.refresh, required this.meal});

  @override
  State<MealScreen> createState() => _AddMealScreen();
}

class _AddMealScreen extends State<MealScreen> {
  Future<void> saveMeal(context) async {
    TextEditingController textFieldController = TextEditingController();
    textFieldController.text = widget.meal.name;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Save Meal'),
          content: TextField(
            controller: textFieldController,
            decoration: const InputDecoration(hintText: "Meal template name"),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.cancel),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                widget.apiClient
                    .saveMeal(widget.meal, textFieldController.text);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteMeal(Meal meal) async {
    await widget.apiClient.deleteMeal(meal.id);
  }

  Future<void> deleteMeal(context) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm deletion of the meal'),
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
                _deleteMeal(widget.meal);
                Navigator.pop(context);
                Navigator.pop(context);
                widget.refresh();
              },
            ),
          ],
        );
      },
    );
  }

  Widget buildButton(Icon icon, String text, Function() onPressed) {
    return Card(
      child: ListTile(
        onTap: onPressed,
        title: Container(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: <Widget>[
              IconButton(
                icon: icon,
                onPressed: onPressed,
              ),
              const Spacer(),
              Text(text),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("🅵🅾🅾🅳🅴🆁", style: logoStyle(context)),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 720),
          padding: const EdgeInsets.all(10),
          child: CustomScrollView(slivers: <Widget>[
            SliverAppBar(
                title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        widget.meal.name,
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(
                              color: Theme.of(context).colorScheme.onSecondary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const Spacer(),
                      Text(
                        "${widget.meal.calories.toStringAsFixed(1)} kcal",
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(
                              color: Theme.of(context).colorScheme.onSecondary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ]),
                expandedHeight: 150,
                backgroundColor: Theme.of(context).colorScheme.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                floating: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: MacroWidget(
                    protein: widget.meal.protein,
                    carb: widget.meal.carb,
                    fat: widget.meal.fat,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onSecondary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                )),
            SliverList(
                delegate: SliverChildListDelegate([
              buildButton(
                const Icon(Icons.save),
                "Save as preset",
                () => saveMeal(context),
              ),
              buildButton(
                const Icon(Icons.delete),
                "Delete",
                () => deleteMeal(context),
              ),
            ]))
          ]),
        ),
      ),
    );
  }
}
