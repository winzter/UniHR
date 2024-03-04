import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:unihr/src/features/manager/overview/domain/entities/entities.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Top5Overtime36 extends StatelessWidget {
  final OvertimeEntity? overtimeData;
  const Top5Overtime36({super.key, this.overtimeData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).devicePixelRatio * 5,
            vertical: MediaQuery.of(context).devicePixelRatio * 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15)),
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
          children: [
            Text(
              "${AppLocalizations.of(context)!.top5otover36hrs}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            if (overtimeData != null &&
                overtimeData!
                    .employeeOtOver36Total!.top5EmployeeOver36!.isNotEmpty) ...[
              ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: overtimeData!
                    .employeeOtOver36Total!.top5EmployeeOver36!.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: badges.Badge(
                          position: badges.BadgePosition.topEnd(top: -15),
                          badgeStyle: badges.BadgeStyle(
                              padding: EdgeInsets.all(10),
                              badgeColor: (index > 2)
                                  ? Color(0xffEEAC19)
                                  : Color(0xffFF364B)),
                          badgeContent: Text(
                            "${index + 1}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                          ),
                          child: CircleAvatar(
                            radius: 22,
                            backgroundColor: Color(0xffc4c4c4),
                            child: Icon(
                              Icons.person,
                              size: 35,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        title: Text(
                          "${overtimeData!.employeeOtOver36Total!.top5EmployeeOver36![index].firstnameTh} ${overtimeData!.employeeOtOver36Total!.top5EmployeeOver36![index].lastnameTh}",
                          style: TextStyle(fontSize: 16),
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          "${overtimeData!.employeeOtOver36Total!.top5EmployeeOver36![index].over36Total} ${AppLocalizations.of(context)!.timesss}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xffFF364B)),
                        ),
                      ),
                      if (overtimeData!.employeeOtOver36Total!
                                  .top5EmployeeOver36!.length -
                              index !=
                          1)
                        Divider(
                          thickness: 1,
                          endIndent: 25,
                          indent: 25,
                        )
                    ],
                  );
                },
              )
            ] else ...[
              Padding(
                padding: const EdgeInsets.all(30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      "${AppLocalizations.of(context)!.nootover36hrs}",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
