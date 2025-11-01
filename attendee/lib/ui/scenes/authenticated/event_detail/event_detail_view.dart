import 'package:attendee/domain/models/event.dart';
import 'package:attendee/domain/models/organizer.dart';
import 'package:attendee/ui/common_widgets/error_page.dart';
import 'package:attendee/ui/common_widgets/event_widget.dart';
import 'package:attendee/ui/scenes/authenticated/event_detail/event_detail_general_info_widget.dart';
import 'package:attendee/ui/scenes/authenticated/event_detail/widgets/event_detail_bottom_bar.dart';
import 'package:attendee/ui/scenes/authenticated/event_detail/widgets/organizer_card.dart';
import 'package:attendee/utils/constants/app_string_constants.dart';
import 'package:attendee/utils/constants/ui_constants.dart';
import 'package:attendee/utils/extensions/context_extension.dart';
import 'package:attendee/utils/extensions/date_time_extension.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class EventDetailPage extends StatelessWidget {
  const EventDetailPage({
    super.key,
    required this.eventId,
    required this.event,
  });

  final int? eventId;
  final Event? event;

  @override
  Widget build(BuildContext context) {
    return eventId == null ? ErrorPage() : EventDetailView();
  }
}

class EventDetailView extends StatelessWidget {
  EventDetailView({super.key});

  // TODO: remove later
  final Event event = Event(
    id: 1,
    title: 'Sample Event',
    summary: 'This is a sample event for demonstration purposes.',
    date: DateTime.now(),
    startTime: '18:00',
    endTime: '21:00',
    address: '123 Main Street',
    city: 'Sample City',
    country: 'Sample Country',
    language: 'English',
    ownerId: 100,
    organizer: null,
    status: 'active',

    bannerImagePath:
        'https://images.unsplash.com/photo-1761828122700-11b752d69a88?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&q=80&w=1287',
  );

  // Use Organizer from organizer.dart to create a dummy organizer
  final Organizer? organizer = Organizer(
    id: 123,
    name: 'Event Masters',
    description: 'A leading organization hosting incredible events.',
    contactEmail: 'contact@eventmasters.com',
    contactPhone: '+1 123-456-7890',
    website: 'https://eventmasters.com',
    logoUrl:
        'https://images.unsplash.com/photo-1761828122700-11b752d69a88?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&q=80&w=1287',
    isActive: true,
    ownerId: 1000,
    createdAt: DateTime(1970),
  );

  // TODO: remove later - dummy related events
  final List<Event> relatedEvents = _generateDummyEvents();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO: Get pricing string here
      bottomNavigationBar: EventDetailBottomBar(
        onGetTicketTapped: _onGetTicketTapped,
        dateTimeString: event.date?.shortString,
        pricingString: "Pricing",
      ),
      appBar: AppBar(
        actions: [
          IconButton(onPressed: _onShareTapped, icon: Icon(Icons.ios_share)),
          IconButton(
            onPressed: _onFavouriteTapped,
            icon: Icon(Icons.favorite_border),
          ),
        ],
        actionsPadding: EdgeInsets.only(right: UIConstants.horizontalPadding),
      ),
      body: ListView(
        padding: EdgeInsets.only(bottom: 20),
        children: [
          _buildImage(),
          SizedBox(height: 32),
          RefreshIndicator(onRefresh: _onRefresh, child: _buildBody(context)),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: UIConstants.horizontalPadding,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          EventDetailGeneralInfoWidget(
            title: event.title,
            city: event.city,
            address: event.address,
            date: event.date,
          ),
          Divider(height: 32),
          _buildOverviewSection(context),
          _buildLocationSection(context),
          _buildOrganizerCard(context),

          _buildRelatedEventsSection(context),
        ],
      ),
    );
  }

  Widget _buildOrganizerCard(BuildContext context) {
    if (organizer == null) {
      return SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(height: 32),
        Text(
          AppStringConstants.eventDetail.organizerSection,
          style: context.textPalette.headlineLarge,
        ),
        SizedBox(height: 12),
        OrganizerCard(
          organizer: organizer!,
          onContactTapped: _onContactTapped,
          onFollowTapped: _onFollowTapped,
        ),
      ],
    );
  }

  Widget _buildOverviewSection(BuildContext context) {
    if (event.summary == null || event.summary!.isEmpty) {
      return SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          AppStringConstants.eventDetail.overviewSection,
          style: context.textPalette.headlineLarge,
        ),
        SizedBox(height: 8),
        Text(event.summary!, style: context.textPalette.bodyLarge),
        Divider(height: 32),
      ],
    );
  }

  // TODO: Add map location here
  Widget _buildLocationSection(BuildContext context) {
    if (event.country == null) {
      return SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          AppStringConstants.eventDetail.locationSection,
          style: context.textPalette.headlineLarge,
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.address ?? event.cityAndCountryLabel,
                    style: context.textPalette.labelLarge,
                  ),
                  if (event.address != null &&
                      event.cityAndCountryLabel.isNotEmpty)
                    Text(event.cityAndCountryLabel),
                ],
              ),
            ),
            IconButton(onPressed: _onCopyAddressTapped, icon: Icon(Icons.copy)),
          ],
        ),
      ],
    );
  }

  Widget _buildImage() {
    return AspectRatio(
      aspectRatio: UIConstants.imageAspectRatio,
      child: CachedNetworkImage(
        imageUrl: event.bannerImagePath ?? '',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildRelatedEventsSection(BuildContext context) {
    if (relatedEvents.isEmpty) {
      return SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(height: 32),
        Text(
          AppStringConstants.eventDetail.relatedEventsSection,
          style: context.textPalette.headlineLarge,
        ),
        SizedBox(height: 20),
        ...List.generate(relatedEvents.length, _buildRelatedEventItem),
      ],
    );
  }

  Widget _buildRelatedEventItem(int index) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: index < relatedEvents.length - 1 ? 28 : 0,
      ),
      child: EventWidget.compact(
        isLoading: false,
        event: relatedEvents[index],
        onTapped: () => _onRelatedEventTapped(relatedEvents[index]),
      ),
    );
  }

  static List<Event> _generateDummyEvents() {
    return [
      _createDummyEvent(
        id: 2,
        title: 'Tech Conference 2025',
        summary: 'Annual technology conference',
        daysFromNow: 7,
        startTime: '09:00',
        endTime: '17:00',
        address: '456 Tech Street',
        city: 'Silicon Valley',
        country: 'USA',
        bannerImagePath:
            'https://images.unsplash.com/photo-1540575467063-178a50c2df87',
        ownerId: 101,
      ),
      _createDummyEvent(
        id: 3,
        title: 'Music Festival',
        summary: 'Summer music festival',
        daysFromNow: 14,
        startTime: '15:00',
        endTime: '23:00',
        address: '789 Music Ave',
        city: 'Music City',
        country: 'USA',
        bannerImagePath:
            'https://images.unsplash.com/photo-1514525253161-7a46d19cd819',
        ownerId: 102,
      ),
      _createDummyEvent(
        id: 4,
        title: 'Art Exhibition',
        summary: 'Contemporary art exhibition',
        daysFromNow: 21,
        startTime: '10:00',
        endTime: '18:00',
        address: '321 Art Boulevard',
        city: 'Art City',
        country: 'France',
        language: 'French',
        bannerImagePath:
            'https://images.unsplash.com/photo-1518998053901-5348d3961a04',
        ownerId: 103,
      ),
    ];
  }

  static Event _createDummyEvent({
    required int id,
    required String title,
    required String summary,
    required int daysFromNow,
    required String startTime,
    required String endTime,
    required String address,
    required String city,
    required String country,
    required String bannerImagePath,
    required int ownerId,
    String language = 'English',
  }) {
    return Event(
      id: id,
      title: title,
      summary: summary,
      date: DateTime.now().add(Duration(days: daysFromNow)),
      startTime: startTime,
      endTime: endTime,
      address: address,
      city: city,
      country: country,
      language: language,
      ownerId: ownerId,
      organizer: null,
      status: 'active',
      bannerImagePath: bannerImagePath,
    );
  }

  void _onCopyAddressTapped() {}

  void _onFollowTapped() {}

  void _onContactTapped() {}

  void _onRelatedEventTapped(Event event) {}

  Future<void> _onRefresh() async {}

  void _onFavouriteTapped() {}

  void _onShareTapped() {}

  void _onGetTicketTapped() {}
}
