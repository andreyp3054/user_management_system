import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:user_crud/user_crud_app/domain/presentation/screens/home_screen.dart';
import 'package:user_crud/user_crud_app/domain/presentation/screens/profile_screen.dart';

part 'routes.g.dart';

@TypedGoRoute<HomeScreenRoute>(
  path: '/',
  routes: [
    TypedGoRoute<ProfileScreenRoute>(
      path: 'profile',
    )
  ],
)
@immutable
class HomeScreenRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomeScreen();
  }
}

@immutable
class ProfileScreenRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ProfileScreen();
  }
}
