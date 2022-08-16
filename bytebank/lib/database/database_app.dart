import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:bytebank/database/contact_database.dart';

Future<Database> createDatabase() async {
  final dbPath = await getDatabasesPath();
  final fileDbPath = join(dbPath, 'bytebank.db');

  return openDatabase(
    fileDbPath,
    onCreate: (db, version) {
      db.execute(ContactDatabase.instance.table);
    },
    version: 1,
  );
}
