// Copyright 2022 Aurelitec. All rights reserved.
// Use of this source code is governed by a user license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import '../common/ui_strings.dart';

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
      title: const Text(UIStrings.home_screenTitle),
      actions: [
        IconButton(
          icon: const Icon(Icons.content_copy_rounded),
          tooltip: UIStrings.home_copyTooltip,
          onPressed: () => onAction(HomeAppBarActions.copy),
        ),
        PopupMenuButton<HomeAppBarActions>(
          onSelected: onAction,
          itemBuilder: (BuildContext context) => <PopupMenuEntry<HomeAppBarActions>>[
            const PopupMenuItem<HomeAppBarActions>(
              value: HomeAppBarActions.share,
              child: Text(UIStrings.home_shareAction),
            ),
            const PopupMenuItem<HomeAppBarActions>(
              value: HomeAppBarActions.uniquenessSearch,
              child: Text(UIStrings.home_uniquenessSearchAction),
            ),
            const PopupMenuDivider(),
            const PopupMenuItem<HomeAppBarActions>(
              value: HomeAppBarActions.settings,
              child: Text(UIStrings.home_settingsAction),
            ),
            const PopupMenuItem<HomeAppBarActions>(
              value: HomeAppBarActions.rate,
              child: Text(UIStrings.home_rateAction),
            ),
            const PopupMenuItem<HomeAppBarActions>(
              value: HomeAppBarActions.help,
              child: Text(UIStrings.home_helpAction),
            ),
            const PopupMenuDivider(),
            const PopupMenuItem<HomeAppBarActions>(
              value: HomeAppBarActions.goPro,
              child: Text(UIStrings.home_goProAction),
            ),
          ],
        ),
      ],
      bottom: TabBar(
        controller: tabController,
        isScrollable: true,
        tabs: UIStrings.home_formatTabs.keys
            .map((format) => Tab(text: UIStrings.home_formatTabs[format]))
            .toList(),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + kTextTabBarHeight);
}
