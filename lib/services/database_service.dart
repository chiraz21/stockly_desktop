import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._internal();
  static Database? _database;

  DatabaseService._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // ================= DATABASE INIT =================
  Future<Database> _initDatabase() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, 'stockly.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // ================= CREATE TABLES =================
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE farmers (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        full_name TEXT NOT NULL,
        email TEXT UNIQUE NOT NULL,
        phone TEXT,
        password TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE admins (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT UNIQUE NOT NULL,
        password TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE system_users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT UNIQUE NOT NULL,
        password TEXT NOT NULL,
        role TEXT NOT NULL
      )
    ''');

    // default admin
    await db.insert('admins', {
      'email': 'admin@stockly.com',
      'password': 'admin123',
    });
  }

  // ================= FARMER REGISTER =================
  Future<int> registerFarmer({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  }) async {
    final db = await database;
    return await db.insert('farmers', {
      'full_name': fullName,
      'email': email,
      'phone': phone,
      'password': password,
    });
  }

  // ================= FARMER LOGIN =================
  Future<Map<String, dynamic>?> loginFarmer(
      String email, String password) async {
    final db = await database;
    final res = await db.query(
      'farmers',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    return res.isNotEmpty ? res.first : null;
  }

  // ================= ADMIN LOGIN =================
  Future<Map<String, dynamic>?> loginAdmin(
      String email, String password) async {
    final db = await database;
    final res = await db.query(
      'admins',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    return res.isNotEmpty ? res.first : null;
  }

  // ================= SYSTEM USER LOGIN =================
  Future<Map<String, dynamic>?> loginSystemUser(
      String username, String password) async {
    final db = await database;
    final res = await db.query(
      'system_users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );
    return res.isNotEmpty ? res.first : null;
  }
}
