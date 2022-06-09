import 'package:flutter/material.dart';
import 'package:pokeapi_app/models/pokemon_info_response.dart';
import 'package:pokeapi_app/providers/pokemon_provider.dart';
import 'package:pokeapi_app/search/search_delegate.dart';

import 'package:pokeapi_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../utils/responsive.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pokemonProvider = Provider.of<PokemonProvider>(context);
    final _responsive = Responsive(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
            _responsive.height - _responsive.heightCustom(0.73)),
        child: Hero(
          tag: 'card',
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/pokeball_background.png'),
                    fit: BoxFit.cover)),
            child: Card(
              color: const Color.fromRGBO(178, 226, 242, 95),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: _responsive.widthCustom(0.05),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                          height: 60,
                          width: 60,
                          child:
                              Image(image: AssetImage('assets/pokeball.gif'))),
                      const Text(
                        'Pokemones',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        width: _responsive.widthCustom(0.04),
                      ),
                      SizedBox(
                          height: 30,
                          width: 30,
                          child: IconButton(
                              onPressed: () => showSearch(
                                  context: context,
                                  delegate: PokemonSearchDelegate()),
                              icon: const Icon(Icons
                                  .search_outlined)) /*TextField(
                      //controller: editingController,
                      decoration: InputDecoration(
                          labelText: "Buscar",
                          hintText: "Buscar",
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)))),
                    ),*/
                          ),
                      SizedBox(
                        width: _responsive.widthCustom(0.04),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: StreamBuilder<List<PokemonInfoResponse>>(
          stream: pokemonProvider.pokemonListBehavior,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return CardPokemon(
                onNextPokemons: () => PokemonProvider().getMorePokemon(),
                pokemones: snapshot.data!,
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}

/*AppBar(
          backgroundColor: const Color.fromRGBO(178, 226, 242, 95),
          title: const Text('Pokemones'),
          centerTitle: true,
          leading: const Icon(Icons.access_alarms),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search))
          ],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        ),*/