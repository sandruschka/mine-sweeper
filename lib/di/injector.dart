import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:mine_sweeper/di/injector.config.dart';

final getIt = GetIt.instance;

@injectableInit
void configureDependencies() => getIt.init();
