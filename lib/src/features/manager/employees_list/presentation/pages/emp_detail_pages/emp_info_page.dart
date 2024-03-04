import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unihr/src/features/manager/employees_list/domain/entities/each_emp_entity.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../widgets/widgets.dart';

class EmpInfoPage extends StatelessWidget {
  final EachEmployeeEntity empData;
  const EmpInfoPage({super.key, required this.empData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.transparent),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(2, 3),
                      ),
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          AppLocalizations.supportedLocales == "th"
                              ? "${empData.positionName ?? '${AppLocalizations.of(context)!.notspecified}'}"
                              : "${empData.positionName_EN ?? '${AppLocalizations.of(context)!.notspecified}'}",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                            empData.companyName ??
                                "${AppLocalizations.of(context)!.notspecified}",
                            style: TextStyle(
                                fontSize: 16, color: const Color(0xff757575))),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                            AppLocalizations.of(context)!.startwork +
                                DateFormat(' dd MMM yyyy').format(
                                    empData.hiringDate ?? DateTime.now()),
                            style: TextStyle(
                                fontSize: 16, color: const Color(0xffC4C4C4))),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Reuse3LinesBox(
                title: "${AppLocalizations.of(context)!.emergencycontact}",
                detail_1: "${AppLocalizations.of(context)!.contactname}",
                detail_2:
                    "${AppLocalizations.of(context)!.emergencyrelationship}",
                detail_3: "${AppLocalizations.of(context)!.emergencyphone}",
                data_1: empData.emergencyContact ??
                    "${AppLocalizations.of(context)!.notspecified}",
                data_2: empData.emergencyRelationship ??
                    "${AppLocalizations.of(context)!.notspecified}",
                data_3: empData.emergencyPhone ??
                    "${AppLocalizations.of(context)!.notspecified}",
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Reuse3LinesBox(
                title: "${AppLocalizations.of(context)!.employeeinformation}",
                detail_1: "${AppLocalizations.of(context)!.employeeid}",
                detail_2: "${AppLocalizations.of(context)!.personalid}",
                detail_3: "${AppLocalizations.of(context)!.birthdate}",
                data_1: empData.employeeId ??
                    "${AppLocalizations.of(context)!.notspecified}",
                data_2: empData.personalId ??
                    "${AppLocalizations.of(context)!.notspecified}",
                data_3: DateFormat('dd MMMM yyyy')
                    .format(empData.birthday ?? DateTime.now()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 15),
              child: Reuse2LinesBox(
                  title: "${AppLocalizations.of(context)!.contact}",
                  detail_1: "${AppLocalizations.of(context)!.emergencyphone}",
                  detail_2: "${AppLocalizations.of(context)!.email}",
                  data_1: empData.telephoneMobile ??
                      "${AppLocalizations.of(context)!.notspecified}",
                  data_2: empData.email ??
                      "${AppLocalizations.of(context)!.notspecified}"),
            ),
          ],
        ),
      ),
    );
  }
}
