import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fooder/screens/based.dart';
import 'package:fooder/models/product.dart';

class AddProductScreen extends BasedScreen {
  const AddProductScreen({super.key, required super.apiClient});

  @override
  State<AddProductScreen> createState() => _AddProductScreen();
}

class _AddProductScreen extends State<AddProductScreen> {
  final nameController = TextEditingController();
  final carbController = TextEditingController();
  final fatController = TextEditingController();
  final fiberController = TextEditingController();
  final proteinController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    carbController.dispose();
    fatController.dispose();
    fiberController.dispose();
    proteinController.dispose();
    super.dispose();
  }

  void popMeDaddy(Product product) {
    Navigator.pop(
      context,
      product,
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

  Future<double?> _parseDouble(String text, String name,
      {bool silent = false}) async {
    try {
      return double.parse(text.replaceAll(",", "."));
    } catch (e) {
      if (!silent) {
        showError("$name must be a number");
      }
      return null;
    }
  }

  Future<void> _addProduct() async {
    var carb = await _parseDouble(carbController.text, "Carbs");
    var fat = await _parseDouble(fatController.text, "Fat");
    var protein = await _parseDouble(proteinController.text, "Protein");
    var fiber =
        await _parseDouble(fiberController.text, "Fiber", silent: true) ?? 0;

    if (carb == null || fat == null || protein == null) {
      return;
    }

    try {
      var productJson = await widget.apiClient.addProduct(
        carb: carb,
        fat: fat,
        protein: protein,
        fiber: fiber,
        name: nameController.text,
      );
      var product = Product.fromJson(productJson);
      popMeDaddy(product);
    } catch (e) {
      showError(
          "Error adding product, make sure there is no product with the same name");
      return;
    }
  }

  double calculateCalories() {
    double calories = 0;

    var carb = double.tryParse(carbController.text.replaceAll(",", "."));
    var fat = double.tryParse(fatController.text.replaceAll(",", "."));
    var protein = double.tryParse(proteinController.text.replaceAll(",", "."));
    var fiber = double.tryParse(fiberController.text.replaceAll(",", "."));

    if (carb != null) {
      calories += carb * 4;
    }

    if (fat != null) {
      calories += fat * 9;
    }

    if (protein != null) {
      calories += protein * 4;
    }

    if (fiber != null) {
      calories += fiber * 2;
    }

    return calories;
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
            child: Column(children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Product name',
                ),
                controller: nameController,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Carbs',
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^(\d+)?[\.,]?\d{0,2}')),
                ],
                controller: carbController,
                onChanged: (String value) {
                  setState(() {});
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Fat',
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^(\d+)?[\.,]?\d{0,2}')),
                ],
                controller: fatController,
                onChanged: (String value) {
                  setState(() {});
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Protein',
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^(\d+)?[\.,]?\d{0,2}')),
                ],
                controller: proteinController,
                onChanged: (String value) {
                  setState(() {});
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Fiber',
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^(\d+)?[\.,]?\d{0,2}')),
                ],
                controller: fiberController,
                onChanged: (String value) {
                  setState(() {});
                },
              ),
              Text(
                "${calculateCalories().toStringAsFixed(2)} kcal",
                textAlign: TextAlign.right,
              ),
            ])),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addProduct,
        child: const Icon(Icons.add),
      ),
    );
  }
}
