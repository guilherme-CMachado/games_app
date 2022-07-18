import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:games_app/controllers/games_controller.dart';
import 'package:games_app/models/GamesDTO.dart';
import 'package:games_app/pages/details_page.dart';

class GameCardWidget extends StatefulWidget {
  final GamesDTO game;
  const GameCardWidget({Key? key, required this.game}) : super(key: key);

  @override
  State<GameCardWidget> createState() => _GameCardWidgetState();
}

class _GameCardWidgetState extends State<GameCardWidget> {
  final _controller = GamesController();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsPage(game: widget.game)));
          },
          child: ClipRRect(
            child: Container(
              child: CachedNetworkImage(
                imageUrl: widget.game.thumbnail ?? "",
              ),
            ),
          ),
        ),
      ],
    );
  }
}
