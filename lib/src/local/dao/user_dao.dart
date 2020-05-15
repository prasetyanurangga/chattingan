import 'dart:async';

import 'package:chattingan/src/local/database/database.dart';
import 'package:chattingan/src/local/model/user_model.dart';



class UserDao {
  final dbProvider = DatabaseProvider.dbProvider;

  //Adds new UserModel records
  Future<int> createUserModel(UserModel userModel) async {
    final db = await dbProvider.database;
    var result = db.insert(userTABLE, userModel.toDatabaseJson());
    return result;
  }

  //Get All UserModel items
  //Searches if query string was passed
  Future<List<UserModel>> getUserModels({String query}) async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result;
    if (query != null) {
      if (query.isNotEmpty)
        result = await db.query(userTABLE,
            where: 'id = ?',
            whereArgs: ["$query"]);
    } else {
      result = await db.query(userTABLE);
    }

    List<UserModel> userModels = result.isNotEmpty
        ? result.map((item) => UserModel.fromDatabaseJson(item)).toList()
        : [];
    return userModels;
  }


  Future<List<UserModel>> getUserAllModels() async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result;
    result = await db.query(userTABLE);

    List<UserModel> userModels = result.isNotEmpty
        ? result.map((item) => UserModel.fromDatabaseJson(item)).toList()
        : [];


    return userModels;
  }

  //Update UserModel record
  Future<int> updateUserModel(UserModel userModel) async {
    final db = await dbProvider.database;

    var result = await db.update(userTABLE, userModel.toDatabaseJson(),
        where: "id = ?", whereArgs: [userModel.id]);

    return result;
  }

  //Delete UserModel records
  Future<int> deleteUserModel(int id) async {
    final db = await dbProvider.database;
    var result = await db.delete(userTABLE, where: 'id = ?', whereArgs: [id]);

    return result;
  }

  //We are not going to use this in the demo
  Future deleteAllUserModels() async {
    final db = await dbProvider.database;
    var result = await db.delete(
      userTABLE,
    );

    return result;
  }
}