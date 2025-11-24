import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:sportying_app/features/core/widgets/scaffolds/custom_expandable_list_tile.dart';

class EndDrawer extends StatefulWidget {
  const EndDrawer({super.key});

  @override
  State<EndDrawer> createState() => _EndDrawerState();
}

class _EndDrawerState extends State<EndDrawer> {
  int _expandedIndex = -1;

  void _handleExpansion(int index) {
    setState(() {
      _expandedIndex = _expandedIndex == index ? -1 : index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final brightness = Theme.brightnessOf(context);

    return SafeArea(
      child: Drawer(
        backgroundColor: colorScheme.surface,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
              color: colorScheme.primaryContainer,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: colorScheme.primary,
                    child: const Text(
                      'JD',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 4.0,
                      children: [
                        Text('John Doe', style: textTheme.headlineSmall?.copyWith(color: colorScheme.onSurface)),
                        Text(
                          'john.doe@example.com',
                          style: textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  CustomExpansionTile(
                    backgroundColor: brightness == Brightness.light
                        ? colorScheme.surfaceContainerLowest
                        : colorScheme.surfaceContainerHigh,
                    textColor: colorScheme.onSurface,
                    iconColor: colorScheme.onSurface,
                    separatorColor: colorScheme.surface,
                    isExpanded: _expandedIndex == 0,
                    onExpansionChanged: (expanded) => _handleExpansion(0),
                    leading: Symbols.person_rounded,
                    title: 'Account',
                    children: [
                      CustomExpandableListTile(icon: Symbols.edit_rounded, label: 'Edit profile', onTap: () {}),
                      CustomExpandableListTile(icon: Symbols.payments_rounded, label: 'My payments', onTap: () {}),
                      CustomExpandableListTile(
                        icon: Symbols.notifications_rounded,
                        label: 'Notifications',
                        onTap: () {},
                      ),
                      CustomExpandableListTile(icon: Symbols.settings_rounded, label: 'Settings', onTap: () {}),
                    ],
                  ),
                  const SizedBox(height: 8),
                  CustomExpansionTile(
                    backgroundColor: brightness == Brightness.light
                        ? colorScheme.surfaceContainerLowest
                        : colorScheme.surfaceContainerHigh,
                    textColor: colorScheme.onSurface,
                    iconColor: colorScheme.onSurface,
                    separatorColor: colorScheme.surface,
                    isExpanded: _expandedIndex == 1,
                    onExpansionChanged: (expanded) => _handleExpansion(1),
                    leading: Symbols.help_rounded,
                    title: 'Support',
                    children: [
                      CustomExpandableListTile(icon: Symbols.support_agent_rounded, label: 'Help', onTap: () {}),
                      CustomExpandableListTile(icon: Symbols.question_answer_rounded, label: 'FAQ', onTap: () {}),
                      CustomExpandableListTile(icon: Symbols.info_rounded, label: 'About this app', onTap: () {}),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Material(
                    color: brightness == Brightness.light
                        ? colorScheme.surfaceContainerLowest
                        : colorScheme.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(32.0),
                    clipBehavior: Clip.antiAlias,
                    child: ListTile(
                      leading: Icon(
                        Symbols.logout_rounded,
                        size: 24,
                        fill: 1,
                        weight: 400,
                        grade: 0,
                        opticalSize: 24,
                        color: colorScheme.error,
                      ),
                      title: Text('Sign out', style: textTheme.bodyLarge?.copyWith(color: colorScheme.error)),
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
