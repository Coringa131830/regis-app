import 'package:http/http.dart' as http;
import 'package:smart_pantry/pages/login/usuario.dart';

Future<http.Response> get(context, String url) async {
//  final headers = await _headers(context);
  var response = await http.get(url);
  return response;
}

Future<http.Response> post(context, String url, {body}) async {
  final headers = await _headers(context);
  var response = await http.post(url, body: body, headers: headers);
  return response;
}

Future<http.Response> put(context, String url, {body}) async {
  final headers = await _headers(context);
  var response = await http.put(url, body: body, headers: headers);
  return response;
}

Future<http.Response> delete(context, String url) async {
  final headers = await _headers(context);
  var response = await http.delete(url, headers: headers);
  return response;
}

Future<Map<String, String>> _headers(context) async {
  Future<Usuario> user = Usuario.get();

  Map<String, String> headers = {
    "Content-Type": "application/json",
    "Authorization": "Bearer ${user}"
  };
  print(headers);
  return headers;
}
