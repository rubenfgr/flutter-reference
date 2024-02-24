import 'package:miscelaneos/domain/entities/pokemon.dart';

abstract class PokemonRepository {
  Future<(Pokemon?, String)> getPokemon(String id);
}
