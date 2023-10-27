import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fooder/screens/based.dart';
import 'package:fooder/models/product.dart';
import 'package:fooder/models/entry.dart';
import 'package:fooder/widgets/product.dart';
import 'package:fooder/screens/add_product.dart';

class EditEntryScreen extends BasedScreen {
  final Entry entry;

  const EditEntryScreen(
      {super.key, required super.apiClient, required this.entry});

  @override
  State<EditEntryScreen> createState() => _EditEntryScreen();
}

class _EditEntryScreen extends State<EditEntryScreen> {
  final gramsController = TextEditingController();
  final productNameController = TextEditingController();
  List<Product> products = [];

  @override
  void dispose() {
    gramsController.dispose();
    productNameController.dispose();
    super.dispose();
  }

  void popMeDaddy() {
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      gramsController.text = widget.entry.grams.toString();
      productNameController.text = widget.entry.product.name;
      products = [widget.entry.product];
    });
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

  Future<double?> _parseDouble(String text, String name) async {
    try {
      return double.parse(text.replaceAll(",", "."));
    } catch (e) {
      showError("$name must be a number");
      return null;
    }
  }

  Future<void> _saveEntry() async {
    if (products.length != 1) {
      showError("Pick product first");
      return;
    }

    var grams = await _parseDouble(gramsController.text, "Grams");
    if (grams == null) {
      return;
    }

    await widget.apiClient.updateEntry(
      widget.entry.id,
      grams: grams,
      productId: products[0].id,
      mealId: widget.entry.mealId,
    );
    popMeDaddy();
  }

  Future<void> _deleteEntry() async {
    await widget.apiClient.deleteEntry(widget.entry.id);
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
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Product name',
                ),
                controller: productNameController,
                onChanged: (_) => _getProducts(),
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
          FloatingActionButton(
            onPressed: _deleteEntry,
            heroTag: null,
            child: const Icon(Icons.delete),
          ),
          FloatingActionButton(
            onPressed: _saveEntry,
            heroTag: null,
            child: const Icon(Icons.save),
          ),
        ],
      ),
    );
  }
}
