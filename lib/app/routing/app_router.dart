import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:repair_parts_finder/app/routing/app_destination.dart';
import 'package:repair_parts_finder/presentation/screens/catalog_screen.dart';
import 'package:repair_parts_finder/presentation/screens/favorites_screen.dart';
import 'package:repair_parts_finder/presentation/screens/history_screen.dart';
import 'package:repair_parts_finder/presentation/screens/search_screen.dart';
import 'package:repair_parts_finder/presentation/screens/settings_screen.dart';
import 'package:repair_parts_finder/presentation/screens/suppliers_screen.dart';
import 'package:repair_parts_finder/presentation/widgets/app_shell.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

GoRouter buildAppRouter() {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppDestination.search.path,
    routes: [
      GoRoute(
        path: '/',
        redirect: (context, state) => AppDestination.search.path,
      ),
      ShellRoute(
        builder: (context, state, child) => AppShell(
          selectedDestination: AppDestination.fromPath(state.uri.path),
          child: child,
        ),
        routes: [
          GoRoute(
            path: AppDestination.search.path,
            pageBuilder: (context, state) =>
                _sectionPage(state, const SearchScreen()),
          ),
          GoRoute(
            path: AppDestination.catalog.path,
            pageBuilder: (context, state) =>
                _sectionPage(state, const CatalogScreen()),
          ),
          GoRoute(
            path: AppDestination.suppliers.path,
            pageBuilder: (context, state) =>
                _sectionPage(state, const SuppliersScreen()),
          ),
          GoRoute(
            path: AppDestination.history.path,
            pageBuilder: (context, state) =>
                _sectionPage(state, const HistoryScreen()),
          ),
          GoRoute(
            path: AppDestination.favorites.path,
            pageBuilder: (context, state) =>
                _sectionPage(state, const FavoritesScreen()),
          ),
          GoRoute(
            path: AppDestination.settings.path,
            pageBuilder: (context, state) =>
                _sectionPage(state, const SettingsScreen()),
          ),
        ],
      ),
    ],
  );
}

Page<void> _sectionPage(GoRouterState state, Widget child) {
  return NoTransitionPage<void>(key: state.pageKey, child: child);
}
