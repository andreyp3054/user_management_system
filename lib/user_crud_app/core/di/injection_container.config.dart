// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart'
    as _i3;

import '../../data/api_service/user_api_service.dart' as _i4;
import '../../data/api_service/user_api_service_impl.dart' as _i5;
import '../../data/datasources/user_remote_data_source.dart' as _i6;
import '../../data/datasources/user_remote_data_source_impl.dart' as _i7;
import '../../data/repositories/user_repository_impl.dart' as _i10;
import '../../domain/presentation/bloc/user_bloc.dart' as _i14;
import '../../domain/repositories/user_repository.dart' as _i9;
import '../../domain/usecases/add_user.dart' as _i12;
import '../../domain/usecases/delete_user.dart' as _i13;
import '../../domain/usecases/get_users.dart' as _i11;
import '../network/network_info.dart' as _i8;
import '../network/network_info_module.dart' as _i15;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final networkInfoModule = _$NetworkInfoModule();
    gh.singleton<_i3.InternetConnection>(
        () => networkInfoModule.internetConnectionChecker);
    gh.singleton<_i4.UserApiService>(() => _i5.UserApiServiceImpl());
    gh.singleton<_i6.UserRemoteDataSource>(
        () => _i7.UserRemoteDataSourceImpl(gh<_i4.UserApiService>()));
    gh.singleton<_i8.NetworkInfo>(
        () => _i8.NetworkInfoImpl(gh<_i3.InternetConnection>()));
    gh.singleton<_i9.UserRepository>(() => _i10.UserRepositoryImpl(
          gh<_i8.NetworkInfo>(),
          gh<_i6.UserRemoteDataSource>(),
        ));
    gh.factory<_i11.GetUsers>(() => _i11.GetUsers(gh<_i9.UserRepository>()));
    gh.factory<_i12.AddUser>(() => _i12.AddUser(gh<_i9.UserRepository>()));
    gh.factory<_i13.DeleteUser>(
        () => _i13.DeleteUser(gh<_i9.UserRepository>()));
    gh.factory<_i14.UserBloc>(() => _i14.UserBloc(add: gh<_i12.AddUser>()));
    return this;
  }
}

class _$NetworkInfoModule extends _i15.NetworkInfoModule {
  @override
  _i3.InternetConnection get internetConnectionChecker =>
      _i3.InternetConnection();
}
