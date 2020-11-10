import 'dart:convert';
import 'package:sqflite/sqflite.dart';

import 'database_helper.dart';

class AppSession {
  static bool isLoggedIn = false;
  static ModelSession data;

  Future register(ModelSession _data) async {
    await _data.deleteObject();
    await _data.saveObject();
    AppSession.data = _data;
  }

  Future unregister() async {
    AppSession.data = null;
    await ModelSession().deleteObject();
    return true;
  }

  Future<bool> isActiveSession() async {
    ModelSession session = ModelSession();
    AppSession.data = await session.getObject(1);
    if (AppSession.data == null) {
      AppSession.isLoggedIn = false;
      return false;
    } else {
      AppSession.isLoggedIn = true;
      return true;
    }
  }
}

class ModelSession extends DatabaseHelper implements DataBaseInterface {
  String token;
  String avatar;
  String nombre;
  int idUsuario;
  int usuarioApp;

  ModelSession(
      {this.token,
        this.avatar,
        this.nombre,
        this.idUsuario,
        this.usuarioApp});

  ModelSession.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    avatar = json['avatar'];
    nombre = json['nombre'];
    idUsuario = json['id_usuario'];
    usuarioApp = json['usuario_app'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['avatar'] = this.avatar;
    data['nombre'] = this.nombre;
    data['id_usuario'] = this.idUsuario;
    data['usuario_app'] = this.usuarioApp;
    return data;
  }

  Future deleteObject() async {
    final db = await database;

    // Remove the Dog from the Database.
    await db.delete(
      'cliente'
    );
  }

  @override
  Future getObject(int id) async {
    Database db = await this.database;
    try {
      List<Map> maps = await db.query('cliente',
          columns: ['*'], where: "id = ?", whereArgs: [id]);
      if (maps.length > 0) {
        AppSession.isLoggedIn = true;
        var data = json.decode(json.encode(maps.first));

        return ModelSession.fromJson(data);
      } else {
        return null;
      }
    } catch (e) {
      print("==== Es un nuevo celular ===");
      await _createTable();
      return null;
    }
  }

  @override
  Future<int> saveObject() async {
    Database db = await database;
    return await db.insert('cliente', toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<bool> _createTable() async {
    Database db = await database;
    db.execute("DROP TABLE IF EXISTS cliente;");
    db.execute(
      "CREATE TABLE cliente(id INTEGER PRIMARY KEY, "
          "token TEXT,"
          "avatar TEXT,"
          "nombre TEXT,"
          "id_usuario INTEGER,"
          "usuario_app INTEGER)",
    );
    return true;
  }
}