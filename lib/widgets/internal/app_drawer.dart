// Copyright 2020-2025 Tecdrop SRL. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be found
// in the LICENSE file or at https://www.tecdrop.com/tapguid/license/.

import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../common/custom_icons.dart' as custom_icons;
import '../../common/strings.dart' as strings;
import '../../utils/color_utils.dart' as color_utils;

/// The items that appear in the app drawer.
enum AppDrawerItems { pbwp, rcwp, guidGenerator, settings, help, openSource, rateApp }

/// The main Material Design drawer of the app, with the app screens and app urls.
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key, required this.headerColor, this.onItemTap});

  /// The background color of the app drawer header.
  final Color headerColor;

  /// Called when an item in the drawer is tapped.
  final void Function(AppDrawerItems item)? onItemTap;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          // The app drawer header with a bottom margin
          _AppDrawerHeader(color: headerColor),
          const SizedBox(height: 16.0),

          // The "Support our free apps" section
          if (Platform.isAndroid || kIsWeb) ...[
            ListTile(
              style: ListTileStyle.drawer,
              title: Text(strings.supportOurAppsDrawerItem),
              titleTextStyle: Theme.of(context).textTheme.titleSmall,
              visualDensity: VisualDensity.compact,
            ),
            _buildItem(
              context,
              icon: Icons.loyalty_outlined,
              title: strings.pbwpDrawerItem,
              item: AppDrawerItems.pbwp,
            ),
            _buildItem(
              context,
              icon: Icons.loyalty_outlined,
              title: strings.rcwpDrawerItem,
              item: AppDrawerItems.rcwp,
            ),
            const Divider(),
          ],

          // Generate GUIDs/UUIDs drawer item (the home screen)
          _buildItem(
            context,
            icon: Icons.home_outlined,
            title: strings.guidGeneratorDrawerItem,
            item: AppDrawerItems.guidGenerator,
          ),

          // Settings drawer item
          _buildItem(
            context,
            icon: Icons.settings_outlined,
            title: strings.settingsDrawerItem,
            item: AppDrawerItems.settings,
          ),

          const Divider(),

          // Help & Support drawer item
          _buildItem(
            context,
            icon: Icons.support_outlined,
            title: strings.helpDrawerItem,
            item: AppDrawerItems.help,
          ),

          // The open-source drawer item
          _buildItem(
            context,
            icon: custom_icons.github,
            title: strings.openSourceDrawerItem,
            subtitle: strings.openSourceDrawerItemSubtitle,
            item: AppDrawerItems.openSource,
          ),

          // Rate App drawer item
          _buildItem(
            context,
            icon: Icons.star_rate,
            title: strings.rateAppDrawerItem,
            item: AppDrawerItems.rateApp,
          ),
        ],
      ),
    );
  }

  /// Creates an app drawer item, with an optional [icon], a [title], and an optional [subtitle].
  Widget _buildItem(
    BuildContext context, {
    IconData? icon,
    required String title,
    String? subtitle,
    required AppDrawerItems item,
    bool selected = false,
  }) {
    return ListTile(
      leading: icon != null ? Icon(icon) : null,
      onTap: () => onItemTap?.call(item),
      selected: selected,
      style: ListTileStyle.drawer,
      subtitle: subtitle != null ? Text(subtitle) : null,
      title: Text(title),
    );
  }
}

/// The app drawer header.
///
/// It is filled with a background color, and displays the app name.
class _AppDrawerHeader extends StatelessWidget {
  const _AppDrawerHeader({
    super.key, // ignore: unused_element_parameter
    required this.color,
  });

  /// The color to fill in the background of the drawer header.
  final Color color;

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(color: color),
      child: Center(
        child: Text(
          strings.appName,
          style: Theme.of(
            context,
          ).textTheme.headlineMedium!.copyWith(color: color_utils.contrastColor(color)),
        ),
      ),
    );
  }
}
