import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io'as io;
import 'Food.dart';


class DBHelper {
  static Database? _db;

  Future<Database?> get  db async{
    if(_db!=null){
      return _db!;
    }
    _db =await initDatabase();
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'cart.db');
    var db = await openDatabase(path,version: 1,onCreate: _onCreate);
    return db;

  }

   _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE cart (id TEXT PRIMARY KEY , name TEXT ,'
            ' price TEXT, detail TEXT , avatar TEXT ,like INTEGER)'
        );

  }
  Future<Foods> insert(Foods foods) async {
    var dbClient = await db;
    await dbClient!.insert('cart',foods.toJson());
    return foods;
  }

  Future<List<Foods>> getFoodsList() async {
    var dbClient = await db;
    print("đsá");
   final List<Map<String,Object?>> queryResult = await dbClient!.query('cart');
     return queryResult.map((e) => Foods.fromJson(e)).toList();
  }
  Future<int> deleteFoodsList(String id)async{
    var dbClient=await db;
    return await dbClient!.delete(
      'cart',
      where: 'id = ?',
      whereArgs: [id]
    );
  }
}