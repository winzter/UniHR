import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/entities.dart';
import 'heading_with_gradient_line.dart';

class InformationDetail extends StatelessWidget {

  final EachEmployeeEntity eachEmpData;
  const InformationDetail({super.key, required this.eachEmpData});

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
              Icon(Icons.info_rounded),
              HeadingGradientLine(title: ' Information', width: MediaQuery.of(context).size.width*0.25,),
            ],
          ),
          const SizedBox(height: 15,),
          Row(
            children: [
              Icon(Icons.work,color: Colors.brown,),
              Text(" Employment Type : ",style: TextStyle(fontSize: 16),),
              Text("-",style: TextStyle(fontSize: 16),)
            ],
          ),
          const SizedBox(height: 5,),
          Row(
            children: [
              Icon(Icons.contacts_rounded,color: Colors.lightGreen,),
              Text(" Employee ID : ",style: TextStyle(fontSize: 16),),
              Text("${eachEmpData.employeeId??'-'}",style: TextStyle(fontSize: 16),)
            ],
          ),
          const SizedBox(height: 5,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.business,color: Colors.orangeAccent,),
              Text(" Company : ",style: TextStyle(fontSize: 16),),
              Flexible(child: Text("${eachEmpData.companyName??'-'}",style: TextStyle(fontSize: 16),))],
          ),
          const SizedBox(height: 5,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.business,color: Colors.blueAccent,),
              Text(" Section : ",style: TextStyle(fontSize: 16),),
              Flexible(child: Text("${eachEmpData.sectionName??'-'}",style: TextStyle(fontSize: 16),))],
          ),
          const SizedBox(height: 5,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.business,color: Colors.redAccent,),
              Text(" Department : ",style: TextStyle(fontSize: 16),),
              Flexible(child: Text("${eachEmpData.departmentName??'-'}",style: TextStyle(fontSize: 16),))],
          ),
          const SizedBox(height: 5,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.business,color: Colors.green,),
              Text(" Division : ",style: TextStyle(fontSize: 16),),
              Flexible(child: Text("${eachEmpData.divisionName??'-'}",style: TextStyle(fontSize: 16),))],
          ),
          const SizedBox(height: 5,),
          Row(
            children: [
              Icon(Icons.group_add,color: Colors.indigo,),
              Text(" Job Group : ",style: TextStyle(fontSize: 16),),
              Text("-",style: TextStyle(fontSize: 16),)],
          ),
          const SizedBox(height: 5,),
          Row(
            children: [
              Icon(Icons.calendar_month,color: Colors.pinkAccent,),
              Text(" Start Date : ",style: TextStyle(fontSize: 16),),
              Text(DateFormat('dd MMMM yyyy').format(eachEmpData.hiringDate??DateTime.now()),style: TextStyle(fontSize: 16),)
            ],
          ),
          const SizedBox(height: 5,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.newspaper,color: Colors.purple,),
              Text(" Reporting Manager : ",style: TextStyle(fontSize: 16),),
              Flexible(child: Text("${eachEmpData.managerLv1FirstnameTh??'-'} ${eachEmpData.managerLv1LastnameTh??'-'}",style: TextStyle(fontSize: 16),))                                    ],
          ),
        ],
      ),
    );
  }
}
