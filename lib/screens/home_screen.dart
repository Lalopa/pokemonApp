import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokeapi_app/bloc/pokemon_bloc.dart';
import 'package:pokeapi_app/models/models.dart';
import 'package:pokeapi_app/search/search_delegate.dart';

import 'package:pokeapi_app/utils/enums.dart';

import 'package:pokeapi_app/widgets/widgets.dart';

import '../utils/responsive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController scrollController = ScrollController();

  void _onListener() async {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent) {
      BlocProvider.of<PokemonBloc>(context).add(const MorePokemon());

      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    //latePokemonBloc = context.watch<PokemonBloc>();

    scrollController.addListener(_onListener);
  }

  @override
  void dispose() {
    scrollController.removeListener(_onListener);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _responsive = Responsive(context);

    return BlocProvider(
      create: (BuildContext context) => PokemonBloc()..add(const GetPokemon()),
      child: Scaffold(
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
                              child: Image(
                                  image: AssetImage('assets/pokeball.gif'))),
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
                                    await showSearch<PokemonInfoResponse>(
                                        context: context,
                                        delegate: PokemonSearchDelegate(
                                            BlocProvider.of<PokemonBloc>(
                                                context)));
                                  },
                                  icon: const Icon(Icons.search_outlined))),
                          SizedBox(
                            width: _responsive.widthCustom(0.04),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: _responsive.widthCustom(0.3),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary:
                                  const Color.fromARGB(255, 132, 179, 194)),
                          onPressed: () {
                            Navigator.pushNamed(context, 'gallery');
                          },
                          child: Row(
                            children: const [
                              Text('Libreria'),
                              Icon(Icons.photo_album),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          body: BlocBuilder<PokemonBloc, PokemonState>(
            builder: (context, state) {
              if (state.pokemonRequestStatus == PokemonRequestStatus.loading ||
                  state.pokemonRequestStatus == PokemonRequestStatus.pure) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state.pokemonRequestStatus ==
                  PokemonRequestStatus.successInfo) {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        controller: scrollController,
                        padding: EdgeInsets.all(_responsive.ip * 0.018),
                        itemCount: state.pokemonInfoResponseList.length,
                        itemBuilder: (_, int index) {
                          return CardPokemon(
                              pokemon: state.pokemonInfoResponseList[index]);
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: Text('Error'),
                );
              }
            },
          )),
    );
  }
}
