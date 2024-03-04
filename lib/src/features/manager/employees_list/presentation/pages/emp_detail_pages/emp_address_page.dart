import 'package:flutter/material.dart';
import 'package:unihr/src/features/manager/employees_list/domain/entities/each_emp_entity.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../widgets/widgets.dart';

class EmpAddressPage extends StatelessWidget {
  final EachEmployeeEntity empData;

  const EmpAddressPage({super.key, required this.empData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: ReuseMoreLinesBox(
                title: "${AppLocalizations.of(context)!.current_address}",
                detail_1: "${AppLocalizations.of(context)!.houseno}",
                detail_2: "${AppLocalizations.of(context)!.village}",
                detail_3: "${AppLocalizations.of(context)!.villageno}",
                detail_4: "${AppLocalizations.of(context)!.alley}",
                detail_5: "${AppLocalizations.of(context)!.road}",
                detail_6: "${AppLocalizations.of(context)!.subdistrict}",
                detail_7: "${AppLocalizations.of(context)!.district}",
                detail_8: "${AppLocalizations.of(context)!.province}",
                detail_9: "${AppLocalizations.of(context)!.areacode}",
                data_1: empData.houseNo ??
                    "${AppLocalizations.of(context)!.notspecified}",
                data_2: empData.village ??
                    "${AppLocalizations.of(context)!.notspecified}",
                data_3: empData.villageNo ??
                    "${AppLocalizations.of(context)!.notspecified}",
                data_4: empData.alley ??
                    "${AppLocalizations.of(context)!.notspecified}",
                data_5: empData.road ??
                    "${AppLocalizations.of(context)!.notspecified}",
                data_6: empData.subDistrict ??
                    "${AppLocalizations.of(context)!.notspecified}",
                data_7: empData.district ??
                    "${AppLocalizations.of(context)!.notspecified}",
                data_8: empData.provience ??
                    "${AppLocalizations.of(context)!.notspecified}",
                data_9: empData.areaCode ??
                    "${AppLocalizations.of(context)!.notspecified}",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
