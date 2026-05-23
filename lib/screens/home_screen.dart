import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';
import '../widgets/transaction_tile.dart';
import 'add_transaction_screen.dart';
import 'package:fl_chart/fl_chart.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransactionProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Expense Tracker")),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(12),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text("Income", style: TextStyle(fontSize: 16)),
                      Text(provider.totalIncome.toStringAsFixed(2),
                          style: TextStyle(color: Colors.green, fontSize: 20)),
                    ],
                  ),
                  Column(
                    children: [
                      Text("Expense", style: TextStyle(fontSize: 16)),
                      Text(provider.totalExpense.toStringAsFixed(2),
                          style: TextStyle(color: Colors.red, fontSize: 20)),
                    ],
                  ),
                  Column(
                    children: [
                      Text("Balance", style: TextStyle(fontSize: 16)),
                      Text(provider.balance.toStringAsFixed(2),
                          style: TextStyle(fontSize: 20)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SizedBox(
              height: 150,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      value: provider.totalIncome,
                      color: Colors.green,
                      title: 'Income',
                    ),
                    PieChartSectionData(
                      value: provider.totalExpense,
                      color: Colors.red,
                      title: 'Expense',
                    ),
                  ],
                  sectionsSpace: 2,
                  centerSpaceRadius: 30,
                ),
              ),
            ),
          ),
          Expanded(
            child: provider.transactions.isEmpty
                ? Center(child: Text("No Transactions"))
                : ListView.builder(
                    itemCount: provider.transactions.length,
                    itemBuilder: (context, index) {
                      final tx = provider.transactions[index];
                      return TransactionTile(
                        tx: tx,
                        onDelete: () => provider.deleteTransaction(tx.id!),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => AddTransactionScreen())),
        child: Icon(Icons.add),
      ),
    );
  }
}