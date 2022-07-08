part of 'pokemon_bloc.dart';

@immutable
abstract class PokemonEvent extends Equatable {
  const PokemonEvent();

  @override
  List<Object?> get props => [];
}

class GetPokemon extends PokemonEvent {
  const GetPokemon();
}

class GetMorePokemon extends PokemonEvent {
  const GetMorePokemon();
}

class MorePokemon extends PokemonEvent {
  const MorePokemon();
}

class SearchPokemon extends PokemonEvent {
  final String query;
  const SearchPokemon(this.query);
  @override
  List<Object?> get props => [query];
}
