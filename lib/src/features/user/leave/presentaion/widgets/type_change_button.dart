import 'package:flutter/material.dart';
import '../bloc/leave_bloc.dart';

class TypeChangButton extends StatefulWidget {
  final String title;
  final LeaveBloc bloc;

  const TypeChangButton({super.key, required this.title, required this.bloc});

  @override
  State<TypeChangButton> createState() => _TypeChangButtonState();
}

class _TypeChangButtonState extends State<TypeChangButton> {
  String typeStyle = "fullday";

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: (){},
        child: Text(widget.title,style: TextStyle(),));
  }
}
