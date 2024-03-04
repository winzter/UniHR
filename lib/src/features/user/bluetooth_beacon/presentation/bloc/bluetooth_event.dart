part of 'bluetooth_bloc.dart';

abstract class BluetoothEvent extends Equatable {
  const BluetoothEvent();
}

class SendBluetoothData extends BluetoothEvent{
  final String attendanceDateTime;
  final int isCheckIn;
  final int idAttendanceType;
  final String idEmployee;
  final  String idCompany;

  const SendBluetoothData({
    required this.attendanceDateTime,
    required this.isCheckIn,
    required this.idAttendanceType,
    required this.idEmployee,
    required this.idCompany,
  });
  @override
  List<Object?> get props => [
    attendanceDateTime,
    isCheckIn,
    idAttendanceType,
    idEmployee,
    idCompany,
  ];
}