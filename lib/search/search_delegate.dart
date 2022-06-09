import 'package:flutter/material.dart';
import 'package:pokeapi_app/providers/pokemon_provider.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../utils/responsive.dart';

class PokemonSearchDelegate extends SearchDelegate {
  final List<PokemonInfoResponse> getInfoPokemon = [];
  @override
  String get searchFieldLabel => 'Buscar Pokemon';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [IconButton(onPressed: () => query = '', icon: const Icon(Icons.clear))];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    final _responsive = Responsive(context);
    final PokemonProvider _pokemonList = Provider.of<PokemonProvider>(context, listen: false)
      ..clear()
      ..searchPokemon(query);

    return StreamBuilder<List<PokemonInfoResponse>>(
        stream: _pokemonList.pokemonListBehavior,
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          List<PokemonInfoResponse>? pokemones = snapshot.data;
          return SizedBox(
            //color: Colors.blue,
            width: double.infinity,

            child: ListView.builder(
                padding: EdgeInsets.all(_responsive.ip * 0.018),
                itemCount: pokemones?.length,
                itemBuilder: (_, int index) {
                  final pokemon = pokemones![index];
                  return GestureDetector(
                    onTap: () => Navigator.pushNamed(context, 'details', arguments: pokemon),
                    child: Container(
                      color: Colors.transparent,
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Row(
                        children: [
                          FadeInImage(
                            placeholder: const AssetImage('assets/pokeball-loading.gif'),
                            image: NetworkImage(pokemon.sprites.frontDefault),
                            width: _responsive.widthCustom(0.10),
                            fit: BoxFit.contain,
                          ),
                          SizedBox(
                            width: _responsive.widthCustom(0.04),
                          ),
                          Text(
                            pokemon.name.toUpperCase(),
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
      child: Image(image: AssetImage('assets/pokeball_background.png'), color: Colors.grey, height: 140),
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
