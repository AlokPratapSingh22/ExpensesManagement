import 'package:expenses_management/providers/budgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../styles.dart';

class BudgetForm extends StatefulWidget {
  const BudgetForm({
    Key key,
    @required Budgets budget,
  })  : _budget = budget,
        super(key: key);

  final Budgets _budget;

  @override
  _BudgetFormState createState() => _BudgetFormState();
}

class _BudgetFormState extends State<BudgetForm> {
  final _formKey = GlobalKey<FormState>();
  double cash = 0.0;
  double card = 0.0;
  void submitFn() {
    final isValid = _formKey.currentState.validate();
    if (!isValid) return;

    _formKey.currentState.save();
    Provider.of<Budgets>(context, listen: false).editData(cash, card);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text(
            'Edit Budget',
            style: AppColors.textTheme.headline6.copyWith(color: Colors.white),
          ),
          Divider(
            color: Colors.purple,
            thickness: 1.2,
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an amount (in Rupees)';
              }
              if (double.tryParse(value) == null) {
                return 'Please enter a valid number.';
              }
              if (double.parse(value) <= 0) {
                return 'Please enter a number greater than zero.';
              }
              return null;
            },
            onSaved: (newValue) => cash = double.parse(newValue.trim()),
            style: AppColors.formTheme.bodyText1,
            initialValue: widget._budget.cash.toString(),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.purple),
              ),
              enabledBorder: new OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple, width: 1.0)),
              labelText: 'Cash for the month - ',
              labelStyle: AppColors.formTheme.bodyText2,
            ),
            keyboardType: TextInputType.number,
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            onSaved: (newValue) => card = double.parse(newValue.trim()),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an amount (in Rupees)';
              }
              if (double.tryParse(value) == null) {
                return 'Please enter a valid number.';
              }
              if (double.parse(value) <= 0) {
                return 'Please enter a number greater than zero.';
              }
              return null;
            },
            style: AppColors.formTheme.bodyText1,
            initialValue: widget._budget.creditCard.toString(),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.purple),
              ),
              enabledBorder: new OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple, width: 1.0)),
              labelText: 'Credit Card balance for the month - ',
              labelStyle: AppColors.formTheme.bodyText2,
            ),
            keyboardType: TextInputType.number,
          ),
          SizedBox(
            height: 10,
          ),
          TextButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.amber),
                overlayColor: MaterialStateProperty.all(Colors.cyan)),
            onPressed: submitFn,
            child: Text('Submit',
                style: AppColors.formTheme.button
                    .copyWith(fontWeight: FontWeight.bold, fontSize: 16)),
          )
        ],
      ),
    );
  }
}
