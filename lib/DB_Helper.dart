import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'school.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE Teachers (
            id INTEGER PRIMARY KEY,
            name TEXT,
            salary REAL
          )
        ''');

        await db.execute('''
          CREATE TABLE Department (
            emp_id INTEGER,
            dept TEXT
          )
        ''');

        // Sample data
        await db.insert('Teachers', {'id': 1, 'name': 'Alice', 'salary': 40000});
        await db.insert('Teachers', {'id': 2, 'name': 'Bob', 'salary': 45000});
        await db.insert('Teachers', {'id': 3, 'name': 'Charlie', 'salary': 42000});
        await db.insert('Department', {'emp_id': 1, 'dept': 'Math'});
        await db.insert('Department', {'emp_id': 2, 'dept': 'Science'});
        await db.insert('Department', {'emp_id': 4, 'dept': 'English'});
      },
    );
  }

  Future<List<Map<String, dynamic>>> fetchJoinData(String joinType) async {
    final db = await database;
    String query = '';

    switch (joinType) {
      case 'INNER':
        query = '''
          SELECT t.name, t.salary, d.dept
          FROM Teachers t
          INNER JOIN Department d
          ON t.id = d.emp_id
        ''';
        break;

      case 'LEFT':
        query = '''
          SELECT t.name, t.salary, d.dept
          FROM Teachers t
          LEFT JOIN Department d
          ON t.id = d.emp_id
        ''';
        break;

      case 'CROSS':
        query = '''
          SELECT t.name, t.salary, d.dept
          FROM Teachers t
          CROSS JOIN Department d
        ''';
        break;
    }

    return await db.rawQuery(query);
  }
}
