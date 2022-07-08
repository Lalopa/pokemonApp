part of 'pokemon_bloc.dart';

@immutable
class PokemonState extends Equatable {
  const PokemonState({
    this.baseUrl = '',
    this.limit = 151,
    this.offset = 0,
    this.limitTemporal = 10,
    this.numPagina = 1,
    this.pokemonInfoResponseList = const [],
    this.pokemonRequestStatus = PokemonRequestStatus.pure,
  });

  final String baseUrl;
  final int limit;
  final int offset;
  final int limitTemporal;
  final int numPagina;
  final List<PokemonInfoResponse> pokemonInfoResponseList;
  final PokemonRequestStatus pokemonRequestStatus;

  PokemonState copyWith({
    String? baseUrl,
    int? limit,
    int? offset,
    int? limitTemporal,
    int? numPagina,
    List<PokemonInfoResponse>? pokemonInfoResponseList,
    PokemonRequestStatus? pokemonRequestStatus,
  }) {
    return PokemonState(
      baseUrl: baseUrl ?? this.baseUrl,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
      limitTemporal: limitTemporal ?? this.limitTemporal,
      numPagina: numPagina ?? this.numPagina,
      pokemonInfoResponseList: pokemonInfoResponseList ?? this.pokemonInfoResponseList,
      pokemonRequestStatus: pokemonRequestStatus ?? this.pokemonRequestStatus,
    );
  }

  @override
  List<Object?> get props => [
        baseUrl,
        limit,
        offset,
        limitTemporal,
        numPagina,
        pokemonInfoResponseList,
        pokemonRequestStatus,
      ];
}
