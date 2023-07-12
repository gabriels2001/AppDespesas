// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_const_constructors_in_immutables
//import 'dart:ffi';
import 'package:estudo/components/transaction_form.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'models/transaction.dart';
import 'components/transaction_list.dart';
import 'components/chart.dart';

class WebView extends StatelessWidget {
  WebView({super.key});

  final ThemeData tema = ThemeData();

  @override
  Widget build(BuildContext context) {
    //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]); import 'package:flutter/services.dart';
    //Deixar aprenas retrato

    return MaterialApp(
      title: 'Perguntas',
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      // theme: tema.copyWith(
      //   colorScheme: tema.colorScheme.copyWith(
      //     primary: Colors.purple,
      //     //secondary: Colors.purple[600],
      //   ),
      // button: TextStyle(s
      //   color: Colors.white,
      //   fontWeight: FontWeight.bold
      // )
      //),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];

  bool _exibirGrafico = false;

  List<Transaction> get _recentTransacton {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });
    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final appBar = AppBar(
      title: Text(
        'Despesas Pessoais',
        // style: TextStyle(
        //   fontSize: 20 * MediaQuery.of(context).textScaleFactor,
        // mudar o tamanho da fonte cresça de acordo com a escolha do usuario caso mude o tema do texto no cll
        // ),
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () {
            setState(() {
              _exibirGrafico = !_exibirGrafico;
            });
          },
          icon: Icon(_exibirGrafico ? Icons.list : Icons.show_chart),
        ),
        IconButton(
          onPressed: () => _openTransactionFormModal(context),
          icon: Icon(Icons.add),
        ),
      ],
    );
    final alturaDisponivel = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            //Mostrar botao em cima para mudar
            //if (isLandscape)
            //   Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Text('Exibir grafico'),
            //       Switch(
            //           value: _exibirGrafico,
            //           onChanged: (value) {
            //             setState(() {
            //               _exibirGrafico = value;
            //             });
            //           }),
            //     ],
            //   ),
            //-----------------------------------------------
            // SizedBox(
            //   height: alturaDisponivel * 0.35,
            //   child: Chart(_recentTransacton),
            // ),
            // //if (!_exibirGrafico)
            // SizedBox(
            //   height: alturaDisponivel * 0.65,
            //   child:
            //       TransactionList(_transactions, onRemove: _removeTransaction),
            // ),
            //---------------------------------------------
            if (_exibirGrafico ||
                !isLandscape) //- com if ou ternario  ? sizedbox() : sizedbox
              SizedBox(
                height: alturaDisponivel * (isLandscape ? 0.7 : 0.3),
                child: Chart(_recentTransacton),
              )
            else if (!_exibirGrafico || !isLandscape)
              SizedBox(
                height: alturaDisponivel * 0.65,
                child: TransactionList(_transactions,
                    onRemove: _removeTransaction),
              ),
            //-----------------------------------------------------
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openTransactionFormModal(context),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
