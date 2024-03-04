import 'package:dartz/dartz.dart';
import 'package:unihr/src/features/user/shift_ot/domain/entities/shift_ot_entitiy.dart';
import 'package:unihr/src/features/user/shift_ot/domain/repositories/shift_ot_repository.dart';
import '../../../../../core/error/failures.dart';

class GetShiftAndOT {
  final ShiftAndOTRepository repository;

  GetShiftAndOT({required this.repository});

  Future<Either<ErrorMessage, ShiftAndOtEntity>> call(String start,String end) async {
    return await repository.getShiftAndOT(start,end);
  }
}
