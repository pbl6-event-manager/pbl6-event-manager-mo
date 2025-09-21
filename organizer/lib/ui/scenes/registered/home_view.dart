import 'package:flutter/material.dart';
import 'package:organizer/application/bloc/auth_bloc.dart';
import 'package:organizer/utils/extensions/context_extension.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeView();
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FilledButton(
          onPressed: () {
            context.authBloc.add(AuthTokenRemoved());
          },
          child: Text("Log out"),
        ),
      ),
    );
  }
}
