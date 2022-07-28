import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import '../models/models.dart';
import '../models/pokemon_info_response.dart';

part 'pokemon_state.dart';

class PokemonCubit extends Cubit<PokemonState> {
  final PokemonInfoResponse pokemonInfoResponse;
  PokemonCubit(this.pokemonInfoResponse) : super(const PokemonState());

  Future<void> getPokemon() async {
    emit(state.copyWith());
    final url = Uri.https(state.baseUrl, 'api/v2/pokemon',
        {'limit': '${state.limit}', 'offset': '${state.offset}'});
    final response = await http.get(url);
    final pokemon = PokemonResponse.fromJson(response.body);
    List<PokemonInfoResponse> temp = [];
    for (int i = 0; i < pokemon.results.length; i++) {
      final url = Uri.https(state.baseUrl, 'api/v2/pokemon/${i + 1}');
      final response = await http.get(url);
      final result = PokemonInfoResponse.fromJson(response.body);
      temp.add(result);
    }
    emit(state);
  }
}
