//import 'dart:convert';

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
  BehaviorSubject<List<PokemonInfoResponse>> pokemonListBehavior =
      BehaviorSubject<List<PokemonInfoResponse>>();

  int numPagina = 1;
  bool loading = false;

  PokemonProvider() {
    if (kDebugMode) {
      print('Pokemon provider inicializado');
    }
    getOnDisplayPokemon();
  }

  Future<void> getOnDisplayPokemon() async {
    final url = Uri.https(_baseUrl, 'api/v2/pokemon',
        {'limit': '$limitTemporal', 'offset': '$offset'});
    //REalizar paginacion
    final response = await http.get(url);
    final pokemon = PokemonResponse.fromJson(response.body);
    //https://medium.com/flutter-community/listview-pagination-and-reloading-network-calls-in-flutter-90b1dd78fca2

    List<PokemonInfoResponse> temp = [];

    for (int i = 0; i < pokemon.results.length; i++) {
      final url = Uri.https(_baseUrl, 'api/v2/pokemon/${i + 1}');
      final response = await http.get(url);
      final result = PokemonInfoResponse.fromJson(response.body);
      temp.add(result);
      //https://www.youtube.com/watch?v=lxTulCxn0zM
    }
    pokemonListBehavior.sink.add(temp);
  }

  Future<void> getMorePokemon() async {
    if (!loading) {
      loading = true;
      offset += 10;
      await morePokemon();
      loading = false;
    }
  }

  Future<void> morePokemon() async {
    final url = Uri.https(_baseUrl, 'api/v2/pokemon',
        {'limit': '$limitTemporal', 'offset': '$offset'});

    final response = await http.get(url);
    final pokemon = PokemonResponse.fromJson(response.body);

    List<PokemonInfoResponse> resultList = [];
    int off = offset;

    for (int i = 0; i < pokemon.results.length; i++) {
      final url = Uri.https(_baseUrl, 'api/v2/pokemon/${off + 1}');
      off++;
      final response = await http.get(url);
      final result = PokemonInfoResponse.fromJson(response.body);
      resultList.add(result);
      print('Se agrego: ' + resultList[i].name);
    }
    List<PokemonInfoResponse> temp = [
      ...pokemonListBehavior.value,
      ...resultList
    ];
    pokemonListBehavior.sink.add(temp);
    print('Se agregaron 10 pokemones');
  }

  Future<List<PokemonInfoResponse>> searchPokemon(String? query) async {
    final url = Uri.https(
        _baseUrl, 'api/v2/pokemon', {'limit': '$_limit', 'offset': '$offset'});
    final response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        data = PokemonResponse.fromJson(response.body);
        results = data.results.cast<PokemonInfoResponse>();
        /* results = results
            .where((element) =>
                element.name.toLowerCase().contains((query.toLowerCase())))
            .toList();*/

        List<PokemonInfoResponse> temp = [];
        for (int i = 0; i < results.length; i++) {
          final url = Uri.https(_baseUrl, 'api/v2/pokemon/${i + 1}');
          final response = await http.get(url);
          final result = PokemonInfoResponse.fromJson(response.body);
          temp.add(result);
        }
        pokemonListBehavior.sink.add(temp);
        results = temp
            .where((element) => element.name
                .toLowerCase()
                .contains(((query ?? '').toLowerCase())))
            .toList();
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

    return results;
  }
}



/*for (int i = 0; i < results.length; i++) {
          String numUrl = results[i]
              .url
              .replaceAll('https://pokeapi.co/api/v2/pokemon/', '')
              .replaceAll('/', '');

          final url = Uri.https(_baseUrl, 'api/v2/pokemon/$numUrl');
          final response = await http.get(url);
          final result = PokemonInfoResponse.fromJson(response.body);
          temp.add(result);
          
        }

        pokemonListBehavior.sink.add(temp);*/
        //Regresar una lista de pokemoninforesponse