import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:games_app/globals/global_colors.dart';
import 'package:games_app/globals/global_variables.dart';
import 'package:games_app/models/GamesDTO.dart';

class DetailsPage extends StatefulWidget {
  final GamesDTO game;
  DetailsPage({Key? key, required this.game}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: _buildAppBar(context),
          body: Observer(
            builder: (_) {
              return _buildBody(context);
            },
          )),
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Text("Details"),
      backgroundColor: ColorsStyle.azulRoxo,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      actions: [
        IconButton(
            onPressed: () {
              setState(() {
                if (!globalGames.isFavorite(widget.game)) {
                  return globalGames.adicionarGameFavorito(widget.game);
                } else {
                  return globalGames.removerGame(widget.game);
                }
              });
            },
            icon: globalGames.isFavorite(widget.game) ? Icon(Icons.favorite) : Icon(Icons.favorite_border_outlined))
      ],
    );
  }

  _buildBody(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.blue,
          height: MediaQuery.of(context).size.height / 2,
          child: Image.network(
            widget.game.thumbnail ?? "",
            fit: BoxFit.cover,
          ),
        ),
        _buildInfo()
      ],
    );
  }

  _buildInfo() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      height: 260,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        color: Colors.white,
      ),
      child: Column(
        children: <Widget>[
          Center(
            child: Text(
              "${widget.game.title}",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 20),
          Text("${widget.game.shortDescription}"),
        ],
      ),
    );
  }
}
