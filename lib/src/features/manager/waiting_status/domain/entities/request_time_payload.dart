import 'package:equatable/equatable.dart';

class RequestTimePayload extends Equatable{
  final ManagerLv1 managerLv1;
  final ManagerLv2 managerLv2;

  const RequestTimePayload({required this.managerLv1 , required this.managerLv2});


  @override
  List<Object?> get props => [
    managerLv1,
    managerLv2,
  ];

}

class ManagerLv1 extends Equatable{
  final String approveDate;
  final String commentManagerLV1;
  final List<int> idRequestTimeLV1;
  final int isManagerLV1Approve;

  const ManagerLv1(
    this.approveDate,
    this.commentManagerLV1,
    this.idRequestTimeLV1,
    this.isManagerLV1Approve,);

  @override
  List<Object?> get props => [
    approveDate,
    commentManagerLV1,
    idRequestTimeLV1,
    isManagerLV1Approve,
  ];
}

class ManagerLv2 extends Equatable{
  final String approveDate;
  final String commentManagerLV2;
  final List<int> idRequestTimeLV2;
  final int isManagerLV2Approve;

  const ManagerLv2(
      this.approveDate,
      this.commentManagerLV2,
      this.idRequestTimeLV2,
      this.isManagerLV2Approve,);

  @override
  List<Object?> get props => [
    approveDate,
    commentManagerLV2,
    idRequestTimeLV2,
    isManagerLV2Approve,
  ];
}