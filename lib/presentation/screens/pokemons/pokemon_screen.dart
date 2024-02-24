import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/config/config.dart';
import 'package:miscelaneos/domain/domain.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class PokemonScreen extends ConsumerWidget {
  final String id;

  const PokemonScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, ref) {
    final pokemon = ref.watch(pokemonProvider(id));

    return pokemon.when(
      data: (pokemon) => _PokemonView(pokemon: pokemon),
      loading: () => const _LoadingView(),
      error: (error, stackTrace) => _ErrorView(message: error.toString()),
    );
  }
}

class _PokemonView extends StatelessWidget {
  final Pokemon pokemon;

  const _PokemonView({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(pokemon.name),
          actions: [
            IconButton(
              icon: const Icon(Icons.share_outlined),
              onPressed: () {
                SharePlugin.shareLink(
                    'https://flutter-deep-linking-website-g7un.onrender.com/pokemons/${pokemon.id}/',
                    'Mira este pokemon!');
              },
            )
          ],
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                pokemon.spriteFront,
                fit: BoxFit.contain,
              ),
              Text(pokemon.name,
                  style: const TextStyle(
                      fontSize: 24,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ));
  }
}

class _ErrorView extends StatelessWidget {
  final String message;

  const _ErrorView({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: Center(
        child: Text(message),
      ),
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loading'),
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
