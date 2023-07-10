// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

abstract class Cart extends StatefulWidget {
  const Cart({super.key, required this.recentTransaction});

  final List<Transaction> recentTransaction;
  Chart(recentTransaction);

  List<Map<String, Object>> get groupedTransaction {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      return {
        'day': DateFormat.E().format(weekDay)[0],
        'value': 9.99,
      };
    });
  }

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        children: <Widget>[],
      ),
    );
  }
}
