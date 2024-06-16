import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:user_crud/user_crud_app/core/di/injection_container.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
FutureOr<void> configureDependencies({String? environment}) =>
    getIt.init(environment: environment);
