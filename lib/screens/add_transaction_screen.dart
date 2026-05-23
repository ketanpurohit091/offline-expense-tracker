import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/transaction.dart';
import '../providers/transaction_provider.dart';

class AddTransactionScreen extends StatefulWidget {
  @override
  _AddTransactionScreenState createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  double amount = 0;
  String type = 'Expense';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Transaction")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                validator: (val) => val == null || val.isEmpty ? 'Enter title' : null,
                onSaved: (val) => title = val!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                validator: (val) => val == null || double.tryParse(val) == null
                    ? 'Enter valid amount'
                    : null,
                onSaved: (val) => amount = double.parse(val!),
              ),
              DropdownButtonFormField(
                value: type,
                items: ['Income', 'Expense']
                    .map((e) => DropdownMenuItem(child: Text(e), value: e))
                    .toList(),
                onChanged: (val) => setState(() => type = val!),
                decoration: InputDecoration(labelText: 'Type'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final provider =
                        Provider.of<TransactionProvider>(context, listen: false);
                    provider.addTransaction(TransactionModel(
                        title: title, amount: amount, type: type, date: DateTime.now()));
                    Navigator.pop(context);
                  }
                },
                child: Text("Add"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}