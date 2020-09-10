import 'dart:async';

import 'package:smart_pantry/firebase/firebase_service.dart';
import 'package:smart_pantry/pages/api_response.dart';
import 'package:smart_pantry/utils/simple_bloc.dart';


class LoginBloc extends SimpleBloc<bool> {

  Future<ApiResponse> login(String login, String senha) async {

    add(true);


    ApiResponse response = await FirebaseService().login(login, senha);

    add(false);

    return response;

  }
}