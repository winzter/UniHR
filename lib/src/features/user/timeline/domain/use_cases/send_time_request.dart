import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/features/profile/domain/entity/profile_entity.dart';
import '../entities/entities.dart';
import '../repositories/attendance_repository.dart';

class SendTimeRequest {
  final TimeLineRepository repository;
  SendTimeRequest({required this.repository});

  Future<Either<ErrorMessage, ErrorTimeLine>> call(
      CalculateTimeEntity? result,
        double? amountHour,
        int idEmployee,
        int idRequestType,
        String requestReason,
        String otherReason,
        DateTime start,
        DateTime end,
        DateTime workEndDate,
        String note,
      ProfileEntity profileData,
      List<ReasonEntity> reasonAllData,
      ) async {
    return await repository.sendTimeRequest(
        result,
      amountHour,
        idEmployee,
        idRequestType,
        requestReason,
        otherReason,
        start,
        end,
        workEndDate,
        profileData,
        reasonAllData,
    );
  }
}