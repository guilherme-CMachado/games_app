import 'package:flutter/material.dart';
import 'package:games_app/api/games_api.dart';
import 'package:games_app/models/GamesDTO.dart';
import 'package:mobx/mobx.dart';
part 'games_controller.g.dart';

class GamesController = _GamesControllerBase with _$GamesController;

abstract class _GamesControllerBase with Store {
  final _api = GamesApi();

  ObservableList<GamesDTO> gamesList = ObservableList<GamesDTO>.of([]);

  @observable
  bool isLoading = false;

  @observable
  bool isError = false;

  @observable
  List<GamesDTO> gamesFavoritos = [];

  @action
  void setLoading(bool loading) {
    this.isLoading = loading;
  }

  @action
  adicionarGameFavorito(GamesDTO game) {
    this.gamesFavoritos.add(game);
  }

  @action
  removerGame(GamesDTO game) {
    this.gamesFavoritos.remove(game);
  }

  bool isFavorite(GamesDTO game) {
    return gamesFavoritos.contains(game);
  }

  buscarJogos() {
    _api.buscarJogos().then((response) {
      return gamesList.addAll(response);
    }).catchError((e) {
      return e;
    });
  }

  buscarJogosCategoria(String text) {
    _api.buscarJogosPorCategoria(text)!.then((value) {
      List<GamesDTO> games = value;
      gamesList.clear();
      return gamesList.addAll(games);
    }).catchError((e) {});
  }
}
