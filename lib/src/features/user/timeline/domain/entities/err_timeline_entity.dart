import 'package:equatable/equatable.dart';

class ErrorTimeLine extends Equatable{
  final String? errorCode;

  ErrorTimeLine({
    this.errorCode,
  });

  @override
  List<Object?> get props => [errorCode];

}
