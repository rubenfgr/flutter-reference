import 'package:miscelaneos/domain/domain.dart';
import 'package:miscelaneos/infraestructure/datasources/pokemons_datasource_impl.dart';

class PokemonsRepositoryImpl implements PokemonRepository {
  final PokemonsDatasource _datasource;

  PokemonsRepositoryImpl({PokemonsDatasource? datasource})
      : _datasource = datasource ?? PokemonsDatasourceImpl();

  @override
  Future<(Pokemon?, String)> getPokemon(String id) async {
    return await _datasource.getPokemon(id);
  }
}
