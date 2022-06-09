import 'package:flutter/material.dart';
import 'package:pokeapi_app/models/models.dart';
import 'package:pokeapi_app/models/pokemon_info_response.dart';
import 'package:pokeapi_app/providers/pokemon_provider.dart';

import '../utils/responsive.dart';

class CardPokemon extends StatefulWidget {
  final List<PokemonInfoResponse> pokemones;
  final Function onNextPokemons;

  const CardPokemon({
    Key? key,
    required this.pokemones,
    required this.onNextPokemons,
  }) : super(key: key);

  @override
  State<CardPokemon> createState() => _CardPokemonState();
}

class _CardPokemonState extends State<CardPokemon> {
  PokemonProvider notifier = PokemonProvider();
  final ScrollController scrollController = ScrollController();

  void _onListener() async {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent) {
      await notifier.getMorePokemon();
    }
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_onListener);
  }

  @override
  void dispose() {
    scrollController.removeListener(_onListener);
    notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _responsive = Responsive(context);

    return SizedBox(
      //color: Colors.blue,
      width: double.infinity,

      child: ListView.builder(
          controller: scrollController,
          padding: EdgeInsets.all(_responsive.ip * 0.018),
          //itemCount: 1,
          itemBuilder: (_, int index) {
            final pokemon = widget.pokemones[index];
            for (int i = 0; i < widget.pokemones.length; i++) {
              return GestureDetector(
                onTap: (() => Navigator.pushNamed(context, 'details',
                    arguments: pokemon)),
                child: Container(
                  color: Colors.transparent,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    children: [
                      FadeInImage(
                        placeholder:
                            const AssetImage('assets/pokeball-loading.gif'),
                        image: NetworkImage(pokemon.sprites.frontDefault,
                            scale: 3),
                        width: _responsive.widthCustom(0.36),
                        fit: BoxFit.contain,
                      ),
                      SizedBox(
                        width: _responsive.widthCustom(0.04),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: _responsive.heightCustom(0.03),
                          ),
                          Text(
                            '# ' + pokemon.id.toString() + ' : ',
                            style: const TextStyle(fontSize: 23),
                          ),
                          SizedBox(
                            height: _responsive.heightCustom(0.02),
                          ),
                          Text(
                            pokemon.name.toUpperCase(),
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
