import 'package:flutter/material.dart';
import 'package:pokeapi_app/models/pokemon_info_response.dart';
import 'package:pokeapi_app/providers/pokemon_provider.dart';
import 'package:pokeapi_app/search/search_delegate.dart';

import 'package:pokeapi_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../utils/responsive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PokemonProvider pokemonProvider;

  final ScrollController scrollController = ScrollController();

  void _onListener() async {
    if (scrollController.position.pixels >= scrollController.position.maxScrollExtent) {
      await pokemonProvider.getMorePokemon();
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    pokemonProvider = Provider.of<PokemonProvider>(context, listen: false)..getOnDisplayPokemon();
    scrollController.addListener(_onListener);
  }

  @override
  void dispose() {
    scrollController.removeListener(_onListener);
    pokemonProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _responsive = Responsive(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(_responsive.height - _responsive.heightCustom(0.73)),
        child: Hero(
          tag: 'card',
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/pokeball_background.png'), fit: BoxFit.cover)),
            child: Card(
              color: const Color.fromRGBO(178, 226, 242, 95),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: _responsive.widthCustom(0.05),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 60, width: 60, child: Image(image: AssetImage('assets/pokeball.gif'))),
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
                              onPressed: () async {
                                await showSearch(context: context, delegate: PokemonSearchDelegate());
                                pokemonProvider.clear();
                                pokemonProvider.getOnDisplayPokemon();
                              },
                              icon: const Icon(Icons.search_outlined))),
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
              return ListView.builder(
                controller: scrollController,
                padding: EdgeInsets.all(_responsive.ip * 0.018),
                itemCount: snapshot.data!.length,
                itemBuilder: (_, int index) {
                  return CardPokemon(pokemon: snapshot.data![index]);
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
