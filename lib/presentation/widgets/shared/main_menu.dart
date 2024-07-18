import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuItem {
  final String title;
  final IconData icon;
  final String route;

  MenuItem({required this.title, required this.icon, required this.route});
}

final menuItems = <MenuItem>[
  MenuItem(title: 'Giróscopio', icon: Icons.downloading, route: '/gyroscope'),
  MenuItem(title: 'Acelerómetro', icon: Icons.speed, route: '/accelerometer'),
  MenuItem(
      title: 'Magnetómetro',
      icon: Icons.explore_outlined,
      route: '/magnetometer'),
  MenuItem(
      title: 'Giróscopio Ball',
      icon: Icons.sports_baseball_outlined,
      route: '/gyroscope-ball'),
  MenuItem(title: 'Brújula', icon: Icons.explore, route: '/compass'),
  MenuItem(
      title: 'Pokemons',
      icon: Icons.catching_pokemon_rounded,
      route: '/pokemons'),
  MenuItem(title: 'Biométricos', icon: Icons.explore, route: '/biometricos'),
  MenuItem(title: 'Ubicación', icon: Icons.explore, route: '/location'),
  MenuItem(title: 'Mapas', icon: Icons.explore, route: '/maps'),
  MenuItem(title: 'Controlado', icon: Icons.explore, route: '/controlled-map'),
];

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.count(
      crossAxisCount: 3,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: menuItems
          .map(
            (item) => MainMenuItem(
                title: item.title, route: item.route, icon: item.icon),
          )
          .toList(),
    );
  }
}

class MainMenuItem extends StatelessWidget {
  final String title;
  final String route;
  final IconData icon;
  final List<Color> bgColors;

  const MainMenuItem(
      {super.key,
      required this.title,
      required this.route,
      required this.icon,
      this.bgColors = const [Colors.lightBlue, Colors.blueGrey]});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            gradient: RadialGradient(
              center: AlignmentDirectional.center,
              radius: 1.5,
              colors: bgColors,
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.blueGrey,
                blurRadius: 2,
                offset: Offset(1, 1),
              ),
            ]),
        child: InkWell(
          onTap: () {
            context.push(route);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 50, color: Colors.white),
              const SizedBox(height: 10),
              Text(title,
                  style: GoogleFonts.roboto(color: Colors.white, fontSize: 12)),
            ],
          ),
        ));
  }
}
