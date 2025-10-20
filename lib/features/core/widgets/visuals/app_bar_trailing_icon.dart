import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:sportying_app/features/core/widgets/scaffolds/side_sheet.dart';
import 'package:sportying_app/features/core/widgets/visuals/list_tile_rounded.dart';

Widget buildAppBarTrailingIcon(BuildContext context) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  return Padding(
    padding: const EdgeInsets.only(right: 8.0),
    child: InkWell(
      borderRadius: BorderRadius.circular(1000),
      onTap: () => showSideSheet(
        context,
        title: 'Account',
        content: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text('My account', style: textTheme.titleMedium),
          ),
          Column(
            children: [
              ListTileRounded(title: 'Edit profile', icon: Symbols.person_rounded, onTap: () {}),
              ListTileRounded(title: 'My payments', icon: Symbols.payments_rounded, onTap: () {}),
              ListTileRounded(title: 'Notifications', icon: Symbols.notifications_rounded, onTap: () {}),
              ListTileRounded(title: 'Settings', icon: Symbols.settings_rounded, onTap: () {}),
            ],
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text('Support', style: textTheme.titleMedium),
          ),
          Column(
            children: [
              ListTileRounded(title: 'Help', icon: Symbols.help_rounded, onTap: () {}),
              ListTileRounded(title: 'FAQ', icon: Symbols.question_mark_rounded, onTap: () {}),
              ListTileRounded(title: 'About this app', icon: Symbols.info_rounded, onTap: () {}),
            ],
          ),
          Divider(),
          ListTileRounded(
            title: 'Sign out',
            icon: Symbols.logout_rounded,
            contentColor: colorScheme.error,
            onTap: () {},
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: const CircleAvatar(
          radius: 16.0,
          // TODO: Replace with user's actual avatar or initials
          child: Icon(Icons.person_rounded, size: 18.0, opticalSize: 18.0),
        ),
      ),
    ),
  );
}
