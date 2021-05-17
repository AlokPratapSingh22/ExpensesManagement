import 'package:expenses_management/Animations/fade_animation.dart';
import 'package:expenses_management/pages/homePage.dart';
import 'package:expenses_management/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/budgets.dart';

class AddBudgetDetails extends StatefulWidget {
  @override
  _AddBudgetDetailsState createState() => _AddBudgetDetailsState();
}

class _AddBudgetDetailsState extends State<AddBudgetDetails> {
  final _formKey = GlobalKey<FormState>();

  String _name;
  double _cashAmt;
  double _creditCardAmt;

  void trySubmit() {
    final isValid = _formKey.currentState.validate();

    if (isValid) {
      _formKey.currentState.save();
      Provider.of<Budgets>(context, listen: false)
          .addData(_name, _cashAmt, _creditCardAmt);
      Navigator.popAndPushNamed(context, 'home-page');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(3, 9, 23, 1),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FadeAnimation(
              1.3,
              Text(
                'Add details',
                style: AppColors.textTheme.headline6.copyWith(
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.white60,
                  color: Colors.cyan.shade50,
                  fontSize: 32,
                ),
              )),
          SizedBox(
            height: 15,
          ),
          FadeAnimation(
            1.6,
            Container(
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    blurRadius: 15,
                    offset: Offset.fromDirection(10),
                    color: Colors.amber)
              ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      key: ValueKey('name'),
                      style: AppColors.formTheme.bodyText1.copyWith(
                          color: Colors.grey.shade700,
                          fontSize: 18,
                          letterSpacing: 1.2),
                      onSaved: (newValue) => _name = newValue,
                      validator: (value) {
                        if (value.length <= 0) return 'Please enter your name!';
                        return null;
                      },
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        hintText: 'Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple),
                        ),
                        enabledBorder: new OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.purple, width: 1.0)),
                        labelText: 'Name',
                        labelStyle: AppColors.formTheme.bodyText2
                            .copyWith(color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      key: ValueKey('cash'),
                      style: AppColors.formTheme.bodyText1.copyWith(
                          color: Colors.grey.shade700,
                          fontSize: 18,
                          letterSpacing: 1.2),
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
                      onSaved: (newValue) => _cashAmt = double.parse(newValue),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple),
                          ),
                          enabledBorder: new OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.purple, width: 1.0)),
                          labelText: 'Cash balance for the month',
                          labelStyle: AppColors.formTheme.bodyText2
                              .copyWith(color: Colors.black),
                          hintText: 'Cash balance for the month'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      key: ValueKey('credit card'),
                      style: AppColors.formTheme.bodyText1.copyWith(
                          color: Colors.grey.shade700,
                          fontSize: 18,
                          letterSpacing: 1),
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
                      onSaved: (newValue) =>
                          _creditCardAmt = double.parse(newValue),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple),
                        ),
                        enabledBorder: new OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.purple, width: 1.0)),
                        labelText: 'Credit Card balance for the month',
                        labelStyle: AppColors.formTheme.bodyText2
                            .copyWith(color: Colors.black),
                        hintText: 'Credit card balance for the month',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
          FadeAnimation(
            1.9,
            ElevatedButton.icon(
              onPressed: trySubmit,
              icon: Icon(Icons.save_alt),
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(15),
                overlayColor: MaterialStateProperty.all(Colors.pink.shade300),
                shadowColor: MaterialStateProperty.all(Colors.white24),
              ),
              label: Text(
                'Submit',
                style: AppColors.textTheme.button.copyWith(
                    fontSize: 22,
                    color: Colors.grey.shade200,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
