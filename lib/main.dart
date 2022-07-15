import 'package:flutter/material.dart';
import 'package:pokeapi_app/bloc/pokemon_bloc.dart';

import 'package:pokeapi_app/screens/gallery_screen.dart';
import 'package:pokeapi_app/screens/screens.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PokemonBloc>(
          create: (_) => PokemonBloc(),
        )
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: {
        'home': (_) => const HomeScreen(),
        'details': (_) => const DetallesPokemon(),
        'gallery': (_) => const GalleryScreen()
      },
      theme: ThemeData.dark(),
    );
  }
}
