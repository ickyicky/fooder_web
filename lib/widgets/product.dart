import 'package:flutter/material.dart';
import 'package:fooder/models/product.dart';
import 'package:fooder/widgets/macro.dart';
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
              Text("${product.calories.toStringAsFixed(1)} kcal"),
            ],
          ),
          MacroWidget(
            protein: product.protein,
            carb: product.carb,
            fat: product.fat,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
