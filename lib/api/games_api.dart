import 'dart:convert';
import 'package:games_app/models/GamesDTO.dart';
import 'package:http/http.dart' as http;

class GamesApi {
  Future<List<GamesDTO>> buscarJogos() {
    String uri = "https://www.freetogame.com/api/games";
    return http.get(Uri.parse(uri)).then((response) {
      var data = jsonDecode(response.body);
      var list = data as List;
      return list.map((e) => GamesDTO.fromMap(e)).toList();
    }).catchError((e) {
      return e;
    });
  }

  Future<List<GamesDTO>>? buscarJogosPorCategoria(String text) {
    String uri = "https://www.freetogame.com/api/games?category=$text";
    return http.get(Uri.parse(uri)).then((response) {
      var categoria = jsonDecode(response.body);
      var list = categoria as List;
      return list.map((e) => GamesDTO.fromMap(e)).toList();
    }).catchError((e) {
      return e;
    });
  }
}
