part of 'notiattendance_bloc.dart';

abstract class NotiattendEvent extends Equatable {
  NotiattendEvent();
}

class GetNotiattendData extends NotiattendEvent {
  @override
  List<Object?> get props => [];
}
