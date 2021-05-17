import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class Budgets with ChangeNotifier {
  String _name = '';
  var _cashAmt = 0.0;
  var _creditCardAmt = 0.0;
  var _remainingCash = 0.0;
  var _remainingCredit = 0.0;
  double get cash {
    return _cashAmt;
  }

  String get name {
    return _name;
  }

  double get creditCard {
    return _creditCardAmt;
  }

  double get remainingCash {
    return _remainingCash;
  }

  double get remainingCredit {
    return _remainingCredit;
  }

  Budgets() {
    fetchData();
  }

  static Database database;

  static Future<void> createDatabase() async {
    final dbPath = await sql.getDatabasesPath();
    database = await sql.openDatabase(
      path.join(dbPath, 'Budget.dart'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE budget(name TEXT,cash REAL, creditCard REAL, remainingCash REAL, remainingCredit REAL)');
      },
      version: 1,
    );
  }

  Future<void> fetchData() async {
    if (database == null) return Budgets.createDatabase();

    final data = await database.query('budget');
    data.map((item) {
      _name = item['name'];
      _cashAmt = item['cash'];
      _creditCardAmt = item['creditCard'];
      _remainingCash = item['remainingCash'];
      _remainingCredit = item['remainingCredit'];
    });
    notifyListeners();
  }

  Future<void> addData(String name, double cash, double creditCard) async {
    if (database == null) return Budgets.createDatabase();
    _cashAmt = cash;
    _creditCardAmt = creditCard;
    _name = name;
    _remainingCash = cash;
    _remainingCredit = creditCard;
    notifyListeners();
    database.insert('budget', {
      'name': name,
      'cash': cash,
      'creditCard': creditCard,
      'remainingCash': cash,
      'remainingCredit': creditCard,
    });
  }

  Future<void> editData(double cash, double creditCard) async {
    _remainingCash = cash == _cashAmt
        ? _remainingCash
        : (_remainingCash + (cash - _cashAmt));
    _remainingCredit = creditCard == _creditCardAmt
        ? _creditCardAmt
        : (remainingCredit + (creditCard - _creditCardAmt));
    _cashAmt = cash;
    _creditCardAmt = creditCard;

    notifyListeners();
    database.update('budget', {
      'cash': _cashAmt,
      'creditCard': _creditCardAmt,
      'remainingCash': _remainingCash,
      'remainingCredit': _remainingCredit,
    });
  }

  Future<void> deductCredit(double credit) async {
    _remainingCredit = _remainingCredit - credit;
    notifyListeners();
    return await database.update('budget', {
      'remainingCredit': _remainingCredit,
    });
  }

  Future<void> deductCash(double cash) async {
    _remainingCash = _remainingCash - cash;
    notifyListeners();
    return await database.update('budget', {
      'remainingCash': _remainingCash,
    });
  }
}
