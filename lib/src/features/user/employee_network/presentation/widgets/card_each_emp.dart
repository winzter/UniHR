import 'package:flutter/material.dart';
import '../../domain/entities/entities.dart';
import '../pages/employee_detail.dart';

class CardEachEmp extends StatelessWidget {
  final EmployeeNetworkEntity empData;

  const CardEachEmp({super.key, required this.empData});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EmployeeDetailPage(idEmp: empData.idEmployees!,),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 30,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: empData.imageProfile != null
                          ? CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.transparent,
                              child: ClipOval(
                                child: Image.network(
                                  "${empData.imageProfile}",
                                ),
                              ))
                          : const CircleAvatar(
                              radius: 40,
                              backgroundColor: Color(0xffc4c4c4),
                              child: Icon(
                                Icons.person,
                                size: 60,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 70,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            "${empData.firstnameTh} ${empData.lastnameTh} (${empData.nicknameTh??'-'})",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text("${empData.positionName}",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 14)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
