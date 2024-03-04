part of 'bluetooth_bloc.dart';

enum FetchStatus { fetching, success, failed, init, selected }

class BluetoothState extends Equatable {
  final FetchStatus status;

  final ErrorMessage? error;

  const BluetoothState({
    this.status = FetchStatus.init,
    this.error = null,
  });

  BluetoothState copyWith({
    FetchStatus? status,
    ErrorMessage? error,
  }) {
    return BluetoothState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status,error];
}

class BluetoothInitial extends BluetoothState {
  @override
  List<Object> get props => [];
}
