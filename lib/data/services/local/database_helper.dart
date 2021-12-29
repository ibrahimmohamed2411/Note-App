import 'dart:async';
import 'dart:io';
import 'package:note_app/data/models/note.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._init();
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
  static const _dbName = "notes.db";
  static const _dbVersion = 1;
  static const _tableName = "notes";

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initiateDatabase();
    return _database!;
  }

  Future<Database> _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) {
    return db.execute('''
      CREATE TABLE $_tableName(
        ${NoteFields.id} INTEGER PRIMARY KEY ,
        ${NoteFields.title} TEXT NOT NULL,
        ${NoteFields.description} TEXT NOT NULL,
        ${NoteFields.createdDate} TEXT NOT NULL
       
      )''');
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }

  Future<int> create(Map<String, dynamic> map) async {
    Database db = await instance.database;
    final id = await db.insert(_tableName, map,
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  Future<List<Map<String, Object?>>> readAllNotes() async {
    Database db = await instance.database;
    const orderBy = '${NoteFields.id} ASC';
    final List<Map<String, dynamic>> result = await db.query(
      _tableName,
      orderBy: orderBy,
    );
    return result;
  }

  Future<int> update(Note note) async {
    Database db = await instance.database;
    return await db.update(
      _tableName,
      note.toJson(),
      where: "${NoteFields.id} = ?",
      whereArgs: [note.id],
    );
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(
      _tableName,
      where: "${NoteFields.id} = ?",
      whereArgs: [id],
    );
  }

  Future<int> deleteAllNotes() async {
    Database db = await instance.database;
    return await db.delete(_tableName);
  }
}
