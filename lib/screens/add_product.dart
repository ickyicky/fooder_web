import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fooder/screens/based.dart';
import 'package:fooder/models/product.dart';
import 'package:fooder/widgets/product.dart';
import 'package:fooder/components/text.dart';
import 'package:fooder/components/floating_action_button.dart';

class AddProductScreen extends BasedScreen {
  const AddProductScreen({super.key, required super.apiClient});

  @override
  State<AddProductScreen> createState() => _AddProductScreen();
}

class _AddProductScreen extends BasedState<AddProductScreen> {
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
      appBar: appBar(),
      body: Center(
        child: Container(
            constraints: const BoxConstraints(maxWidth: 720),
            padding: const EdgeInsets.all(10),
            child: Column(children: <Widget>[
              FTextInput(
                labelText: 'Product name',
                controller: nameController,
                onChanged: (String value) {
                  setState(() {});
                },
              ),
              FTextInput(
                labelText: 'Carbs',
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
              FTextInput(
                labelText: 'Fat',
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
              FTextInput(
                labelText: 'Protein',
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
              FTextInput(
                labelText: 'Fiber',
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
              ProductWidget(
                product: Product(
                  id: 0,
                  name: nameController.text,
                  carb: double.tryParse(
                          carbController.text.replaceAll(",", ".")) ??
                      0.0,
                  fat: double.tryParse(
                          fatController.text.replaceAll(",", ".")) ??
                      0.0,
                  protein: double.tryParse(
                          proteinController.text.replaceAll(",", ".")) ??
                      0.0,
                  fiber: double.tryParse(
                          fiberController.text.replaceAll(",", ".")) ??
                      0.0,
                  calories: calculateCalories(),
                ),
              )
            ])),
      ),
      floatingActionButton: FActionButton(
        onPressed: _addProduct,
        icon: Icons.save,
      ),
    );
  }
}
