import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failures.dart';
import '../../domain/use_cases/send_check_inout.dart';

part 'bluetooth_event.dart';
part 'bluetooth_state.dart';

class BluetoothBloc extends Bloc<BluetoothEvent, BluetoothState> {

  final SentCheckInOut sentCheckInOut;
  BluetoothBloc({required this.sentCheckInOut}) : super(BluetoothInitial()) {
    on<SendBluetoothData>((event, emit) async {
      emit(state.copyWith(status: FetchStatus.fetching));
      var sendLocationStatus = await sentCheckInOut(
          event.attendanceDateTime,
          event.isCheckIn,
          event.idAttendanceType,
          event.idEmployee,
          event.idCompany,
      );
      sendLocationStatus.fold(
              (l) => emit(state.copyWith(error: l)), (r) {
        emit(state.copyWith(status: FetchStatus.success));
      });
    });
  }
}
