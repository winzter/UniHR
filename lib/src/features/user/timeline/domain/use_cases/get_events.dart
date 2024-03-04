import '../entities/entities.dart';
import '../repositories/attendance_repository.dart';

class GetEvents {
  final TimeLineRepository repository;
  GetEvents({required this.repository});

  Map<String, List<String>> call(List<TimeLineEntity> data)  {
    return  repository.getEvents(data);
  }
}