import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:tenicos_nextline/utils/app_http.dart';
import 'package:tenicos_nextline/utils/app_session.dart';

class RepositoryAuth extends AppHttp {
  Future<ModelSession> setMakeLoginAPI(Map<String, dynamic> dataLogin) async {
    Response resp;
    try {
      FormData formData = new FormData.fromMap(dataLogin);
      resp = await http.post(await this.getUrlAapi() + 'config/auth/', data: formData);
    } on DioError catch (e) {
      print(e.response.data);
      Map error = jsonDecode(jsonEncode(e.response.data));
      error.forEach((key, value) {
        throw (value);
      });
    }
    return ModelSession.fromJson(resp.data);
  }

  Future retrievePassword(Map<String, dynamic> data) async {
    Response resp;
    try {
      FormData formData = new FormData.fromMap(data);
      resp = await http.post(await this.getUrlAapi() + 'config/restaurar-clave/', data: formData);
    } on DioError catch (e) {
      Map error = jsonDecode(jsonEncode(e.response.data));
      error.forEach((key, value) {
        throw (value);
      });
    }
    return resp.data;
  }
}
