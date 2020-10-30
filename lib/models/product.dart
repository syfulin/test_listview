// test
import 'package:flutter/material.dart';

class Product {
  final String image; // Изображение продукта
  final String title; // Заголовок
  final String subtitle; // Подзаголовок
  final double price; // Цена
  final bool canOrder; // Можно ли заказать продукт к столику
  final int index; // Индекс товара в текущем списке

  Product({
    this.image,
    this.title,
    this.subtitle,
    this.price,
    this.canOrder,
    this.index,
  });
}
