import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokeapi_app/bloc/pokemon_bloc.dart';
import 'package:pokeapi_app/utils/enums.dart';

import '../models/models.dart';
import '../utils/responsive.dart';

class PokemonSearchDelegate extends SearchDelegate<PokemonInfoResponse> {
  final List<PokemonInfoResponse> getInfoPokemon = [];
  final Bloc<PokemonEvent, PokemonState> pokemonBloc;

  PokemonSearchDelegate(this.pokemonBloc);
  @override
  String get searchFieldLabel => 'Buscar Pokemon';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () => query = '', icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, PokemonInfoResponse.fromJson(query));
        },
        icon: const Icon(Icons.arrow_back));
  }

//2 metodos para traer los 151 pokemones iniciales
//Comparar el query con los 151, con el resultado que se muestre la infromacion
//completa para mostrar la imagen y
  @override
  Widget buildResults(BuildContext context) {
    pokemonBloc.add(SearchPokemon(query));
    final _responsive = Responsive(context);
    //List<PokemonInfoResponse> pokemones = [];

    return BlocBuilder<PokemonBloc, PokemonState>(
        //bloc: pokemonBloc,
        builder: (context, state) {
      if (state.pokemonRequestStatus == PokemonRequestStatus.loading ||
          state.pokemonRequestStatus == PokemonRequestStatus.pure) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state.pokemonRequestStatus == PokemonRequestStatus.error) {
        return const Center(
          child: Text('Error'),
        );
      }
      return SizedBox(
        //color: Colors.blue,
        width: double.infinity,

        child: ListView.builder(
            padding: EdgeInsets.all(_responsive.ip * 0.018),
            itemCount: state.pokemonInfoResponseList.length,
            itemBuilder: (_, int index) {
              final pokemonBloc = state.pokemonInfoResponseList[index];
              //final pokemon = pokemones[index];
              return GestureDetector(
                onTap: () => Navigator.pushNamed(context, 'details',
                    arguments: pokemonBloc),
                child: Container(
                  color: Colors.transparent,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    children: [
                      FadeInImage(
                        placeholder:
                            const AssetImage('assets/pokeball-loading.gif'),
                        image: NetworkImage(pokemonBloc.sprites.frontDefault),
                        width: _responsive.widthCustom(0.10),
                        fit: BoxFit.contain,
                      ),
                      SizedBox(
                        width: _responsive.widthCustom(0.04),
                      ),
                      Text(
                        pokemonBloc.name.toUpperCase(),
                        style: const TextStyle(fontSize: 14),
                      )
                    ],
                  ),
                ),
              );
            }),
      );
    });
  }

  Widget _emptyContainer() {
    return const Center(
      child: Image(
          image: AssetImage('assets/pokeball_background.png'),
          color: Colors.grey,
          height: 140),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return _emptyContainer();
    }

    return Text('Pokemon sugerido $query');
  }
}
