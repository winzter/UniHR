part of 'change_password_bloc.dart';

abstract class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();
}

class SendChangePasswordEvent extends ChangePasswordEvent{
  final String newPass;
  final String oldPass;
  final String confirm;

  SendChangePasswordEvent({
    required this.newPass,
    required this.oldPass,
    required this.confirm,
});
  @override
  List<Object?> get props => [
    newPass,
    oldPass,
    confirm,
  ];

}