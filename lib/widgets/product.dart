import 'package:flutter/material.dart';
import 'package:fooder_web/models/product.dart';
import 'dart:core';


class ProductWidget extends StatelessWidget {
  final Product product;

  const ProductWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  product.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Text("${product.calories.toStringAsFixed(2)} kcal"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "carb: ${product.carb.toStringAsFixed(2)}",
                style: TextStyle(color: Theme.of(context).colorScheme.secondary),
              ),
              Text(
                "fat: ${product.fat.toStringAsFixed(2)}",
                style: TextStyle(color: Theme.of(context).colorScheme.secondary),
              ),
              Text(
                "protein: ${product.protein.toStringAsFixed(2)}",
                style: TextStyle(color: Theme.of(context).colorScheme.secondary),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
