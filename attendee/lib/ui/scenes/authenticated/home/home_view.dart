import "package:attendee/application/bloc/auth_bloc.dart";
import "package:attendee/ui/common_widgets/event_widget.dart";
import "package:attendee/utils/constants/ui_constants.dart";
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
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: UIConstants.horizontalPadding,
          ),
          child: ListView(
            children: [
              EventWidget(),
              SizedBox(height: 40),
              EventWidget.compact(),
            ],
          ),
        ),
      ),
    );
  }
}
