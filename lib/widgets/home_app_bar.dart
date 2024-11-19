// Copyright 2014-2024 Tecdrop (https://www.tecdrop.com/)
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../common/strings.dart' as strings;

/// The actions available in the app bar.
enum HomeAppBarActions { copy, share, uniquenessSearch, settings, rate, help, goPro }

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
    this.tabController,
    required this.onAction,
  });

  final TabController? tabController;

  /// The callback that is called when an app bar action is pressed.
  final Function(HomeAppBarActions action) onAction;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(strings.homeScreenTitle),
      actions: [
        IconButton(
          icon: const Icon(Icons.content_copy_rounded),
          tooltip: strings.copyTooltip,
          onPressed: () => onAction(HomeAppBarActions.copy),
        ),
        PopupMenuButton<HomeAppBarActions>(
          onSelected: onAction,
          itemBuilder: (BuildContext context) => <PopupMenuEntry<HomeAppBarActions>>[
            const PopupMenuItem<HomeAppBarActions>(
              value: HomeAppBarActions.share,
              child: Text(strings.shareAction),
            ),
            const PopupMenuItem<HomeAppBarActions>(
              value: HomeAppBarActions.uniquenessSearch,
              child: Text(strings.uniquenessSearchAction),
            ),
            const PopupMenuDivider(),
            const PopupMenuItem<HomeAppBarActions>(
              value: HomeAppBarActions.settings,
              child: Text(strings.settingsAction),
            ),
            const PopupMenuItem<HomeAppBarActions>(
              value: HomeAppBarActions.rate,
              child: Text(strings.rateAction),
            ),
            const PopupMenuItem<HomeAppBarActions>(
              value: HomeAppBarActions.help,
              child: Text(strings.helpAction),
            ),
            const PopupMenuDivider(),
            const PopupMenuItem<HomeAppBarActions>(
              value: HomeAppBarActions.goPro,
              child: Text(strings.goProAction),
            ),
          ],
        ),
      ],
      bottom: TabBar(
        controller: tabController,
        isScrollable: true,
        tabs: strings.uuidFormatTabs.keys
            .map((format) => Tab(text: strings.uuidFormatTabs[format]))
            .toList(),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + kTextTabBarHeight);
}
