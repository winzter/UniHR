import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/entities.dart';
import 'heading_with_gradient_line.dart';

class ContractDetail extends StatelessWidget {

  final EachEmployeeEntity eachEmpData;
  const ContractDetail({Key? key, required this.eachEmpData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).devicePixelRatio*5,vertical: MediaQuery.of(context).devicePixelRatio*3),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(15)
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.contact_mail_sharp),
              HeadingGradientLine(title: ' Contract', width: MediaQuery.of(context).size.width*0.19,),
            ],
          ),
          const SizedBox(height: 15,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.mail,color: Colors.redAccent,),
              Text(" Email : ",style: TextStyle(fontSize: 16),),
              Flexible(child: Text("${eachEmpData.email??'-'}",style: TextStyle(fontSize: 16),))
            ],
          ),
          const SizedBox(height: 5,),
          Row(
            children: [
              Icon(Icons.phone_android_outlined,color: Colors.green,),
              Text(" Phone Number : ",style: TextStyle(fontSize: 16),),
              Text("${eachEmpData.emergencyPhone??'-'}",style: TextStyle(fontSize: 16),)
            ],
          ),
          const SizedBox(height: 5,),
          Row(
            children: [
              Icon(Icons.cake_rounded,color: Colors.orangeAccent,),
              Text(" Birth Date : ",style: TextStyle(fontSize: 16),),
              Text(DateFormat('dd MMMM yyyy').format(eachEmpData.birthday??DateTime.now()),style: TextStyle(fontSize: 16),)
            ],
          )
        ],
      ),
    );
  }
}
