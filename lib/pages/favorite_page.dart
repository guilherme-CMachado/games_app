import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:games_app/globals/global_variables.dart';
import 'package:games_app/models/GamesDTO.dart';
import 'package:games_app/widgets/game_card_widget.dart';

class FavoritePage extends StatefulWidget {
  final List<GamesDTO> gamesFavoritos;

  const FavoritePage({Key? key, required this.gamesFavoritos}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(),
        body: Observer(
          builder: (_) {
            return _buildBody();
          },
        ),
      ),
    );
  }

  _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      title: Text(
        "Página de favoritos",
        style: TextStyle(color: Colors.black, fontSize: 20),
      ),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
      ),
    );
  }

  _buildBody() {
    return Observer(builder: (_) {
      if (widget.gamesFavoritos.isEmpty) {
        return SizedBox.shrink();
      } else
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: GridView.count(
            shrinkWrap: true,
            primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: globalGames.gamesFavoritos.map((element) {
              return GameCardWidget(game: element);
            }).toList(),
          ),
        );
    });
  }
}
