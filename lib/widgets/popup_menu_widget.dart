import 'package:economiza_sc/stores/auth_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CustomPopUpMenu extends StatefulWidget {
  const CustomPopUpMenu({super.key});

  @override
  State<CustomPopUpMenu> createState() => _CustomPopUpMenuState();
}

class _CustomPopUpMenuState extends State<CustomPopUpMenu> {
  final _authStore = Modular.get<AuthStore>();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(
        Icons.person,
        color: Theme.of(context).iconTheme.color,
      ),
      color: Colors.white,
      splashRadius: 20.0,
      tooltip: 'Menu',
      position: PopupMenuPosition.under,
      itemBuilder: (context) => <PopupMenuEntry<Widget>>[
        PopupMenuItem(child: const Text('Logout'), onTap: () => _authStore.logout()),
      ],
    );
  }
}
