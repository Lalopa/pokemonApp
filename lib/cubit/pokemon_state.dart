part of 'pokemon_cubit.dart';

class PokemonState extends Equatable {
  const PokemonState({
    this.baseUrl = 'pokeapi.co',
    this.limit = 151,
    this.offset = 0,
    this.pokemonInfoResponseList = const [],
  });

  final String baseUrl;
  final int limit;
  final int offset;
  final List<PokemonInfoResponse> pokemonInfoResponseList;

  PokemonState copyWith({
    String? baseUrl,
    int? limit,
    int? offset,
    List<PokemonInfoResponse>? pokemonInfoResponseList,
  }) {
    return PokemonState(
        baseUrl: baseUrl ?? this.baseUrl,
        limit: limit ?? this.limit,
        offset: offset ?? this.offset,
        pokemonInfoResponseList:
            pokemonInfoResponseList ?? this.pokemonInfoResponseList);
  }

  @override
  List<Object> get props => [baseUrl, limit, offset, pokemonInfoResponseList];
}
