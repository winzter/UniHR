import 'package:flutter/material.dart';
import '../../domain/entities/entities.dart';

class EducationDetail extends StatelessWidget {

  final EachEmployeeEntity eachEmpData;
  const EducationDetail({Key? key, required this.eachEmpData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment:
      MainAxisAlignment.center,
      children: [
        if (eachEmpData.educations != null && eachEmpData.educations!.isNotEmpty) ...[
          Row(
            children: [
              Text(
                  "ปีการศึกษา : ${eachEmpData.educations![0].fromYear ?? '-'} - ${eachEmpData.educations![0].endYear ?? '-'}"),
            ],
          ),
          Row(
            children: [
              Flexible(
                child: Text(
                    "ปริญญา : ${eachEmpData.educations![0].degree ?? '-'}"),
              ),
            ],
          ),
          Row(
            children: [
              Flexible(
                  child: Text(
                      "มหาวิทยาลัย : ${eachEmpData.educations![0].university ?? '-'}")),
            ],
          ),
          Row(
            children: [
              Flexible(
                child: Text(
                    "คณะ : ${eachEmpData.educations![0].faculty ?? '-'}"),
              ),
            ],
          ),
          Row(
            children: [
              Flexible(
                child: Text(
                    "สาขา : ${eachEmpData.educations![0].major ?? '-'}"),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                  "เกรดเฉลี่ย : ${eachEmpData.educations![0].gpa ?? '-'}"),
            ],
          ),
        ] else ...[
          Center(
              child: Text(
                  "ไม่มีข้อมูล")),
        ]
      ],
    );
  }
}
