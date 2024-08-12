import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:user_crud/icons/my_icons.dart';
import 'package:user_crud/user_crud_app/domain/entities/user.dart';
import 'package:user_crud/user_crud_app/domain/presentation/bloc/user_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  uploadData() async {
    Map<String, dynamic> uploadData = {
      "First Name": firstNameCont.text,
      "Last Name": lastNameCont.text,
      "Age": ageCont.text,
    };
  }

  late TextEditingController firstNameCont;
  late TextEditingController lastNameCont;
  late TextEditingController ageCont;

  @override
  void initState() {
    firstNameCont = TextEditingController();
    lastNameCont = TextEditingController();
    ageCont = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    firstNameCont.dispose();
    lastNameCont.dispose();
    ageCont.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("First Name"),
              const Gap(16),
              TextField(
                controller: firstNameCont,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              const Gap(48),
              Text(
                "Last Name",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              const Gap(16),
              TextField(
                controller: lastNameCont,
              ),
              const Gap(48),
              Text(
                "Age",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              const Gap(16),
              TextField(
                controller: ageCont,
              ),
              const Gap(80),
              Center(
                child: TextButton(
                  onPressed: () {
                    final user = User(
                      firstName: firstNameCont.text,
                      lastName: lastNameCont.text,
                      age: int.parse(ageCont.text),
                    );

                    context.read<UserBloc>().add(
                          UserEvent.addUser(user),
                        );
                  },
                  child: Text(
                    "Create Account",
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
