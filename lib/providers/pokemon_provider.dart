import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:pokeapi_app/models/models.dart';
import 'package:rxdart/rxdart.dart';

class PokemonProvider extends ChangeNotifier {
  final String _baseUrl = 'pokeapi.co';
  final int _limit = 151;
  int offset = 0;
  int limitTemporal = 10;
  late PokemonResponse data;
  List<PokemonInfoResponse> results = [];
  int numPagina = 1;
  bool loading = false;
  BehaviorSubject<List<PokemonInfoResponse>> pokemonListBehavior = BehaviorSubject();

  PokemonProvider() {
    if (kDebugMode) {
      print('Pokemon provider inicializado');
    }
    clear();
  }

  Future<void> getOnDisplayPokemon() async {
    final url = Uri.https(_baseUrl, 'api/v2/pokemon', {'limit': '$limitTemporal', 'offset': '$offset'});

    final response = await http.get(url);
    final pokemon = PokemonResponse.fromJson(response.body);

    List<PokemonInfoResponse> temp = [];

    for (int i = 0; i < pokemon.results.length; i++) {
      final url = Uri.https(_baseUrl, 'api/v2/pokemon/${i + 1}');
      final response = await http.get(url);
      final result = PokemonInfoResponse.fromJson(response.body);
      temp.add(result);
    }
    pokemonListBehavior.sink.add(temp);
  }

  Future<void> getMorePokemon() async {
    if (!loading) {
      loading = true;
      offset += 10;
      if (offset <= 151) {
        await morePokemon();
      }

      loading = false;
    }
  }

  Future<void> morePokemon() async {
    final url = Uri.https(_baseUrl, 'api/v2/pokemon', {'limit': '$limitTemporal', 'offset': '$offset'});

    final response = await http.get(url);
    final pokemon = PokemonResponse.fromJson(response.body);

    List<PokemonInfoResponse> resultList = [];
    int off = offset;

    if (off == 150) {
      final url = Uri.https(_baseUrl, 'api/v2/pokemon/${off + 1}');
      off++;
      final response = await http.get(url);
      final result = PokemonInfoResponse.fromJson(response.body);
      resultList.add(result);
    } else {
      for (int i = 0; i < pokemon.results.length; i++) {
        final url = Uri.https(_baseUrl, 'api/v2/pokemon/${off + 1}');
        off++;
        final response = await http.get(url);
        final result = PokemonInfoResponse.fromJson(response.body);
        resultList.add(result);
      }
    }
    List<PokemonInfoResponse> temp = [...pokemonListBehavior.value, ...resultList];
    pokemonListBehavior.sink.add(temp);
  }

  Future<List<PokemonInfoResponse>> searchPokemon(String? query) async {
    if (!loading) {
      loading = true;
      final url = Uri.https(_baseUrl, 'api/v2/pokemon', {'limit': '$_limit', 'offset': '$offset'});
      final response = await http.get(url);
      try {
        if (response.statusCode == 200) {
          data = PokemonResponse.fromJson(response.body);
          List<PokemonInfoResponse> temp = [];
          var results = data.results
              .where((element) => element.name.toLowerCase().contains(((query ?? '').toLowerCase())))
              .toList();
          for (int i = 0; i < results.length; i++) {
            final url = Uri.https(_baseUrl, 'api/v2/pokemon/${results[i].name}');
            final response = await http.get(url);
            final result = PokemonInfoResponse.fromJson(response.body);
            temp.add(result);
          }
          pokemonListBehavior.sink.add(temp);
        } else {
          if (kDebugMode) {
            print('error');
          }
        }
      } on Exception catch (e) {
        if (kDebugMode) {
          print('error: $e');
        }
      }
      loading = false;
      return results;
    }
    return [];
  }

  void clear() {
    pokemonListBehavior.sink.add([]);
    offset = 0;
  }
}
