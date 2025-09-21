import "package:attendee/application/bloc/auth_bloc.dart";
import "package:attendee/utils/extensions/context_extension.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

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
      appBar: AppBar(
        title: Text("Home", style: context.textPalette.titleLarge),
        actions: [
          IconButton(
            onPressed: () {
              // Logout functionality
              context.read<AuthBloc>().add(const AuthTokenRemoved());
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome to Event Manager!",
              style: context.textPalette.headlineLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              "You are successfully authenticated.",
              style: context.textPalette.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                context.read<AuthBloc>().add(const AuthTokenRemoved());
              },
              child: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
