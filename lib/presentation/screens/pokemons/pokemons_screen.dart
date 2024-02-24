import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class PokemonsScreen extends StatelessWidget {
  const PokemonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: PokemonsView());
  }
}

class PokemonsView extends ConsumerStatefulWidget {
  const PokemonsView({super.key});

  @override
  _PokemonsViewState createState() => _PokemonsViewState();
}

class _PokemonsViewState extends ConsumerState<PokemonsView> {
  final _scrollController = ScrollController();

  void infiniteScroll() {
    final currentPokemonIds = ref.read(pokemonIdsProvider);

    if (currentPokemonIds.length < 20) {
      _scrollController.removeListener(infiniteScroll);
      return;
    }

    if (_scrollController.position.pixels + 200 >
        _scrollController.position.maxScrollExtent) {
      ref.read(pokemonIdsProvider.notifier).update((state) => [
            ...state,
            ...List.generate(30, (index) => state.length + index + 1)
          ]);
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(infiniteScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverAppBar(
          title: const Text('Pokemons'),
          floating: true,
          snap: true,
          backgroundColor: Colors.white.withOpacity(0.8),
        ),
        const _PokemonsGrid(),
      ],
    );
  }
}

class _PokemonsGrid extends ConsumerWidget {
  const _PokemonsGrid({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final pokemonIds = ref.watch(pokemonIdsProvider);

    return SliverGrid.builder(
      itemCount: pokemonIds.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemBuilder: (context, index) {
        return _PokemonCard(id: (++index).toString());
      },
    );
  }
}

class _PokemonCard extends StatelessWidget {
  final String id;

  const _PokemonCard({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push('/pokemons/$id');
      },
      child: Column(
        children: [
          Image.network(
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png',
            fit: BoxFit.contain,
          ),
          Text('Pokemon $id'),
        ],
      ),
    );
  }
}
