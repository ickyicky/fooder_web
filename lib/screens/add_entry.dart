import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fooder/screens/based.dart';
import 'package:fooder/models/product.dart';
import 'package:fooder/models/diary.dart';
import 'package:fooder/models/meal.dart';
import 'package:fooder/widgets/product.dart';
import 'package:fooder/components/text.dart';
import 'package:fooder/components/dropdown.dart';
import 'package:fooder/components/floating_action_button.dart';
import 'package:fooder/screens/add_product.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class AddEntryScreen extends BasedScreen {
  final Diary diary;

  const AddEntryScreen(
      {super.key, required super.apiClient, required this.diary});

  @override
  State<AddEntryScreen> createState() => _AddEntryScreen();
}

class _AddEntryScreen extends BasedState<AddEntryScreen> {
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

  @override
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

  Future<void> _findProductByBarCode() async {
    var res = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SimpleBarcodeScannerPage(),
      ),
    );

    if (res is String) {
      try {
        var productMap = await widget.apiClient.getProductByBarcode(res);

        var product = Product.fromJson(productMap);

        setState(() {
          products = [product];
          productNameController.text = product.name;
        });
      } catch (e) {
        showError("Product not found");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar(),
      body: Center(
        child: Container(
            constraints: const BoxConstraints(maxWidth: 720),
            padding: const EdgeInsets.all(10),
            child: ListView(children: <Widget>[
              FDropdown<Meal>(
                labelText: 'Meal',
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
              FTextInput(
                labelText: 'Product name',
                controller: productNameController,
                onChanged: (_) => _getProducts(),
                onFieldSubmitted: (_) => _addEntry(),
                autofocus: true,
              ),
              FTextInput(
                labelText: 'Grams',
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
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FActionButton(
            onPressed: _findProductByBarCode,
            icon: Icons.photo_camera,
          ),
          const SizedBox(width: 10),
          FActionButton(
            onPressed: _addEntry,
            icon: Icons.library_add,
            tag: "fap2",
          ),
        ],
      ),
    );
  }
}
