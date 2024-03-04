import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/entities.dart';
import '../repositories/item_status_repository.dart';

class DeleteItem {
  final ItemStatusRepository repository;
  DeleteItem({required this.repository});

  Future<Either<ErrorMessage, void>> call(
      {LeaveEntity? dataLeave, RequestTimeEntity? dataRequestTime}) async {
    if (dataLeave != null) {
      return await repository.deleteItem(dataLeave: dataLeave);
    } else {
      return await repository.deleteItem(dataRequestTime: dataRequestTime);
    }
  }
}
