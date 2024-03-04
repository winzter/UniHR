import 'package:dartz/dartz.dart';
import 'package:unihr/src/core/error/failures.dart';
import '../../../../../core/features/profile/domain/entity/profile_entity.dart';
import '../entities/entities.dart';
abstract class TimeLineRepository{
  Future<Either<ErrorMessage,List<TimeLineEntity>>> getAttendance();
  Future<Either<ErrorMessage,List<TimeLineEntity>>> getAttendanceByDate(String start,String end);
  Future<Either<ErrorMessage,List<ReasonEntity>>> getReason(int idCompany);
  Future<Either<ErrorMessage,PayrollSetting>> getPayrollSettingTimeLine();
  Map<String,List<String>> getEvents(List<TimeLineEntity> data);
  Future<Either<ErrorMessage,ErrorTimeLine>> sendTimeRequest(
      CalculateTimeEntity? result,
      double? amountHour,
      int idEmployee,
      int idRequestType,
      String requestReason,
      String otherReason,
      DateTime start,
      DateTime end,
      DateTime workEndDate,
      ProfileEntity profileData,
      List<ReasonEntity> reasonAllData,
      );
}