import 'package:dio/dio.dart';
import 'package:miscelaneos/domain/domain.dart';
import 'package:miscelaneos/infraestructure/mappers/pokemon_mapper.dart';

class PokemonsDatasourceImpl implements PokemonsDatasource {
  final Dio _dio;

  PokemonsDatasourceImpl()
      : _dio = Dio(BaseOptions(
          baseUrl: 'https://pokeapi.co/api/v2/',
        ));

  @override
  Future<(Pokemon?, String)> getPokemon(String id) async {
    try {
      final response = await _dio.get('pokemon/$id');
      final pokemon = PokemonMapper.pokeApiPokemonToEntity(response.data);

      return (pokemon, 'Pokemon ${pokemon.name} obtenido correctamente');
    } catch (e) {
      return (null, 'No se pudo obtener el pokemon $e');
    }
  }
}
