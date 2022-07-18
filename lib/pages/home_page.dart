import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:games_app/globals/global_colors.dart';
import 'package:games_app/globals/global_variables.dart';
import 'package:games_app/pages/favorite_page.dart';
import 'package:games_app/widgets/game_card_widget.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _categorySearcher = TextEditingController();

  @override
  void initState() {
    globalGames.buscarJogos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return SafeArea(
        child: Scaffold(
          body: _buildBody(context),
        ),
      );
    });
  }

  _buildBody(BuildContext context) {
    return ListView(children: [
      Container(
        padding: EdgeInsets.only(left: 24),
        color: ColorsStyle.azulRoxo,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Games App",
              style: TextStyle(
                fontSize: 24.0,
                color: Colors.lightGreen,
                fontFamily: "Roboto",
              ),
            ),
            IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => FavoritePage(gamesFavoritos: globalGames.gamesFavoritos)));
                },
                icon: Icon(Icons.favorite_border_outlined, color: Colors.blueGrey[300])),
          ],
        ),
      ),
      _buildPesquisa(),
      _buildGrid(),
    ]);
  }

  Container _buildPesquisa() {
    return Container(
      decoration: BoxDecoration(
        color: ColorsStyle.azulRoxo,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 1,
            offset: Offset(-1, 3),
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(16, 16, 16, 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Color(0XFCF6F6F6),
                borderRadius: BorderRadius.circular(10.0),
              ),
              height: 50,
              width: 380,
              alignment: Alignment.center,
              child: TextField(
                controller: _categorySearcher,
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                    hintText: "Buscar jogo por categoria",
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    suffixIcon: IconButton(
                        onPressed: () {
                          showDialog(context: context, builder: (BuildContext context) => _showAlertCategory());
                        },
                        icon: Icon(Icons.info_outlined, color: Colors.grey))),
                onChanged: (text) {
                  if (text.length == 0) {
                    globalGames.gamesList.clear();
                    globalGames.buscarJogos();
                  }
                },
                onSubmitted: (text) {
                  //Busca o jogo digitado
                  globalGames.buscarJogosCategoria(text);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildGrid() {
    if (globalGames.gamesList.isEmpty) {
      return SizedBox.shrink();
    }

    return StaggeredGrid.count(
      axisDirection: AxisDirection.right,
      crossAxisSpacing: 2,
      mainAxisSpacing: 2,
      crossAxisCount: 2,
      children: globalGames.gamesList.map((element) {
        return GameCardWidget(game: element);
      }).toList(),
    );
  }

  Widget _showAlertCategory() {
    return AlertDialog(
      title: Text("Categorias"),
      content: Text(
          "mmorpg, shooter, strategy, moba, racing, sports, social, sandbox, open-world, survival, pvp, pve, pixel, voxel, zombie, turn-based, first-person, third-Person, top-down, tank, space, sailing, side-scroller, superhero, permadeath, card, battle-royale, mmo, mmofps, mmotps, 3d, 2d, anime, fantasy, sci-fi, fighting, action-rpg, action, military, martial-arts, flight, low-spec, tower-defense, horror, mmorts"),
      actions: [TextButton(onPressed: () => Navigator.pop(context, "OK"), child: Text("OK"))],
    );
  }
}
