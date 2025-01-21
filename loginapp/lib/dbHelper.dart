import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'user_data.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE user(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_code TEXT,
        display_name TEXT,
        email TEXT,
        employee_code TEXT,
        company_code TEXT
      )
    ''');
  }

  Future<void> insertUser(Map<String, dynamic> userData) async {
    final db = await database;
    await db.insert('user', {
      'user_code': userData['User_Code'],
      'display_name': userData['User_Display_Name'],
      'email': userData['Email'],
      'employee_code': userData['User_Employee_Code'],
      'company_code': userData['Company_Code'],
    });
  }
}
