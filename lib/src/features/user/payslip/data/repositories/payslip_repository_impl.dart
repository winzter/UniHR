import 'package:dartz/dartz.dart';
import '../../../../../core/error/exception.dart';
import '../../../../../core/error/failures.dart';
import '../../domain/repositories/payslip_repository.dart';
import '../data_sources/remote/payslip_remote_data_source.dart';
import '../models/payslip_model.dart';



class PayslipRepositoryImpl implements PayslipRepository {
  final PayslipRemoteDataSource remoteDataSource;

  PayslipRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<ErrorMessage, List<PayslipModel>>> getPayslip(
      String year, String month) async {
    try {
      final data = await remoteDataSource.getPayslip(year, month);
      return Right(data);
    } on ErrorException {
      return Left(ErrorMessage());
    }
  }
}
