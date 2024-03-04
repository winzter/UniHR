import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../data/data_sources/send_data/change_time.dart';
import '../repositories/waiting_status_repository.dart';

class IsChangeTimeApprove {
  final WaitingStatusRepository repository;

  IsChangeTimeApprove({required this.repository});

  Future<Either<ErrorMessage,void>> call({
    required List<ChangeTimeSendData> sendTimeData
  }) async{
    return await repository.isChangeTimeManagerApprove(sendTimeData);
  }
}