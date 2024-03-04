import 'package:dartz/dartz.dart';
import 'package:unihr/src/core/error/failures.dart';
import 'package:unihr/src/core/features/attendance/data/data_sources/remote/attendance_remote_datasource.dart';
import '../../../../error/exception.dart';
import '../../domain/repositories/attendance_repository.dart';
import '../models/attendance_model.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  final AttendanceRemoteDataSource remoteDataSource;

  AttendanceRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<ErrorMessage, List<AttendanceModel>>> getAttendance() async {
    try {
      final data = await remoteDataSource.getAttendance();
      return Right(data);
    } on ErrorException {
      return Left(ErrorMessage());
    }
  }

  @override
  Future<Either<ErrorMessage, List<AttendanceModel>>> getAttendanceByDate(
      String start, String end) async {
    try {
      final data = await remoteDataSource.getAttendanceByDate(start, end);
      return Right(data);
    } on ErrorException {
      return Left(ErrorMessage());
    }
  }
}
