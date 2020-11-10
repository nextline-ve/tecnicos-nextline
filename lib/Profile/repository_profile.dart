import 'package:dio/dio.dart';
import 'package:tenicos_nextline/utils/app_http.dart';

import 'model/model_profile.dart';

class RepositoryProfile extends AppHttp {

  Future<Map<String, String>> changePasswordAPI(
      String oldPassword, String newPassword) async {
    Response response;
    try {
      response = await http.post(api + 'admon/cambiar-clave/',
          data: {"old_clave": oldPassword, "clave": newPassword},
          options: Options(headers: header));
    } on DioError catch (e) {
      Map error = e.response.data;
      error.forEach((key, value) => throw (value));
    }
    return response.data;
  }

  Future<TechProfile> getTechProfileAPI() async {
    Response response;
    try {
      response = await http.get(api + 'support/perfil/',
          options: Options(headers: header));
    } on DioError catch (e) {
      Map error = e.response.data;
      error.forEach((key, value) => throw (value));
    }
    return TechProfile.fromJson(response.data);
  }

}
