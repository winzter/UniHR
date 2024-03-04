import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CompanyDetail extends StatelessWidget {
  const CompanyDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(left: 30,right: 0,top: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset("assets/icons/learning_user/check.svg",width: 20,),
            const SizedBox(width: 10,),
            Flexible(child: Text("บริษัทชั้นนำในการสร้างหลักสูตรการเรียนรู้สำหรับผู้ใหญ่ในประเทศไทยที่มีอัตราการเติบโตสูง"))
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 30,right: 30,top: 10,bottom: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset("assets/icons/learning_user/check.svg",width: 20,),
            const SizedBox(width: 10,),
            Flexible(child: Text("พัฒนาบุคลากรด้วยแนวทางที่สนุกสนานและมีพลัง"))
          ],
        ),
      ),
    ],);
  }
}
