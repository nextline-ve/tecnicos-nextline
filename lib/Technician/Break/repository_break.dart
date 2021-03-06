import 'package:dio/dio.dart';
import 'package:tenicos_nextline/Technician/Break/model_break.dart';
import 'package:tenicos_nextline/Technician/Break/model_reason.dart';
import 'package:tenicos_nextline/utils/app_http.dart';

class RepositoryBreaks extends AppHttp {
  Future<Break> addBreakAPI(Break dataBreak) async {
    Response response;
    FormData formData = dataBreak.toFormData();
    try {
      response = await http.post("${await this.getUrlAapi()}support/break/informar/",
          data: formData, options: Options(headers: header));
    } on DioError catch (e) {
      print(e.response);
    }
    return Break.fromJson(response.data);
  }

  Future<List<Reason>> getReasonsAPI() async {
    Response response;
    try {
      response = await http.get("${await this.getUrlAapi()}support/break/motivos/",
          options: Options(headers: header));
    } on DioError catch (e) {
      Map error = e.response.data;
      error.forEach((key, value) => throw (value));
    }
    final parsed = response.data['results'].cast<Map<String, dynamic>>();
    return parsed.map<Reason>((json) => Reason.fromJson(json)).toList();
  }
}
