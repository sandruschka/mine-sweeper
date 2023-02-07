import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mine_sweeper/game/bloc/game_bloc.dart';
import 'package:mine_sweeper/game/bloc/timer/timer_bloc.dart';
import 'package:mine_sweeper/routes.gr.dart';
import 'package:mine_sweeper/theme/theme_data.dart';

void main() {
  runApp(
    MediaQuery(
      data: const MediaQueryData(),
      child: MaterialApp(
        home: GamePage(),
      ),
    ),
  );
}

class GamePage extends StatelessWidget {
  GamePage({Key? key}) : super(key: key);

  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GameBloc>(create: (_) => GameBloc()),
        BlocProvider<TimerBloc>(create: (_) => TimerBloc()),
      ],
      child: Builder(builder: (context) {
        return MaterialApp.router(
          theme: MineSweeperTheme().themeData,
          routerDelegate: _appRouter.delegate(),
          routeInformationParser: _appRouter.defaultRouteParser(),
        );
      }),
    );
  }
}
