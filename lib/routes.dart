import 'package:auto_route/annotations.dart';
import 'package:mine_sweeper/game.dart';
import 'package:mine_sweeper/menu/menu.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: Menu, initial: true),
    AutoRoute(page: Game),
  ],
)
class $AppRouter {}
