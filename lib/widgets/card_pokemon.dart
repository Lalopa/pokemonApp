import 'package:flutter/material.dart';
import 'package:pokeapi_app/models/pokemon_info_response.dart';
import 'package:pokeapi_app/widgets/custom_text.dart';

import '../utils/responsive.dart';

class CardPokemon extends StatelessWidget {
  const CardPokemon({Key? key, required this.pokemon}) : super(key: key);
  final PokemonInfoResponse pokemon;

  @override
  Widget build(BuildContext context) {
    final _responsive = Responsive(context);

    return GestureDetector(
      onTap: (() =>
          Navigator.pushNamed(context, 'details', arguments: pokemon)),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: pokemon.color,
            image: const DecorationImage(
                image: AssetImage('assets/pokeballView.png'),
                fit: BoxFit.cover,
                opacity: 0.2)),
        //color: colorFondo,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          children: [
            FadeInImage(
              placeholder: const AssetImage('assets/pokeball-loading.gif'),
              image: NetworkImage(pokemon.sprites.frontDefault, scale: 3),
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
                CustomText(
                  text: '# ' + pokemon.id.toString() + ' : ',
                  fontSize: 22,
                ),
                SizedBox(
                  height: _responsive.heightCustom(0.02),
                ),
                CustomText(text: pokemon.name.toUpperCase(), fontSize: 22),
                SizedBox(
                  height: _responsive.heightCustom(0.02),
                ),
                CustomText(
                  text: 'Tipo: ' +
                      pokemon.tipoPokemon![0].toUpperCase() +
                      pokemon.tipoPokemon!.substring(1),
                  fontSize: 18,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
