import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:organizer/utils/constants/app_string_constant.dart';
import 'package:organizer/utils/extensions/context_extension.dart';
import 'package:organizer/utils/extensions/datetime_extension.dart';

class EventListPage extends StatelessWidget {
  const EventListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const EventListView();
  }
}

class EventListView extends StatelessWidget {
  const EventListView({super.key});

  @override
  Widget build(BuildContext context) {
    final _events = List<({String name, DateTime dateTime})>.generate(
      10,
      (index) => (name: "A", dateTime: DateTime.now()),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStringConstant.eventList.appBarTitle,
          style: context.textPalette.headlineLarge.copyWith(
            color: context.colorPalette.invertedText,
          ),
        ),
      ),
      body: ListView.separated(
        itemCount: _events.length,
        separatorBuilder: (context, _) =>
            Divider(height: 1, color: context.colorPalette.divider),
        itemBuilder: (context, index) {
          final event = _events[index];
          return ListTile(
            onTap: () => _onEventPressed(context, id: index),
            title: Text(event.name),
            subtitle: Text(event.dateTime.string),
            trailing: true ? const Icon(Icons.check_circle) : null,
          );
        },
      ),
    );
  }

  void _onEventPressed(BuildContext context, {required int id}) {
    context.pop(id);
  }
}
