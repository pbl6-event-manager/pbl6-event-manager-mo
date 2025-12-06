import 'package:attendee/domain/models/ticket.dart';
import 'package:attendee/domain/models/ticket_attendee_info.dart';
import 'package:attendee/ui/common_widgets/common_text_field.dart';
import 'package:attendee/utils/constants/app_string_constants.dart';
import 'package:attendee/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class TicketInfoExpansionWidget extends StatefulWidget {
  const TicketInfoExpansionWidget({
    super.key,
    required this.ticket,
    required this.index,
    required this.onChanged,
    this.attendeeInfo,
  });

  final Ticket ticket;
  final int index;
  final TicketAttendeeInfo? attendeeInfo;
  final void Function(String name, String email) onChanged;

  @override
  State<TicketInfoExpansionWidget> createState() =>
      _TicketInfoExpansionWidgetState();
}

class _TicketInfoExpansionWidgetState extends State<TicketInfoExpansionWidget> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final ExpansibleController _expansibleController;

  bool _hasAllData = false;
  bool _shouldShowValidation = false;

  bool get _isNameValid => _nameController.text.trim().isNotEmpty;
  bool get _isEmailValid => _emailController.text.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _expansibleController = ExpansibleController();
    _expansibleController.addListener(_onExpansionChanged);
    _prefillFormFields();
    _nameController.addListener(_onTextChanged);
    _emailController.addListener(_onTextChanged);
  }

  void _prefillFormFields() {
    final info = widget.attendeeInfo;
    if (info != null) {
      _nameController.text = info.fullName;
      _emailController.text = info.email;
      _hasAllData = info.isComplete;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _expansibleController.removeListener(_onExpansionChanged);
    _expansibleController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant TicketInfoExpansionWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    final info = widget.attendeeInfo;
    if (info == null) {
      return;
    }
    if (info.fullName != _nameController.text) {
      _nameController.text = info.fullName;
    }
    if (info.email != _emailController.text) {
      _emailController.text = info.email;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      controller: _expansibleController,
      onExpansionChanged: _handleExpansionChanged,
      collapsedBackgroundColor: context.colorPalette.surfaceContainer,
      backgroundColor: context.colorPalette.surfaceContainer,

      collapsedShape: ContinuousRectangleBorder(
        borderRadius: BorderRadiusGeometry.all(Radius.circular(16)),
      ),
      shape: ContinuousRectangleBorder(
        side: BorderSide(width: 1, color: context.colorPalette.border),
        borderRadius: BorderRadiusGeometry.all(Radius.circular(16)),
      ),
      tilePadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      childrenPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ticket ${widget.index + 1}: ${widget.ticket.name}',
            style: (_hasAllData && !_expansibleController.isExpanded)
                ? context.textPalette.labelSmall.copyWith()
                : context.textPalette.labelLarge,
          ),

          ..._buildFields(
            name: _nameController.text,
            email: _emailController.text,
            isExpanded: _expansibleController.isExpanded,
          ),
        ],
      ),
      children: [
        CommonTextField(
          hintText: AppStringConstants.textFields.namePlaceholder,
          controller: _nameController,
          errorText: _shouldShowValidation && !_isNameValid
              ? AppStringConstants.checkout.attendeeNameRequiredError
              : null,
        ),
        SizedBox(height: 16),

        CommonTextField(
          hintText: AppStringConstants.textFields.emailPlaceholder,
          keyboardType: TextInputType.emailAddress,
          controller: _emailController,
          errorText: _shouldShowValidation && !_isEmailValid
              ? AppStringConstants.checkout.attendeeEmailRequiredError
              : null,
        ),
        SizedBox(height: 16),
      ],
    );
  }

  void _onTextChanged() {
    setState(() {
      _hasAllData = _isNameValid && _isEmailValid;
      if (_hasAllData) {
        _shouldShowValidation = false;
      }
    });
    widget.onChanged(_nameController.text, _emailController.text);
  }

  /// Handle the changes in expansion
  ///
  /// If [willExpand] is false and current data is not valid => still expand
  void _handleExpansionChanged(bool willExpand) {
    if (!willExpand && !_hasAllData) {
      setState(() => _shouldShowValidation = true);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _expansibleController.expand();
        }
      });
    }
  }

  void _onExpansionChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  List<Widget> _buildFields({
    required String name,
    required String email,
    required bool isExpanded,
  }) {
    return [
      if ((name.isNotEmpty || email.isNotEmpty) && !isExpanded)
        SizedBox(height: 4),
      if (name.isNotEmpty && !isExpanded)
        Text(name, style: context.textPalette.labelLarge),
      if (email.isNotEmpty && !isExpanded)
        Text(email, style: context.textPalette.bodyMedium),
    ];
  }
}
