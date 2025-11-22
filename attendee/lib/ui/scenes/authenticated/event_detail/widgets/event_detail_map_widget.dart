import 'package:attendee/network/constants/api_endpoint_constants.dart';
import 'package:attendee/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:vietmap_flutter_gl/vietmap_flutter_gl.dart';

class EventDetailMapWidget extends StatefulWidget {
  const EventDetailMapWidget({super.key, required this.coordinates});

  final ({double lat, double long}) coordinates;

  @override
  State<EventDetailMapWidget> createState() => _EventDetailMapWidgetState();
}

class _EventDetailMapWidgetState extends State<EventDetailMapWidget> {
  VietmapController? _controller;
  bool _styleLoaded = false;

  @override
  void didUpdateWidget(covariant EventDetailMapWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    final hasCoordinateChanged =
        oldWidget.coordinates.lat != widget.coordinates.lat ||
        oldWidget.coordinates.long != widget.coordinates.long;
    if (hasCoordinateChanged) {
      _moveCameraToNewCoordinates();
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller = null;
    _styleLoaded = false;
    super.dispose();
  }

  @override
  void deactivate() {
    _controller = null;
    _styleLoaded = false;
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildMap(),

        if (_controller != null && _styleLoaded)
          MarkerLayer(
            markers: [_buildMarker(context)],
            mapController: _controller!,
          ),
      ],
    );
  }

  Widget _buildMap() {
    return VietmapGL(
      styleString: ApiEndpointConstants.vietMapTileStyle,
      dragEnabled: false,
      doubleClickZoomEnabled: false,

      scrollGesturesEnabled: false,
      zoomGesturesEnabled: false,
      rotateGesturesEnabled: false,
      tiltGesturesEnabled: false,

      trackCameraPosition: true,
      initialCameraPosition: CameraPosition(
        target: LatLng(widget.coordinates.lat, widget.coordinates.long),
        zoom: 15,
      ),
      onMapCreated: (controller) {
        if (!mounted) return;
        _controller = controller;
        if (mounted) setState(() {});
      },
      onStyleLoadedCallback: () {
        if (!mounted) return;
        _styleLoaded = true;
        setState(() {});
      },
    );
  }

  Marker _buildMarker(BuildContext context) {
    return Marker(
      child: Icon(
        Icons.location_on,
        size: 50,
        color: context.colorPalette.branding,
      ),
      latLng: LatLng(widget.coordinates.lat, widget.coordinates.long),
    );
  }

  Future<void> _moveCameraToNewCoordinates() async {
    final controller = _controller;
    if (controller == null || !_styleLoaded) {
      return;
    }

    final target = LatLng(widget.coordinates.lat, widget.coordinates.long);
    final currentZoom = controller.cameraPosition?.zoom ?? 15;

    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: target, zoom: currentZoom),
      ),
    );
  }
}
