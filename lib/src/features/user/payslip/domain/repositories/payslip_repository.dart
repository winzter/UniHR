import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/payslip.dart';

abstract class PayslipRepository {
  Future<Either<ErrorMessage, List<PayslipEntity>>> getPayslip(
      String year, String month);
}
