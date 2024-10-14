import 'package:flutter/material.dart';

class FruitModel {
  String image;
  bool isBomb;
  Color color;
  FruitModel({
    required this.image,
    this.color = Colors.transparent,
    this.isBomb = false,
  });
}
