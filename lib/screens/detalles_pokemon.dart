import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokeapi_app/models/models.dart';
import 'package:pokeapi_app/widgets/custom_text.dart';

import '../utils/responsive.dart';

class DetallesPokemon extends StatelessWidget {
  const DetallesPokemon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PokemonInfoResponse pokemon =
        ModalRoute.of(context)!.settings.arguments as PokemonInfoResponse;
    //print(pokemon.name);
    final _responsive = Responsive(context);
    final String imgenPokemon = pokemon.sprites.other.dreamWorld.frontDefault;

    return Scaffold(
      backgroundColor: pokemon.color,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pop(context),
        label: const Text('Regresar'),
        icon: const Icon(Icons.arrow_back),
        backgroundColor: pokemon.color,
      ),
      appBar: PreferredSize(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.network(
              imgenPokemon,
              height: _responsive.heightCustom(0.2),
              width: _responsive.widthCustom(0.2),
              placeholderBuilder: (_) =>
                  const Image(image: AssetImage('assets/pokeball-loading.gif')),
            ),
            SizedBox(
              height: _responsive.heightCustom(0.02),
            ),
            AnimatedTextKit(
              totalRepeatCount: 1,
              animatedTexts: [
                WavyAnimatedText(pokemon.name.toUpperCase(),
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black38))
              ],
            ),
            SizedBox(
              height: _responsive.heightCustom(0.02),
            ),
            Center(
              child: Text(
                pokemon.tipoPokemon!.toUpperCase(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 0.5
                    ..color = Colors.black,
                ),
              ),
            )
          ],
        ),
        preferredSize: Size.fromHeight(
            _responsive.height - _responsive.heightCustom(0.68)),
      ),
      body: SizedBox(
        width: _responsive.width,
        child: Hero(
          tag: 'card',
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/pokeball_background.png'),
                    fit: BoxFit.contain)),
            child: Card(
              color: const Color.fromARGB(195, 178, 226, 242),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              child: Column(
                children: [
                  SizedBox(height: _responsive.heightCustom(0.04)),
                  const Text(
                    'Informacion del Pokemon',
                    style: TextStyle(fontSize: 25, color: Colors.black87),
                  ),
                  SizedBox(
                    height: _responsive.heightCustom(0.05),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Expanded(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(
                              width: _responsive.widthCustom(0.2),
                              child: const CustomText(
                                text: 'HP: ',
                                fontSize: 14,
                              ),
                            ),
                            Container(
                                width: _responsive.widthCustom(0.4),
                                alignment: Alignment.topCenter,
                                margin: const EdgeInsets.all(20),
                                child: LinearProgressIndicator(
                                  value: pokemon.stats[0].baseStat / 100,
                                  backgroundColor:
                                      const Color.fromRGBO(80, 189, 212, 83),
                                  color: const Color.fromRGBO(77, 82, 201, 79),
                                  minHeight: 10,
                                )),
                            CustomText(
                              text: pokemon.stats[0].baseStat.toString(),
                              fontSize: 14,
                            )
                          ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Expanded(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: _responsive.widthCustom(0.2),
                              child: const CustomText(
                                text: 'Ataque: ',
                                fontSize: 14,
                              ),
                            ),
                            Container(
                                width: _responsive.widthCustom(0.4),
                                alignment: Alignment.topCenter,
                                margin: const EdgeInsets.all(20),
                                child: LinearProgressIndicator(
                                  value: pokemon.stats[1].baseStat / 100,
                                  backgroundColor:
                                      const Color.fromRGBO(80, 189, 212, 83),
                                  color: const Color.fromRGBO(77, 82, 201, 79),
                                  minHeight: 10,
                                )),
                            CustomText(
                              text: pokemon.stats[1].baseStat.toString(),
                              fontSize: 14,
                            )
                          ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Expanded(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: _responsive.widthCustom(0.2),
                              child: const CustomText(
                                text: 'Defensa: ',
                                fontSize: 14,
                              ),
                            ),
                            Container(
                                width: _responsive.widthCustom(0.4),
                                alignment: Alignment.topCenter,
                                margin: const EdgeInsets.all(20),
                                child: LinearProgressIndicator(
                                  value: pokemon.stats[2].baseStat / 100,
                                  backgroundColor:
                                      const Color.fromRGBO(80, 189, 212, 83),
                                  color: const Color.fromRGBO(77, 82, 201, 79),
                                  minHeight: 10,
                                )),
                            CustomText(
                              text: pokemon.stats[2].baseStat.toString(),
                              fontSize: 14,
                            )
                          ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Expanded(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: _responsive.widthCustom(0.2),
                              child: const CustomText(
                                text: 'Ataq Esp: ',
                                fontSize: 14,
                              ),
                            ),
                            Container(
                                width: _responsive.widthCustom(0.4),
                                alignment: Alignment.topCenter,
                                margin: const EdgeInsets.all(20),
                                child: LinearProgressIndicator(
                                  value: pokemon.stats[3].baseStat / 100,
                                  backgroundColor:
                                      const Color.fromRGBO(80, 189, 212, 83),
                                  color: const Color.fromRGBO(77, 82, 201, 79),
                                  minHeight: 10,
                                )),
                            CustomText(
                              text: pokemon.stats[3].baseStat.toString(),
                              fontSize: 14,
                            )
                          ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Expanded(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: _responsive.widthCustom(0.2),
                              child: const CustomText(
                                text: 'Def Esp: ',
                                fontSize: 14,
                              ),
                            ),
                            Container(
                                width: _responsive.widthCustom(0.4),
                                alignment: Alignment.topCenter,
                                margin: const EdgeInsets.all(20),
                                child: LinearProgressIndicator(
                                  value: pokemon.stats[4].baseStat / 100,
                                  backgroundColor:
                                      const Color.fromRGBO(80, 189, 212, 83),
                                  color: const Color.fromRGBO(77, 82, 201, 79),
                                  minHeight: 10,
                                )),
                            CustomText(
                              text: pokemon.stats[4].baseStat.toString(),
                              fontSize: 14,
                            )
                          ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Expanded(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: _responsive.widthCustom(0.2),
                              child: const CustomText(
                                text: 'Velocidad',
                                fontSize: 14,
                              ),
                            ),
                            Container(
                                width: _responsive.widthCustom(0.4),
                                alignment: Alignment.topCenter,
                                margin: const EdgeInsets.all(20),
                                child: LinearProgressIndicator(
                                  value: pokemon.stats[5].baseStat / 100,
                                  backgroundColor:
                                      const Color.fromRGBO(80, 189, 212, 83),
                                  color: const Color.fromRGBO(77, 82, 201, 79),
                                  minHeight: 10,
                                )),
                            CustomText(
                              text: pokemon.stats[5].baseStat.toString(),
                              fontSize: 14,
                            )
                          ]),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
