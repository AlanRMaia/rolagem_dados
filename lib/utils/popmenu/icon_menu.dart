import 'package:flutter/material.dart';

class IconsMenu {
  static const items = <IconMenu>[
    favorito,
    excluir,
    compartilhar,
    editar,
  ];

  static const favorito = IconMenu(
    text: 'Favorito',
    icon: Icons.favorite,
  );

  static const editar = IconMenu(
    text: 'Editar',
    icon: Icons.edit,
  );

  static const excluir = IconMenu(
    text: 'Excluir',
    icon: Icons.delete_forever,
  );

  static const compartilhar = IconMenu(
    text: 'Compartilhar',
    icon: Icons.share,
  );
}

class IconMenu {
  final String text;
  final IconData icon;

  const IconMenu({
    @required this.text,
    @required this.icon,
  });
}
