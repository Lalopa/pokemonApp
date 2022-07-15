import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:pokeapi_app/models/pokemon_info_response.dart';
import 'package:pokeapi_app/models/pokemon_response.dart';
import 'package:pokeapi_app/utils/enums.dart';

part 'pokemon_event.dart';
part 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  PokemonBloc() : super(const PokemonState()) {
    on<PokemonEvent>((event, emit) async {
      //Traer los primeros 10 pokemons
      if (event is GetPokemon) {
        emit(state.copyWith(pokemonRequestStatus: PokemonRequestStatus.loading));
        final url = Uri.https(
            state.baseUrl, 'api/v2/pokemon', {'limit': '${state.limitTemporal}', 'offset': '${state.offset}'});

        final response = await http.get(url);
        final pokemon = PokemonResponse.fromJson(response.body);

        List<PokemonInfoResponse> temp = [];

        for (int i = 0; i < pokemon.results.length; i++) {
          final url = Uri.https(state.baseUrl, 'api/v2/pokemon/${i + 1}');
          final response = await http.get(url);
          final result = PokemonInfoResponse.fromJson(response.body);
          temp.add(result);
        }
        emit(state.copyWith(pokemonInfoResponseList: temp, pokemonRequestStatus: PokemonRequestStatus.successInfo));
      }
      //Validar si se necesita traer 10 pokemons mas
      else if (event is GetMorePokemon) {
        if (!state.loading) {
          emit(state.copyWith(loading: true, offset: state.offset + 10));

          if (state.offset <= 151) {
            const MorePokemon();
          }
          emit(state.copyWith(loading: false));
        }
      }
      //Buscar pokemon en especifico
      else if (event is SearchPokemon) {
        if (!state.loading) {
          emit(state.copyWith(loading: true));

          final url =
              Uri.https(state.baseUrl, 'api/v2/pokemon', {'limit': '${state.limit}', 'offset': '${state.offset}'});
          final response = await http.get(url);
          try {
            if (response.statusCode == 200) {
              PokemonResponse data = PokemonResponse.fromJson(response.body);
              List<PokemonInfoResponse> temp = [];
              var results = data.results
                  .where((element) => element.name.toLowerCase().contains(((event.query).toLowerCase())))
                  .toList();
              for (int i = 0; i < results.length; i++) {
                final url = Uri.https(state.baseUrl, 'api/v2/pokemon/${results[i].name}');
                final response = await http.get(url);
                final result = PokemonInfoResponse.fromJson(response.body);
                temp.add(result);
              }
              emit(state.copyWith(pokemonInfoResponseList: temp));
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
          emit(state.copyWith(loading: false));

          //return emit(state.copyWith());

          //return state.pokemonInfoResponseList;
        }
      }
      //Traer 10 pokemons mas apartir del ultimo que se obtuvo
      else if (event is MorePokemon) {
        final url = Uri.https(
            state.baseUrl, 'api/v2/pokemon', {'limit': '${state.limitTemporal}', 'offset': '${state.offset}'});

        final response = await http.get(url);
        final pokemon = PokemonResponse.fromJson(response.body);

        List<PokemonInfoResponse> resultList = [];
        int off = state.offset;

        if (off == 150) {
          final url = Uri.https(state.baseUrl, 'api/v2/pokemon/${off + 1}');
          off++;
          final response = await http.get(url);
          final result = PokemonInfoResponse.fromJson(response.body);
          resultList.add(result);
        } else {
          for (int i = 0; i < pokemon.results.length; i++) {
            final url = Uri.https(state.baseUrl, 'api/v2/pokemon/${off + 1}');
            off++;
            final response = await http.get(url);
            final result = PokemonInfoResponse.fromJson(response.body);
            resultList.add(result);
          }
        }
        List<PokemonInfoResponse> temp = [...state.pokemonInfoResponseList, ...resultList];

        emit(state.copyWith(pokemonInfoResponseList: temp));
      }
    });
  }
}
