import 'package:tmdb_api/tmdb_api.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final tmdb = TMDB(
  //TMDB instance
  ApiKeys(
    dotenv.env['apiKeyV3']!,
    dotenv.env['apiReadAccessTokenv4']!,
  ),
);
