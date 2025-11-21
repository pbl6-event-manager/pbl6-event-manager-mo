import 'package:attendee/utils/constants/app_string_constants.dart';
import 'package:attendee/utils/helpers/options.dart';
import 'package:flutter/material.dart';

enum TicketOption implements Option {
  eventDetail,
  orderDetail,
  downloadTicket,
  ticketInformation,
  cancelOrder,
  reportEvent;

  @override
  IconData get icon => switch (this) {
    TicketOption.eventDetail => Icons.event,
    TicketOption.orderDetail => Icons.receipt_long,
    TicketOption.downloadTicket => Icons.download_rounded,
    TicketOption.ticketInformation => Icons.info_outline,
    TicketOption.cancelOrder => Icons.cancel_outlined,
    TicketOption.reportEvent => Icons.flag_outlined,
  };

  @override
  String get title => switch (this) {
    TicketOption.eventDetail => AppStringConstants.ticket.eventDetailOption,

    TicketOption.orderDetail => AppStringConstants.ticket.orderDetailOption,

    TicketOption.downloadTicket =>
      AppStringConstants.ticket.downloadTicketOption,

    TicketOption.ticketInformation =>
      AppStringConstants.ticket.ticketInformationOption,

    TicketOption.cancelOrder => AppStringConstants.ticket.cancelOrderOption,

    TicketOption.reportEvent => AppStringConstants.ticket.reportEventOption,
  };
}
