import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/shift_ot_entitiy.dart';

abstract class ShiftAndOTRepository {
  Future<Either<ErrorMessage, ShiftAndOtEntity>> getShiftAndOT(
      String start,String end);
}
