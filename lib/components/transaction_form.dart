// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double) onSubmit;

  // ignore: use_key_in_widget_constructors
  TransactionForm(this.onSubmit);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  //TransactionForm({super.key});
  final titlecontroller = TextEditingController();

  final valuecontroller = TextEditingController();

  _submitForm() {
    final title = titlecontroller.text;
    final value = double.tryParse(valuecontroller.text) ?? 0.00;

    if (title.isEmpty || value <= 0) {
      return;
    }

    //widget.onSubmit(title, value);
    widget.onSubmit(title, value);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              controller: titlecontroller,
              onSubmitted: (_) => _submitForm(),
              keyboardType: TextInputType.numberWithOptions(
                  decimal: true), //mostar teclado em num.
              decoration: InputDecoration(
                labelText: 'Titulo',
                border: UnderlineInputBorder(),
              ),
            ),
            TextField(
              controller: valuecontroller,
              onSubmitted: (_) => _submitForm(),
              decoration: InputDecoration(
                labelText: 'Valor (R\$)',
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text(
                    'Nova Transação',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
