// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;

import 'game.dart' as _i2;
import 'game/mine_sweeper_game.dart' as _i5;
import 'menu/menu.dart' as _i1;

class AppRouter extends _i3.RootStackRouter {
  AppRouter([_i4.GlobalKey<_i4.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    Menu.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.Menu(),
      );
    },
    Game.name: (routeData) {
      final args = routeData.argsAs<GameArgs>();
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i2.Game(
          gameDifficulty: args.gameDifficulty,
          key: args.key,
        ),
      );
    },
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig(
          Menu.name,
          path: '/',
        ),
        _i3.RouteConfig(
          Game.name,
          path: '/Game',
        ),
      ];
}

/// generated route for
/// [_i1.Menu]
class Menu extends _i3.PageRouteInfo<void> {
  const Menu()
      : super(
          Menu.name,
          path: '/',
        );

  static const String name = 'Menu';
}

/// generated route for
/// [_i2.Game]
class Game extends _i3.PageRouteInfo<GameArgs> {
  Game({
    required _i5.GameDifficulty gameDifficulty,
    _i4.Key? key,
  }) : super(
          Game.name,
          path: '/Game',
          args: GameArgs(
            gameDifficulty: gameDifficulty,
            key: key,
          ),
        );

  static const String name = 'Game';
}

class GameArgs {
  const GameArgs({
    required this.gameDifficulty,
    this.key,
  });

  final _i5.GameDifficulty gameDifficulty;

  final _i4.Key? key;

  @override
  String toString() {
    return 'GameArgs{gameDifficulty: $gameDifficulty, key: $key}';
  }
}
