import '../repositories/item_status_repository.dart';

class IsFullDay{

  final ItemStatusRepository repository;
  IsFullDay(this.repository);

  String call(DateTime start,DateTime end) {
    return repository.isFullDay(start, end);
  }
}