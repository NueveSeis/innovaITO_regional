import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  static const String name = 'menu';
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int navDrawerIndex = 0;
  @override
  Widget build(BuildContext context) {
    return const NavigationDrawer(
      children: [
        NavigationDrawerDestination(
            icon: Icon(Icons.abc_rounded), label: Text('si')),
        NavigationDrawerDestination(
            icon: Icon(Icons.abc_rounded), label: Text('si'))
      ],
    );
  }
}
