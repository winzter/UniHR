import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../data/data_sources/leave_request.dart';
import '../entities/entities.dart';

abstract class LeaveRepository {
  Future<Either<ErrorMessage, List<LeaveHistoryEntity>>> getLeaveHistory(
      DateTime year);
  Future<Either<ErrorMessage, LeaveSettingEntity>> getLeaveSettingData();
  Future<Either<ErrorMessage, List<LeaveAvailableEntity>>> getLeaveAvailableData(
      DateTime start);
  Future<Either<ErrorMessage, void>> deleteLeaveHistory(
      LeaveHistoryEntity leaveData);
  Future<Either<ErrorMessage, List<LeaveAuthorityEntity>>> getLeaveAuthority();
  Future<Either<ErrorMessage, void>> sendLeaveRequest(LeaveRequest data);
  Future<Either<ErrorMessage, List<ManagerLeave>>> getManagerLeave();
  Future<Either<ErrorMessage, List<HolidayLeaveEntity>>> getHolidayLeave();
  Future<Either<ErrorMessage, List<DayCannotLeave>>> getDayCannotLeave(
      DateTime start, DateTime end, int idEmp);
}
