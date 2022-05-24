import 'dart:io';

import 'package:rsMail/models/mail_account.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseHelper {
  static const _databaseName = "rsmail.s3db";
  static const _databaseVersion = 1;
  Database? _database;

  var databaseFactory = databaseFactoryFfi;

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future<Database?> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    var databasePath = Directory.current.path;
    return await databaseFactory.openDatabase('$databasePath/$_databaseName',
        options: OpenDatabaseOptions(
            version: _databaseVersion,
            onCreate: (Database db, int version) async {
              await db.execute(
                  '''CREATE TABLE mail_accounts (acnt_id text primary key, acnt_name text, acnt_host text, acnt_port text, acnt_user text, acnt_pass text, acnt_email text)''');
            }));
  }

  Future<List<MailAccount>> getAccountsAll(String filter) async {
    Database? db = await instance.database;
    var parsed = await db!.query(
      'mail_accounts',
      orderBy: 'acnt_name DESC',
    );
    print(parsed);
    return parsed
        .map<MailAccount>((json) => MailAccount.fromJson(json))
        .toList();
  }
}
