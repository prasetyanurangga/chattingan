import 'dart:async';

import 'package:chattingan/src/local/dao/user_dao.dart';
import 'package:chattingan/src/local/model/user_model.dart';


class AuthenticationRepository {
  static const int _id = 1;
  final userDao = UserDao();

  Future<void> deleteAll() async {
    try {
      await userDao.deleteAllUserModels();
      return true;
    } on Exception catch (e) {
      print('custom exception is been obtained');
    }
    return false;
  }

  Future<void> deleteUser() async {
    try {
      await userDao.deleteUserModel(_id);
      return true;
    } on Exception catch (e) {
      print('custom exception is been obtained');
    }
    return false;
  }

  Future<void> persistUser(UserModel userModel) async {
    try {
      await userDao.createUserModel(userModel);
      return true;
    } on Exception catch (e) {
      print('custom exception is been obtained');
    }
    return false;
  }

  Future<bool> hasUser() async {
    try {
      var user = await userDao.getUserAllModels();

      print(user.length);

      if (user.length > 0) {
        return true;
      }
    } on Exception catch (e) {
      print('custom exception is been obtained');
    }
    return false;
  }

  Future<List<UserModel>> fetchUser(String _id) async {
    var user;
    try {
      user = await userDao.getUserModels(query: _id.toString());
    } on Exception catch (e) {
      print('custom exception is been obtained');
    }
    return user;
  }

  Future<List<UserModel>> fetchAllUser() async {
    var user;
    try {
      user = await userDao.getUserAllModels();
    } on Exception catch (e) {
      print('custom exception is been obtained');
    }
    return user;
  }
}