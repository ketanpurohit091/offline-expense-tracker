import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../db/database_helper.dart';

class TransactionProvider extends ChangeNotifier {
  List<TransactionModel> _transactions = [];
  List<TransactionModel> get transactions => _transactions;

  double get totalIncome =>
      _transactions.where((tx) => tx.type == 'Income').fold(0, (sum, tx) => sum + tx.amount);

  double get totalExpense =>
      _transactions.where((tx) => tx.type == 'Expense').fold(0, (sum, tx) => sum + tx.amount);

  double get balance => totalIncome - totalExpense;

  DatabaseHelper _dbHelper = DatabaseHelper();

  Future<void> loadTransactions() async {
    _transactions = await _dbHelper.getTransactions();
    notifyListeners();
  }

  Future<void> addTransaction(TransactionModel tx) async {
    await _dbHelper.insertTransaction(tx);
    await loadTransactions();
  }

  Future<void> deleteTransaction(int id) async {
    await _dbHelper.deleteTransaction(id);
    await loadTransactions();
  }
}