import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlDb {
  // SqlDb._();
  // static final SqlDb db = SqlDb._();
  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await initDb();
      return _db;
    } else {
      return _db;
    }
  }

//!
  initDb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, "UserData.db");
    Database mydb = await openDatabase(path,
        version: 3, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return mydb;
  }

  _onUpgrade(Database db, int oldversion, int newvrsion) {
    print('ON Upgradededed');
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE "notes" (
      "id" INTEGER  NOT NULL PRIMARY KEY AUTOINCREMENT,
      "email" TEXT NOT NULL,
      "password" TEXT NOT NULL
      )
''');
    print('CREATED DATA BASE AND TABLE============');
  }

  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }
//!
  // Future<void> insertUser(UserModel userModel) async {
  //   var dbClient = await database;
  //   await dbClient?.insert(
  //     tableUser,
  //     userModel.toJson(),
  //     conflictAlgorithm: ConflictAlgorithm.replace,
  //   );
  // }

  // Future<UserModel?> getUser(int id) async {
  //   var dbClient = await database;
  //   List<Map> maps = await dbClient!.query(
  //     tableUser,
  //     where: '$columnId= ?',
  //     whereArgs: [id],
  //   );
  //   if (maps.length > 0) {
  //     return UserModel.fromJson(maps.first);
  //   } else {
  //     return null;
  //   }
  // }
  // Future<List<UserModel?>> getAllUsers() async {
  //   var dbClient = await database;
  //   List<Map> maps = await dbClient!.query(tableUser);

  //   return maps.isNotEmpty
  //       ? maps.map((user) => UserModel.fromJson(user)).toList()
  //       : [];
  // }
}
