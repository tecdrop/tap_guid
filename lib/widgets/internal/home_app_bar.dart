// Copyright 2020-2025 Tecdrop SRL. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be found
// in the LICENSE file or at https://www.tecdrop.com/tapguid/license/.

import 'package:flutter/material.dart';

import '../../common/strings.dart' as strings;

/// The actions available in the app bar of the home screen.
enum HomeAppBarActions { copy, share, copyColor, uniquenessSearch }

/// The app bar for the home screen.
class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key, this.tabController, required this.onAction});

  /// The tab controller for the UUID format tabs.
  final TabController? tabController;

  /// The callback that is called when an app bar action is pressed.
  final Function(HomeAppBarActions action) onAction;

  @override
  Widget build(BuildContext context) {
    final bool isLargeScreen = MediaQuery.sizeOf(context).width > 600.0;
    return AppBar(
      title:
          isLargeScreen
              ? const Text(strings.homeScreenTitle)
              : const Text(strings.homeScreenTitleShort),
      actions: <Widget>[
        // The copy action button
        IconButton(
          icon: const Icon(Icons.content_copy_rounded),
          tooltip: strings.copyTooltip,
          onPressed: () => onAction(HomeAppBarActions.copy),
        ),
        // The Share action button
        IconButton(
          icon: const Icon(Icons.share_rounded),
          tooltip: strings.shareTooltip,
          onPressed: () => onAction(HomeAppBarActions.share),
        ),

        PopupMenuButton<HomeAppBarActions>(
          onSelected: onAction,
          itemBuilder:
              (BuildContext context) => <PopupMenuEntry<HomeAppBarActions>>[
                // The Copy color menu item
                const PopupMenuItem<HomeAppBarActions>(
                  value: HomeAppBarActions.copyColor,
                  child: Text(strings.copyColorAction),
                ),

                // The Uniqueness Search action button
                const PopupMenuItem<HomeAppBarActions>(
                  value: HomeAppBarActions.uniquenessSearch,
                  child: Text(strings.uniquenessSearchAction),
                ),
              ],
        ),
      ],
      // The UUID format tabs
      bottom: TabBar(
        controller: tabController,
        isScrollable: true,
        tabs:
            strings.uuidFormatTabs.keys
                .map((format) => Tab(text: strings.uuidFormatTabs[format]))
                .toList(),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + kTextTabBarHeight);
}
