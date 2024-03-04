part of 'notiattendance_bloc.dart';

abstract class NotiattendState extends Equatable {
  final List<NotiattendanceEntity> notiattendancedData;

  NotiattendState({required this.notiattendancedData});
}

class NotiattendInitial extends NotiattendState {
  NotiattendInitial({required super.notiattendancedData});

  @override
  List<Object?> get props => [];
}

class NotiattendLoading extends NotiattendState {
  NotiattendLoading({required super.notiattendancedData});

  @override
  List<Object?> get props => [];
}

class NotiattendLoaded extends NotiattendState {
  final List<NotiattendanceEntity> showData;

  NotiattendLoaded({
    required this.showData,
    required super.notiattendancedData,
  });

  List<Object?> get props => [showData, super.notiattendancedData];
}

class NotiattendFailure extends NotiattendState {
  final ErrorMessage error;

  NotiattendFailure({required this.error, required super.notiattendancedData});
  @override
  List<Object?> get props => [error];
}
