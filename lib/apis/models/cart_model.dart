import 'package:flutter/material.dart';

class CartModel {
  String name;
  String id;
  String colour;
  String size;
  int count;
  dynamic price;
  Color color;
  String img;

  CartModel(
      {required this.name,
      required this.id,
      required this.colour,
      required this.size,
      required this.count,
      required this.color,
      required this.img,
      required this.price});
}

List<CartModel> cart = [];
