import 'package:flutter/material.dart';
import 'package:unihr/src/features/manager/employees_list/domain/entities/each_emp_entity.dart';

import '../../widgets/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EmpEducationPage extends StatelessWidget {
  final EachEmployeeEntity empData;

  const EmpEducationPage({super.key, required this.empData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            if (empData.educations == null) ...[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: EducationDetail(
                    title: "${AppLocalizations.of(context)!.educationinfo}",
                    university:
                        "(- ${AppLocalizations.of(context)!.to} -) ${AppLocalizations.of(context)!.notspecifiedschool}",
                    faculty:
                        "${AppLocalizations.of(context)!.major} -, ${AppLocalizations.of(context)!.faculty} -, ${AppLocalizations.of(context)!.educationdegree} -",
                    grade: "-"),
              )
            ] else ...[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: EducationDetail(
                    title: "${AppLocalizations.of(context)!.educationinfo}",
                    university:
                        "(${empData.educations!.isNotEmpty ? empData.educations![0].fromYear : '-'} ${AppLocalizations.of(context)!.to} ${empData.educations!.isNotEmpty ? empData.educations![0].endYear : '-'}) ${empData.educations!.isNotEmpty ? empData.educations![0].university : '${AppLocalizations.of(context)!.notspecifiedschool}'}",
                    faculty:
                        "${AppLocalizations.of(context)!.major} ${empData.educations!.isNotEmpty ? empData.educations![0].major : '${AppLocalizations.of(context)!.notspecified}'}, ${AppLocalizations.of(context)!.faculty} ${empData.educations!.isNotEmpty ? empData.educations![0].faculty : '${AppLocalizations.of(context)!.notspecified}'}, ${AppLocalizations.of(context)!.educationdegree} ${empData.educations!.isNotEmpty ? empData.educations![0].degree : '${AppLocalizations.of(context)!.notspecified}'}",
                    grade:
                        "${empData.educations!.isNotEmpty ? empData.educations![0].gpa : '${AppLocalizations.of(context)!.notspecified}'}"),
              )
            ]
          ],
        ),
      ),
    );
  }
}
