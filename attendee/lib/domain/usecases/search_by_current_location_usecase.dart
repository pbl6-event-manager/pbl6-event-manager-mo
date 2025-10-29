import 'package:attendee/domain/models/event.dart';
import 'package:attendee/domain/repositories/event_repository.dart';
import 'package:attendee/utils/helpers/result.dart';
import 'package:geolocator/geolocator.dart';

/// Search using current location
abstract class SearchByCurrentLocationUsecase {
  Future<Result<List<Event>>> execute();
}

final class SearchByCurrentLocationUsecaseImplementation
    implements SearchByCurrentLocationUsecase {
  final EventRepository _eventRemoteRepository;

  const SearchByCurrentLocationUsecaseImplementation({
    required EventRepository eventRemoteRepository,
  }) : _eventRemoteRepository = eventRemoteRepository;

  @override
  Future<Result<List<Event>>> execute() async {
    try {
      final position = await _getDeviceCurrentPosition();

      return _eventRemoteRepository.getEventsNearby(
        lat: position.lat,
        long: position.long,
      );
    } catch (error) {
      return Result.error(error);
    }
  }

  Future<({double lat, double long})> _getDeviceCurrentPosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    final Position position = await Geolocator.getCurrentPosition();

    return (lat: position.latitude, long: position.longitude);
  }
}
