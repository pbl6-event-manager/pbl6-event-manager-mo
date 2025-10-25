import "package:attendee/domain/models/user.dart";
import "package:flutter/material.dart";

class AccountSettingPage extends StatelessWidget {
  const AccountSettingPage({super.key, required this.user});
  final User? user;

  @override
  Widget build(BuildContext context) {
    return const AccountSettingView();
  }
}

class AccountSettingView extends StatelessWidget {
  const AccountSettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Text("hello"));
  }
}
