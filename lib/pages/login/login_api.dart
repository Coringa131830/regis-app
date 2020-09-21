import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:smart_pantry/pages/api_response.dart';
import 'package:smart_pantry/pages/login/usuario.dart';

class LoginApi {
  static Future<ApiResponse<Usuario>> create(String email) async {
    try {
      var url = 'https://regis-app.herokuapp.com/user/signup';

      Map<String, String> headers = {"Content-Type": "application/json"};

      final params = {
        'email': email,
      };

      String s = json.encode(params);

      var response = await http.post(url, body: s, headers: headers);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      Map mapResponse = json.decode(response.body);

      print(response.body);

      if (response.statusCode == 200) {
        final user = Usuario.fromJson(mapResponse);
        user.save();
        return ApiResponse.ok(result: user);
      }

      return ApiResponse.error(msg: mapResponse["erro"]);
    } catch (error) {
      print("ERRO >>>>>> $error");
      return ApiResponse.error(msg: "Não foi possivel criar sua conta, tente novamente.");
    }
  }
}
