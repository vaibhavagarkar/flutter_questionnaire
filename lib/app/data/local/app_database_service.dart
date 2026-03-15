import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class AppDatabaseService {
  static const _databaseName = 'questionnaire_app.db';
  static const _databaseVersion = 1;

  late final Database _database;

  Future<void> init() async {
    final databasePath = await getDatabasesPath();
    _database = await openDatabase(
      path.join(databasePath, _databaseName),
      version: _databaseVersion,
      onCreate: (database, version) async {
        // Keep auth data separate from questionnaire history.
        await database.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            phone TEXT NOT NULL UNIQUE,
            password TEXT NOT NULL
          )
        ''');

        await database.execute('''
          CREATE TABLE submissions (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            user_id INTEGER NOT NULL,
            questionnaire_id TEXT NOT NULL,
            questionnaire_title TEXT NOT NULL,
            answers_json TEXT NOT NULL,
            submitted_at TEXT NOT NULL,
            latitude REAL NOT NULL,
            longitude REAL NOT NULL
          )
        ''');
      },
    );
  }

  Database get database => _database;
}
