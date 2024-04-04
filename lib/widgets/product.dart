import 'package:flutter/material.dart';
import 'package:fooder/models/product.dart';
import 'package:fooder/widgets/macro.dart';
import 'dart:core';

class ProductHeader extends StatelessWidget {
  final String title;

  const ProductHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              title,
              overflow: TextOverflow.fade,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}

class ProductWidget extends StatelessWidget {
  final Product product;

  const ProductWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          ProductHeader(
            title: product.name,
          ),
          const MacroHeaderWidget(
            fiber: true,
            calories: true,
            alignment: Alignment.center,
          ),
          MacroEntryWidget(
            protein: product.protein,
            carb: product.carb,
            fat: product.fat,
            fiber: product.fiber,
            calories: product.calories,
            alignment: Alignment.center,
          ),
        ],
      ),
    );
  }
}
