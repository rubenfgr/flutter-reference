import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/domain/domain.dart';
import 'package:miscelaneos/infraestructure/repositories/pokemons_repository_impl.dart';

final pokemonRepositoryProvider = Provider<PokemonRepository>((ref) {
  return PokemonsRepositoryImpl();
});

final pokemonProvider =
    FutureProvider.family<Pokemon, String>((ref, pokemonId) async {
  final repository = ref.watch(pokemonRepositoryProvider);
  final (pokemon, message) = await repository.getPokemon(pokemonId);
  if (pokemon != null) {
    return pokemon;
  }
  throw message;
});
