import 'package:boxtia_inventory/Model/DB_Model.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> addUser(userModel value) async {
  final boxtiadb = await Hive.openBox<userModel>('boxtiadb');
  boxtiadb.add(value);
}

Future<List<userModel>> getAllUsers() async {
  final boxtiadb = await Hive.openBox<userModel>('boxtiadb');
   List<userModel> users = boxtiadb.values.toList();
  return users;
}


Future<void> updateUserPassword(int key, String newPassword) async {
  final boxtiadb = await Hive.openBox<userModel>('boxtiadb');
  userModel? user = boxtiadb.get(key);
  if (user != null) {
    user.password = newPassword;
    await user.save();
  } else {
    throw Exception('User not found');
  }
}
