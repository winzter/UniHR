import 'package:dartz/dartz.dart';
import 'package:unihr/src/features/user/time_management/data/data_source/remote/shift_change.dart';
import '../../../../../core/error/failures.dart';
import '../entities/enitities.dart';

abstract class TimeManagementRepository{
  Future<Either<ErrorMessage,List<ShiftEntity>>> getShift();
  Future<Either<ErrorMessage,List<TimeScheduleEntity>>> getTimeSchedule(String startDate);
  Future<Either<ErrorMessage,List<HolidayEntity>>> getHoliday();
  Future<Either<ErrorMessage,List<CheckHolidayEntity>>> getCheckHoliday(String startDate);
  Future<Either<ErrorMessage,void>> sendChangeTime(ShiftChange data);
  Future<Either<ErrorMessage,void>> withdrawChangTime(int idEmployeeShiftDaily,int idEmployees);
}