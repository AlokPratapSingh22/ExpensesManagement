import 'package:expenses_management/models/transaction.dart';
import 'package:expenses_management/providers/budgets.dart';
import 'package:expenses_management/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/transact.dart';

class AddTransactionForm extends StatefulWidget {
  @override
  _AddTransactionFormState createState() => _AddTransactionFormState();
}

class _AddTransactionFormState extends State<AddTransactionForm> {
  /// variables from here
  DateTime _selectedDate = DateTime.now();
  String _title = '';
  String _description = '';
  String _amount = '';
  TransactionMode _selectedMode = null;

  /// till here

  /// functions to handle inputs

  /// date picker function
  void _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  /// onChanged function of [transaction mode] selection
  void _changedDropDownItem(TransactionMode mode) {
    setState(() {
      _selectedMode = mode;
    });
  }

  /// onPressed function for [Submit Button]
  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
      switch (_selectedMode) {
        case TransactionMode.Cash:
          Provider.of<Budgets>(context, listen: false)
              .deductCash(double.parse(_amount.trim()));
          break;
        case TransactionMode.CreditCard:
          Provider.of<Budgets>(context, listen: false)
              .deductCredit(double.parse(_amount.trim()));
          break;
      }
      Provider.of<Transact>(context, listen: false).addTransaction(
        pickedTitle: _title.trim(),
        description: _description.trim(),
        amount: double.tryParse(_amount.trim()),
        pickedDate: _selectedDate,
        mode: _selectedMode,
      );
      Navigator.of(context).pop();
    }
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white)),
              child: Text(
                'New Transaction',
                style: AppColors.formTheme.headline6,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              onSaved: (newValue) {
                _title = newValue;
              },
              autocorrect: true,
              textCapitalization: TextCapitalization.words,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title for your transaction';
                }
                return null;
              },
              style: AppColors.formTheme.bodyText1,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: 'Title',
                hintStyle: AppColors.formTheme.bodyText1,
                border: InputBorder.none,
              ),
              maxLines: 1,
              cursorColor: Colors.white,
              keyboardType: TextInputType.text,
              key: ValueKey('title'),
            ),
            Divider(
              color: Colors.white,
            ),
            TextFormField(
              onSaved: (newValue) => _description = newValue,
              autocorrect: true,
              textCapitalization: TextCapitalization.sentences,
              validator: (value) {
                if (value == null || value.isEmpty || value.length <= 10) {
                  return 'Please enter at least 10 letters';
                }
                return null;
              },
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: 'Description',
                hintStyle: AppColors.formTheme.bodyText1,
                border: InputBorder.none,
              ),
              cursorColor: Colors.white,
              key: ValueKey('description'),
              style: AppColors.formTheme.bodyText1,
              keyboardType: TextInputType.multiline,
            ),
            Divider(
              color: Colors.white,
            ),
            TextFormField(
              onSaved: (newValue) => _amount = newValue,
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
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: 'Amount',
                hintStyle: AppColors.formTheme.bodyText1,
                border: InputBorder.none,
              ),
              key: ValueKey('amount'),
              keyboardType: TextInputType.number,
              cursorColor: Colors.white,
              style: AppColors.formTheme.bodyText1,
            ),
            Divider(
              color: Colors.white,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: Text(
                    "${_selectedDate.toLocal()}".split(' ')[0],
                    style: AppColors.formTheme.bodyText1,
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _selectDate(context), // Refer step 3
                    style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all(Colors.cyan),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.amber)),
                    child: Text(
                      'Select date',
                      style: AppColors.formTheme.button.copyWith(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.white,
            ),
            DropdownButton(
              isExpanded: true,
              hint: Text(
                'Select Transaction Mode',
                textAlign: TextAlign.center,
                style:
                    AppColors.formTheme.bodyText1.copyWith(color: Colors.white),
              ),
              style:
                  AppColors.formTheme.bodyText1.copyWith(color: Colors.white),
              // isExpanded: true,
              underline: Container(),
              dropdownColor: Colors.black87,
              focusColor: Colors.black,
              value: _selectedMode == null ? null : _selectedMode,
              items: [
                DropdownMenuItem(
                  child: FittedBox(
                    child: Text(
                      'Credit Card',
                      style: AppColors.formTheme.bodyText1
                          .copyWith(color: Colors.white),
                    ),
                  ),
                  value: TransactionMode.CreditCard,
                ),
                DropdownMenuItem(
                  child: FittedBox(
                    child: Text('Cash',
                        style: AppColors.formTheme.bodyText1
                            .copyWith(color: Colors.white)),
                  ),
                  value: TransactionMode.Cash,
                ),
              ],
              onChanged: (value) {
                if (value == TransactionMode.Cash ||
                    value == TransactionMode.CreditCard) {
                  _changedDropDownItem(value);
                }
              },
            ),
            Divider(
              color: Colors.white,
            ),
            ElevatedButton(
              style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.cyan),
                  backgroundColor: MaterialStateProperty.all(Colors.amber)),
              onPressed: _trySubmit,
              child: Text(
                'Submit',
                style: AppColors.formTheme.button.copyWith(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
