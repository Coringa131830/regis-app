import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:smart_pantry/utils/simple_bloc.dart';

class LoripsumBloc extends SimpleBloc<String> {
  static String lorim;

  fetch() async {
    try {
      String s = lorim ?? await LoripsumApi.getLoripsum();

      lorim = s;

      add(s);
    } catch (e) {
      addError(e);
    }
  }
}

class LoripsumApi {
  static Future<String> getLoripsum() async {
    var url = "https://loripsum.net/api";

    var response = await http.get(url);

    String text = response.body;

    text = text.replaceAll("<p>", "");
    text = text.replaceAll("</p>", "");

    return text;
  }
}
