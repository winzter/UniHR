part of 'change_password_bloc.dart';

enum FetchStatus { fetching, success, failed, init }

class ChangePasswordState extends Equatable {
  final String? errMsg;
  final FetchStatus status;

  const ChangePasswordState(
      {this.errMsg = null, this.status = FetchStatus.init});

  ChangePasswordState copyWith({
    String? errMsg,
    FetchStatus? status,
  }) {
    return ChangePasswordState(
      errMsg: errMsg ?? this.errMsg,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        errMsg,
        status,
      ];
}

class ChangePasswordInitial extends ChangePasswordState {
  @override
  List<Object> get props => [];
}
