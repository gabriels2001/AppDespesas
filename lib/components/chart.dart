// ignore_for_file: prefer_const_constructors
import 'dart:core';
import 'package:flutter/material.dart';
import '../models/transaction.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;

  const Chart(this.recentTransaction, {Key? key}) : super(key: key);

  // List<Transaction> recentTransaction;

  List<Map<String, Object>> get groupedTransactions {
    //map -chave, valor
    return List.generate(7, (index) {
      //gera a lista com 7 elementos
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      double totalSoma = 0.0;

      for (var i = 0; i < recentTransaction.length; i++) {
        bool sameDay = recentTransaction[i].date.day == weekDay.day;
        bool sameMounth = recentTransaction[i].date.month == weekDay.month;
        bool sameYear = recentTransaction[i].date.year == weekDay.year;

        if (sameDay && sameMounth && sameYear) {
          totalSoma += recentTransaction[i].value;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay)[0], //chave
        'value': totalSoma, //valor
      };
    }).reversed.toList();
  }

  double get _weekTotalValue {
    return groupedTransactions.fold(0.0, (sum, tr) {
      return sum + (tr['value'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    //final alturaDisponivel = MediaQuery.of(context).size.height;

    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((tr) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: tr['day'].toString(),
                value: tr['value'] as double,
                percentage: _weekTotalValue == 0
                    ? 0
                    : (tr['value'] as double) / _weekTotalValue,

                //_weekTotalValue == 0 ? 0 : (tr['value'] as double) / _weekTotalValue,
                //_weekTotalValue == 0 ? 0 : (tr['value'] as double),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
