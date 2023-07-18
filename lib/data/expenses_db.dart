import 'package:expense_app/models/expense_item_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static Database? _database;

  String expenseTable = "expense_table";
  String colId = "id";
  String colCategory = "category";
  String colAmount = "amount";
  String colDescription = "description";
  String colDate = "date";

  DatabaseHelper._createInstance();

  factory DatabaseHelper(){
    _databaseHelper ??= DatabaseHelper._createInstance();
    return _databaseHelper!;
  }

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    final directory = getDatabasesPath();
    String path = '$directory/expenses.db';
    var expenseDb = await openDatabase(path, version: 1, onCreate: _createDb);
    return expenseDb;
  }

  void _createDb(Database db, int newVersion) async {
      await db.execute('CREATE TABLE $expenseTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colCategory TEXT, '
          '$colDescription TEXT, $colAmount TEXT,$colDate TEXT)');
  }

  Future<List<Map<String, dynamic>>> getExpenses() async {
    Database db = await database;
    var result = await db.query(expenseTable);
    return result;
  }

  Future<int> insertNote(ExpenseItemModel data) async {
    Database db = await database;
    var result = await db.insert(expenseTable, data.toJson());
    return result;
  }

  Future<List<ExpenseItemModel>> getExpensesList() async {
    var data = await getExpenses();
    List<ExpenseItemModel> dataList = [];

    for(var item in data){
      dataList.add(ExpenseItemModel.fromJson(item));
    }
    return dataList;
  }
}