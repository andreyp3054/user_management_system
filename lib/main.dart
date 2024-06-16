import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:user_crud/firebase_options.dart';
import 'package:user_crud/user_crud_app/core/di/environment.dart';
import 'package:user_crud/user_crud_app/core/di/injection_container.dart';
import 'package:user_crud/user_crud_app/domain/presentation/bloc/user_bloc.dart';
import 'package:user_crud/user_crud_app/domain/presentation/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies(environment: dev.name);
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(routes: $appRoutes);
final Future<FirebaseApp> _initializedApp = Firebase.initializeApp(
  options: DefaultFirebaseOptions.web,
);

class MyApp extends StatelessWidget {
  final defaultColor = const Color(0xFF6495ED);

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<UserBloc>(),
      child: FutureBuilder(
        future: _initializedApp,
        builder: (BuildContext context, AsyncSnapshot<FirebaseApp> snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong. Please try again");
          } else if (snapshot.hasData) {
            return DynamicColorBuilder(
              builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
                ColorScheme lightColorScheme;
                ColorScheme darkColorScheme;

                if (lightDynamic != null && darkDynamic != null) {
                  // On Android S+ devices, use the provided dynamic color scheme.
                  // (Recommended) Harmonize the dynamic color scheme' built-in semantic colors.
                  lightColorScheme = lightDynamic.harmonized();
                  darkColorScheme = darkDynamic.harmonized();
                } else {
                  // Otherwise, use fallback schemes.
                  lightColorScheme = ColorScheme.fromSeed(
                    seedColor: defaultColor,
                  );
                  darkColorScheme = ColorScheme.fromSeed(
                    seedColor: defaultColor,
                    brightness: Brightness.dark,
                  );
                }

                return MaterialApp.router(
                  routerConfig: _router,
                  theme: ThemeData.from(
                    colorScheme: lightColorScheme,
                  ),
                  darkTheme: ThemeData.from(
                    colorScheme: darkColorScheme,
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: SizedBox(
                height: 150,
                width: 150,
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
