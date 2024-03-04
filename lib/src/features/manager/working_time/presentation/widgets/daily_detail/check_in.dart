import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../domain/entities/entities.dart';
import 'check_location.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CheckIn extends StatelessWidget {
  final List<EmployeesAttendanceEntity> empAttendance;
  final bool isCheckIn;

  const CheckIn(
      {super.key, required this.empAttendance, required this.isCheckIn});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: isCheckIn ? Color(0xff30B98F) : Color(0xffE46A76),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10.0),
                  topLeft: Radius.circular(10.0)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isCheckIn
                      ? "${AppLocalizations.of(context)!.clockin}"
                      : "${AppLocalizations.of(context)!.clockout}",
                  style: GoogleFonts.kanit(color: Colors.white, fontSize: 17),
                ),
                Text(
                  "${empAttendance.length} ${AppLocalizations.of(context)!.person}",
                  style: GoogleFonts.kanit(color: Colors.white, fontSize: 17),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0)),
                ),
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: empAttendance.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(
                              leading: const CircleAvatar(
                                radius: 22,
                                backgroundColor: Color(0xffc4c4c4),
                                child: Icon(
                                  Icons.person,
                                  size: 35,
                                  color: Colors.white,
                                ),
                              ),
                              title: Text(
                                "${empAttendance[index].firstnameTh} ${empAttendance[index].lastnameTh}",
                                style: GoogleFonts.kanit(),
                              ),
                              subtitle: SizedBox(
                                  width: 100,
                                  child: Text(
                                    "${empAttendance[index].positionName}",
                                    style: GoogleFonts.kanit(
                                        color: Color(0xff757575)),
                                    overflow: TextOverflow.ellipsis,
                                  )),
                              trailing: CheckInStatus(
                                data: empAttendance[index],
                                isCheckIn: isCheckIn,
                              )),
                          const Divider(
                            indent: 20,
                            endIndent: 20,
                          )
                        ],
                      );
                    })),
          ),
        ],
      ),
    );
  }
}
