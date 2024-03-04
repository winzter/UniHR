import 'package:dartz/dartz.dart';
import 'package:unihr/src/core/error/failures.dart';
import 'package:unihr/src/features/user/noti_user/data/data_sources/remote/noti_attendance_remote_datasource.dart';
import 'package:unihr/src/features/user/noti_user/domain/entities/noti_attendance_entity.dart';
import 'package:unihr/src/features/user/noti_user/domain/repositories/noti_attiendance_repository.dart';

import '../../../../../core/error/exception.dart';

class NotiattendanceRepositoryImpl implements NotiattiendanceRepository {
  final NotiattendanceRemoteDataSource remoteDataSource;
  NotiattendanceRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<ErrorMessage, List<NotiattendanceEntity>>>
      getNotiattiendance() async {
    try {
      final data = await remoteDataSource.getNotiattendace();
      return Right(data);
    } on ErrorException {
      return Left(ErrorMessage());
    }
  }
}
