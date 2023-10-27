import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fooder/screens/based.dart';
import 'package:fooder/models/product.dart';
import 'package:fooder/models/diary.dart';
import 'package:fooder/models/meal.dart';
import 'package:fooder/widgets/product.dart';
import 'package:fooder/screens/add_product.dart';

class AddEntryScreen extends BasedScreen {
  final Diary diary;

  const AddEntryScreen(
      {super.key, required super.apiClient, required this.diary});

  @override
  State<AddEntryScreen> createState() => _AddEntryScreen();
}

class _AddEntryScreen extends State<AddEntryScreen> {
  final gramsController = TextEditingController();
  final productNameController = TextEditingController();
  Meal? meal;
  List<Product> products = [];

  @override
  void dispose() {
    gramsController.dispose();
    productNameController.dispose();
    super.dispose();
  }

  void popMeDaddy() {
    Navigator.pop(
      context,
    );
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      meal = widget.diary.meals[0];
    });
    _getProducts().then((value) => null);
  }

  Future<void> _getProducts() async {
    var productsMap =
        await widget.apiClient.getProducts(productNameController.text);
    setState(() {
      products = (productsMap['products'] as List<dynamic>)
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList();
    });
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, textAlign: TextAlign.center),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }

  Future<double?> _parseDouble(String text) async {
    try {
      return double.parse(text.replaceAll(",", "."));
    } catch (e) {
      return null;
    }
  }

  Future<void> _addEntry({bool silent = false}) async {
    if (products.length != 1) {
      if (!silent) {
        showError("Pick one product");
      }
      return;
    }

    var grams = await _parseDouble(gramsController.text);
    if (grams == null) {
      if (!silent) {
        showError("Grams must be a number");
      }
      return;
    }

    await widget.apiClient.addEntry(
      grams: grams,
      productId: products[0].id,
      mealId: meal!.id,
    );
    popMeDaddy();
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
            child: ListView(children: <Widget>[
              DropdownButton<Meal>(
                value: meal,
                // Callback that sets the selected popup menu item.
                onChanged: (Meal? meal) {
                  if (meal == null) {
                    return;
                  }
                  setState(() {
                    this.meal = meal;
                  });
                },
                items: <DropdownMenuItem<Meal>>[
                  for (var meal in widget.diary.meals)
                    DropdownMenuItem<Meal>(
                      value: meal,
                      child: Text(meal.name),
                    ),
                ],
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Product name',
                ),
                controller: productNameController,
                onChanged: (_) => _getProducts(),
                onFieldSubmitted: (_) => _addEntry(),
                autofocus: true,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Grams',
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^(\d+)?[\.,]?\d{0,2}')),
                ],
                controller: gramsController,
                onFieldSubmitted: (_) => _addEntry(),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddProductScreen(
                        apiClient: widget.apiClient,
                      ),
                    ),
                  ).then((product) {
                    if (product == null) {
                      return;
                    }
                    setState(() {
                      products = [product];
                      productNameController.text = product.name;
                    });
                  });
                },
                child: const Text("Don't see your product? Add it!"),
              ),
              for (var product in products)
                ListTile(
                  onTap: () {
                    setState(() {
                      products = [product];
                      productNameController.text = product.name;
                    });
                    _addEntry(silent: true);
                  },
                  title: ProductWidget(
                    product: product,
                  ),
                ),
            ])),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addEntry,
        child: const Icon(Icons.add),
      ),
    );
  }
}
