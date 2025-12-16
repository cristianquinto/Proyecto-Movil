import 'package:flutter/material.dart';
import '../models/client_model.dart';
import 'user_model.dart';

class UsuarioController {
  // Este sería un "mock" de base de datos
  static List<UserModel> users = [];

  static List<UserModel> getUsers() {
    return users;
  }

  static void addUser(UserModel user) {
    users.add(user);
  }

  static void updateUser(int index, UserModel user) {
    users[index] = user;
  }

  static void deleteUser(int index) {
    users.removeAt(index);
  }
}
