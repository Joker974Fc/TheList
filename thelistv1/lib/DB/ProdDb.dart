import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

import '../Model/Prod.dart';

class DbProd {
  DbProd._();

  static final DbProd instance = DbProd._();
  static Database? _database;
  Future<Database> get database async => _database ??= await initDB();

// creation DB ou recup si existe
  /*Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }*/

//creation DB
  initDB() async {
    WidgetsFlutterBinding.ensureInitialized();
    return await openDatabase(
      join(await getDatabasesPath(), 'prod_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE prod(name TEXT PRIMARY KEY,  description TEXT, isSelected INTEGER)",
        );
      },
      version: 1,
    );
  }

//insert
  void insertRecipe(Prod prod) async {
    final Database db = await database;

    await db.insert(
      'prod',
      prod.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

//Modif
  void updateRecipe(Prod prod) async {
    final Database db = await database;
    await db.update("prod", prod.toMap(),
        where: "name = ?", whereArgs: [prod.name]);
  }

//supprim
  void deleteRecipe(String name) async {
    final Database db = await database;
    db.delete("prod", where: "name = ?", whereArgs: [name]);
  }

//AfFiche les produits
  Future<List<Prod>> prods() async {
    final Database db = await database;
    print("MAMIA");
    final List<Map<String, dynamic>> maps = await db.query('prod');
    List<Prod> prods = List.generate(maps.length, (i) {
      return Prod.fromMap(maps[i]);
    });

    if (prods.isEmpty) {
      for (Prod prod in defaultProds) {
        insertRecipe(prod);
      }
      prods = defaultProds;
    }

    return prods;
  }

//liste defaut
  final List<Prod> defaultProds = [Prod("Lait", "Périme le 15/12/22", false)];
}
