import 'package:freezed_annotation/freezed_annotation.dart';

import '../error/failures.dart';
import '../result/result.dart';

part 'usecase.freezed.dart';

abstract class UseCase<Type, Params> {
  Future<Result<Type, Failure>> call(Params params);
}

class NoReturn {
  static final NoReturn _singleton = NoReturn._internal();

  factory NoReturn() {
    return _singleton;
  }

  NoReturn._internal();
}

@freezed
class NoParams with _$NoParams {
  const factory NoParams() = _NoParams;
}
