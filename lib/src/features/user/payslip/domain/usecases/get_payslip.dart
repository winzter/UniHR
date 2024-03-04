import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/payslip.dart';
import '../repositories/payslip_repository.dart';


class GetPayslip {
  final PayslipRepository repository;

  GetPayslip({required this.repository});

  Future<Either<ErrorMessage, List<PayslipEntity>>> call(
      {required String year, required String month}) async {
    return await repository.getPayslip(year, month);
  }
}
