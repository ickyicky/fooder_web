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
  final proteinController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    carbController.dispose();
    fatController.dispose();
    proteinController.dispose();
    super.dispose();
  }

  void popMeDady(Product product) {
    Navigator.pop(
      context,
      product,
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

  Future<void> _addProduct() async {
    try {
      double.parse(carbController.text);
    } catch (e) {
      showError("Carbs must be a number");
      return;
    }

    try {
      double.parse(fatController.text);
    } catch (e) {
      showError("Fat must be a number");
      return;
    }

    try {
      double.parse(proteinController.text);
    } catch (e) {
      showError("Protein must be a number");
      return;
    }

    try {
      var productJson = await widget.apiClient.addProduct(
        carb: double.parse(carbController.text),
        fat: double.parse(fatController.text),
        protein: double.parse(proteinController.text),
        name: nameController.text,
      );
      var product = Product.fromJson(productJson);
      popMeDady(product);
    } catch (e) {
      showError("Error adding product, make sure there is no product with the same name");
      return;
    }
  }

  double calculateCalories() {
    double calories = 0;

    try {
      calories += double.parse(carbController.text) * 4;
    } catch (e) {
      // ignore
    }

    try {
      calories += double.parse(fatController.text) * 9;
    } catch (e) {
      // ignore
    }

    try {
      calories += double.parse(proteinController.text) * 4;
    } catch (e) {
      // ignore
    }

    return calories;
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
          child: Column(
            children: <Widget>[
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
                keyboardType:const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
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
                keyboardType:const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
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
                keyboardType:const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
                ],
                controller: proteinController,
                onChanged: (String value) {
                  setState(() {});
                },
              ),
              Text(
                "${calculateCalories()} kcal",
                textAlign: TextAlign.right,
              ),
            ]
          )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addProduct,
        child: const Icon(Icons.add),
      ),
    );
  }
}
