import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/transaction.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDb();
    return _db!;
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'expense.db');

    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE transactions(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          amount REAL,
          type TEXT,
          date TEXT
        )
      ''');
    });
  }

  Future<int> insertTransaction(TransactionModel tx) async {
    var dbClient = await db;
    return await dbClient.insert('transactions', tx.toMap());
  }

  Future<List<TransactionModel>> getTransactions() async {
    var dbClient = await db;
    List<Map<String, dynamic>> maps =
        await dbClient.query('transactions', orderBy: 'date DESC');
    return maps.map((map) => TransactionModel.fromMap(map)).toList();
  }

  Future<int> deleteTransaction(int id) async {
    var dbClient = await db;
    return await dbClient.delete('transactions', where: 'id = ?', whereArgs: [id]);
  }
}