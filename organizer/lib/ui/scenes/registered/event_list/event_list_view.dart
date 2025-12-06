import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:organizer/domain/models/event.dart';
import 'package:organizer/domain/repositories/event_repository.dart';
import 'package:organizer/ui/scenes/registered/event_list/bloc/event_list_bloc.dart';
import 'package:organizer/utils/constants/app_string_constant.dart';
import 'package:organizer/utils/extensions/context_extension.dart';
import 'package:organizer/utils/extensions/datetime_extension.dart';

class EventListPage extends StatelessWidget {
  const EventListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          EventListBloc(eventRepository: GetIt.instance<EventRepository>())
            ..add(const EventListSubscriptionRequested()),
      child: const EventListView(),
    );
  }
}

class EventListView extends StatelessWidget {
  const EventListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStringConstant.eventList.appBarTitle,
          style: context.textPalette.headlineLarge.copyWith(
            color: context.colorPalette.invertedText,
          ),
        ),
      ),
      body: BlocBuilder<EventListBloc, EventListState>(
        builder: (context, state) {
          if (state.isLoading && state.events.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == EventListStatus.failure && state.events.isEmpty) {
            return _buildErrorState(
              context,
              onRetry: () => context.read<EventListBloc>().add(
                const EventListSubscriptionRequested(),
              ),
              message:
                  state.errorMessage ??
                  AppStringConstant.genericErrors.tryAgainMessage,
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<EventListBloc>().add(EventListRefreshRequested());
            },
            child: state.events.isEmpty
                ? _buildEmptyState(context)
                : _buildEventList(context, state.events),
          );
        },
      ),
    );
  }
}

Widget _buildEmptyState(BuildContext context) {
  final Size size = MediaQuery.sizeOf(context);
  return ListView(
    physics: const AlwaysScrollableScrollPhysics(),
    padding: const EdgeInsets.symmetric(horizontal: 24),
    children: [
      SizedBox(height: size.height * 0.2),
      Center(
        child: Icon(
          Icons.event_busy,
          size: 48,
          color: context.colorPalette.secondary,
        ),
      ),
      const SizedBox(height: 16),
      Center(
        child: Text(
          'No events available yet.',
          style: context.textPalette.titleMedium.copyWith(
            color: context.colorPalette.text,
          ),
        ),
      ),
      const SizedBox(height: 8),
      Center(
        child: Text(
          'Pull down to refresh once events are assigned.',
          style: context.textPalette.bodyMedium.copyWith(
            color: context.colorPalette.textPlaceholder,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ],
  );
}

Widget _buildErrorState(
  BuildContext context, {
  required VoidCallback onRetry,
  required String message,
}) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error_outline,
            color: context.colorPalette.error,
            size: 48,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: context.textPalette.titleMedium.copyWith(
              color: context.colorPalette.text,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          FilledButton(onPressed: onRetry, child: const Text('Try again')),
        ],
      ),
    ),
  );
}

Widget _buildEventList(BuildContext context, List<Event> events) {
  return ListView.separated(
    physics: const AlwaysScrollableScrollPhysics(),
    itemCount: events.length,
    separatorBuilder: (_, __) =>
        Divider(height: 1, color: context.colorPalette.divider),
    itemBuilder: (context, index) {
      final event = events[index];
      final subtitleWidgets = <Widget>[];
      if (event.startTime != null) {
        subtitleWidgets.add(
          Text(
            event.startTime!.string,
            style: context.textPalette.bodyMedium.copyWith(
              color: context.colorPalette.textPlaceholder,
            ),
          ),
        );
      }

      final locationLabel = event.cityAndCountryLabel;
      if (locationLabel.isNotEmpty) {
        subtitleWidgets.add(
          Text(
            locationLabel,
            style: context.textPalette.bodyMedium.copyWith(
              color: context.colorPalette.textPlaceholder,
            ),
          ),
        );
      }

      return ListTile(
        onTap: () => _onEventSelected(context, event.id),
        title: Text(
          event.title ?? 'Untitled event',
          style: context.textPalette.titleMedium.copyWith(
            color: context.colorPalette.text,
          ),
        ),
        subtitle: subtitleWidgets.isEmpty
            ? null
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [...subtitleWidgets],
              ),
        trailing: const Icon(Icons.chevron_right),
      );
    },
  );
}

void _onEventSelected(BuildContext context, int id) {
  context.pop(id);
}
