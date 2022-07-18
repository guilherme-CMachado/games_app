
import 'dart:convert';

GamesDTO gamesDtoFromMap(String str) => GamesDTO.fromMap(json.decode(str));

String gamesDtoToMap(GamesDTO data) => json.encode(data.toMap());

class GamesDTO {
    GamesDTO({
        this.id,
        this.title,
        this.thumbnail,
        this.shortDescription,
        this.gameUrl,
        this.genre,
        this.platform,
        this.publisher,
        this.developer,
        this.releaseDate,
        this.freetogameProfileUrl,
    });

    int? id;
    String? title;
    String? thumbnail;
    String? shortDescription;
    String? gameUrl;
    String? genre;
    String? platform;
    String? publisher;
    String? developer;
    DateTime? releaseDate;
    String? freetogameProfileUrl;

    factory GamesDTO.fromMap(Map<String, dynamic> json) => GamesDTO(
        id: json["id"],
        title: json["title"],
        thumbnail: json["thumbnail"],
        shortDescription: json["short_description"],
        gameUrl: json["game_url"],
        genre: json["genre"],
        platform: json["platform"],
        publisher: json["publisher"],
        developer: json["developer"],
        releaseDate: DateTime.parse(json["release_date"]),
        freetogameProfileUrl: json["freetogame_profile_url"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "thumbnail": thumbnail,
        "short_description": shortDescription,
        "game_url": gameUrl,
        "genre": genre,
        "platform": platform,
        "publisher": publisher,
        "developer": developer,
        "release_date": "${releaseDate?.year.toString().padLeft(4, '0')}-${releaseDate?.month.toString().padLeft(2, '0')}-${releaseDate?.day.toString().padLeft(2, '0')}",
        "freetogame_profile_url": freetogameProfileUrl,
    };
}
