import 'package:dartz/dartz.dart';
import 'package:unihr/src/features/manager/waiting_status/domain/repositories/waiting_status_repository.dart';
import '../../../../../core/error/failures.dart';

class IsRequestApprove {
  final WaitingStatusRepository repository;
  IsRequestApprove({required this.repository});

  Future<Either<ErrorMessage,void>> call({
    required String commentManagerLV1,
    required String commentManagerLV2,
    required List<int> idRequestTimeLv1,
    required int isManagerLV1Approve,
    required int? isManagerLV2Approve,
    required List<int> idRequestTimeLv2,
  }) async{
    return await repository.isRequestTimeApprove(
        commentManagerLV1,
        commentManagerLV2,
        idRequestTimeLv1,
        isManagerLV1Approve,
        isManagerLV2Approve,
        idRequestTimeLv2
    );
  }
}
