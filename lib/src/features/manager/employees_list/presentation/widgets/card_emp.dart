import 'package:flutter/material.dart';
import '../../domain/entities/employees_list_entity.dart';
import '../pages/emp_detail_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CardEmp extends StatelessWidget {
  final EmployeesListEntity empData;

  CardEmp({super.key, required this.empData});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  EmpDetailPage(idEmp: empData.idEmployees!, empData: empData),
            ));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Color(0xffc4c4c4),
                child: Icon(
                  Icons.person,
                  size: 60,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "${AppLocalizations.of(context)!.hello == "Hello" ? empData.firstnameEn ?? AppLocalizations.of(context)!.notspecified : empData.firstnameTh ?? '${AppLocalizations.of(context)!.notspecified}'}\n${AppLocalizations.of(context)!.hello == "Hello" ? empData.lastnameEn ?? '${AppLocalizations.of(context)!.notspecified}' : empData.lastnameTh ?? '${AppLocalizations.of(context)!.notspecified}'}",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              AppLocalizations.supportedLocales == "th"
                  ? "${empData.positionName ?? '${AppLocalizations.of(context)!.notspecified}'}"
                  : "${empData.positionName_EN ?? '${AppLocalizations.of(context)!.notspecified}'}",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              AppLocalizations.supportedLocales == "th"
                  ? "${empData.sectionName ?? '${AppLocalizations.of(context)!.notspecified}'}"
                  : "${empData.sectionName_EN ?? '${AppLocalizations.of(context)!.notspecified}'}",
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xff757575)),
            ),
          ],
        ),
      ),
    );
  }
}
