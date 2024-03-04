import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unihr/src/features/user/noti_user/domain/use_cases/get_notiattendance.dart';

import '../../../../../core/error/failures.dart';
import '../../domain/entities/noti_attendance_entity.dart';

part 'notiattendance_event.dart';
part 'notiattendance_state.dart';

class NotiattendBloc extends Bloc<NotiattendEvent, NotiattendState> {
  final GetNotiattendance getNotiattendance;

  NotiattendBloc({required this.getNotiattendance})
      : super(NotiattendInitial(notiattendancedData: [])) {
    on<GetNotiattendData>((event, emit) async {
      List<NotiattendanceEntity> data = [];
      emit(NotiattendLoading(notiattendancedData: state.notiattendancedData));
      var response = await getNotiattendance();
      response.fold(
          (l) => emit(NotiattendFailure(
              error: l, notiattendancedData: state.notiattendancedData)), (r) {
        data = r;
      });
      emit(NotiattendLoaded(
        showData: data.sublist(1, data.length - 1),
        notiattendancedData: data,
      ));
    });
  }
}
