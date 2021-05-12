import 'package:dio/dio.dart';
import 'package:tenicos_nextline/Technician/Assignment/model_assignment.dart';
import 'package:tenicos_nextline/Tickets/model/model_ticket.dart';
import 'package:tenicos_nextline/utils/app_http.dart';

class RepositoryTickets extends AppHttp {
  Future<List<Ticket>> getDataTicketsAPI() async {
    Response response;
    try {
      response = await http.get('${await this.getUrlAapi()}support/tickets/',
          options: Options(headers: header));
    } on DioError catch (e) {
      Map error = e.response.data;
      error.forEach((key, value) => throw (value));
    }
    final parsed = response.data['results'].cast<Map<String, dynamic>>();
    return parsed.map<Ticket>((json) => Ticket.fromJson(json)).toList();
  }

  Future<List<Ticket>> getAssignedTicketsAPI() async {
    Response response;
    try {
      response = await http.get('${await this.getUrlAapi()}support/tickets-asignados/',
          options: Options(headers: header));
    } on DioError catch (e) {
      Map error = e.response.data;
      error.forEach((key, value) => throw (value));
    }
    final parsed = response.data['results'].cast<Map<String, dynamic>>();
    return parsed.map<Ticket>((json) => Ticket.fromJson(json)).toList();
  }

  Future<Ticket> getDetailsAssignedTicketsAPI(id) async {
    Response response;
    try {
      response = await http.get('${await this.getUrlAapi()}support/tickets-asignados/$id',
          options: Options(headers: header));
    } on DioError catch (e) {
      Map error = e.response.data;
      error.forEach((key, value) => throw (value));
    }
    return Ticket.fromJson(response.data);
  }

  Future finishAssignmentAPI(Assignment assignment) async {
    Response response;
    try {
      FormData formData = assignment.toFormData();
      response = await http.post('${await this.getUrlAapi()}support/ejecutar-ticket/',
          data: formData, options: Options(headers: header));
    } on DioError catch (e) {
      Map error = e.response.data;
      error.forEach((key, value) => throw (value));
    }
    return Assignment.fromJson(response.data);
  }
}
