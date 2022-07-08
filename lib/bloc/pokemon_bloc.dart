import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:pokeapi_app/models/pokemon_info_response.dart';
import 'package:pokeapi_app/models/pokemon_response.dart';
import 'package:pokeapi_app/utils/enums.dart';

part 'pokemon_event.dart';
part 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  PokemonBloc() : super(const PokemonState()) {
    on<PokemonEvent>((event, emit) async {
      if (event is GetPokemon) {
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
        emit(state.copyWith(
          pokemonInfoResponseList: temp,
        ));
      } else if (event is GetMorePokemon) {
      } else if (event is SearchPokemon) {
      } else if (event is MorePokemon) {}
    });
  }
}
