import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:unihr/src/features/user/shift_ot/domain/entities/shift_ot_entitiy.dart';
import '../../../../../core/error/exception.dart';
import '../../../../../core/error/failures.dart';
import '../../domain/repositories/shift_ot_repository.dart';
import '../data_sources/remote/shift_ot_remote_datasource.dart';


class ShiftAndOtRepositoryImpl implements ShiftAndOTRepository {
  final ShiftAndOTRemoteDataSource remoteDataSource;

  ShiftAndOtRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<ErrorMessage, ShiftAndOtEntity>> getShiftAndOT(String start,String end) async{
    try {
      final data = await remoteDataSource.getShiftAndOT(start,end);
      return Right(data);
    } on ErrorException catch (error){
      Logger().e("${error.message}");
      return Left(ErrorMessage(errMsgText: "ไม่สามารถเชื่อมต่อกับ Server ได้"));
    } on TypeError catch (error){
      Logger().e("$error");
      return Left(ErrorMessage(errMsgText: "ไม่สามารถแปลงข้อมูลได้"));
    } on ClientException catch (error){
      Logger().e("$error");
      return Left(ErrorMessage(errMsgText: "กรุณาตรวจสอบอินเทอร์เน็ต"));
    }
  }
}
