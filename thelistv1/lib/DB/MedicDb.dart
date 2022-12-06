import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../Model/Medic.dart';

class MedicDb {
  MedicDb._();

  static final MedicDb instance = MedicDb._();
  static Database? _database;
  Future<Database> get database async => _database ??= await initDB();

  //Creation de la Base
  initDB() async {
    WidgetsFlutterBinding.ensureInitialized();
    return await openDatabase(
      join(await getDatabasesPath(), 'medicament_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE medic(name TEXT PRIMARY KEY,  description TEXT, isSelected INTEGER)",
        );
      },
      version: 1,
    );
  }

  //Inseretion
  void insertRecipe(Medic medic) async {
    final Database db = await database;

    await db.insert(
      'medic',
      medic.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //Modification
  void updateRecipe(Medic medic) async {
    final Database db = await database;
    await db.update("medic", medic.toMap(),
        where: "name = ?", whereArgs: [medic.name]);
  }

  //Suppression
  void deleteRecipe(String name) async {
    final Database db2 = await database;

    db2.delete("medic", where: "name = ?", whereArgs: [name]);
  }

  //prod selected
  void deleteSelected() async {
    final Database db = await database;
    db.delete("medic", where: "isSelected = ?", whereArgs: [1]);
  }

  //Affichaage des
  Future<List<Medic>> medics() async {
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query('medic');

    List<Medic> medics = List.generate(maps.length, (i) {
      return Medic.fromMap(maps[i]);
    });

    /*if (medics.isEmpty) {
      for (Medic medic in defaultMedics) {
        insertRecipe(medic);
      }
      medics = defaultMedics;
    }*/

    return medics;
  }

  /*final List<Medic> defaultMedics = [
    Medic("Dafalgant", "Périme le 15/12/22", false)
  ];*/
}
