import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../../../../../injection_container.dart';
import '../../../../../core/features/profile/presentation/provider/profile_provider.dart';
import '../../domain/entities/entities.dart';
import '../bloc/leave_bloc.dart';
import '../widgets/appbar.dart';
import 'success_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ConfirmPage extends StatelessWidget {
  final LeaveBloc bloc = sl<LeaveBloc>();
  final List<HolidayLeaveEntity> holidayLeaveEntity;
  final String? holiday;
  final bool isFullDay;
  final double used;
  final double leaveCalHour;
  final DateTime start;
  final DateTime end;
  final LeaveAvailableEntity leaveType;
  final String? ccMail;
  final String? note;
  final List<LeaveAvailableEntity> data;
  // final List<double> remaining;
  final FilePickerResult? filePath;
  final PlatformFile? file;

  ConfirmPage({
    super.key,
    required this.data,
    required this.start,
    required this.end,
    required this.leaveType,
    required this.note,
    required this.used,
    required this.leaveCalHour,
    required this.isFullDay,
    required this.filePath,
    required this.file,
    required this.ccMail,
    required this.holidayLeaveEntity,
    required this.holiday,
  });

  Widget show({
    required PlatformFile file,
    required BuildContext context,
  }) {
    return buildFile(file, context);
  }

  Widget buildFile(PlatformFile file, BuildContext context) {
    return Container(
      child: InkWell(
          onTap: () => null,
          child: Column(
            children: [
              (file.extension == 'jpg' || file.extension == 'png')
                  ? Image.file(
                      File(file.path.toString()),
                      // width: MediaQuery.of(context).size.width,
                      // height: 80,
                    )
                  : Container(
                      width: 80,
                      height: 80,
                    ),
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    ProfileProvider profileData = Provider.of<ProfileProvider>(context, listen: false);
    // print("idManagerLV1 : ${profileData.profileData.idManagerLv1}");
    var leaveRemainNotUsed =
        ((leaveType.carryRemain ?? 0) + (leaveType.leaveRemain ?? 999));
    var leaveRemain = leaveRemainNotUsed -
        (leaveType.isLeaveCompensate == 1 ? leaveCalHour : used);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(context),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).devicePixelRatio * 10,
              horizontal: MediaQuery.of(context).devicePixelRatio * 10),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).devicePixelRatio * 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${AppLocalizations.of(context)!.type} :",
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.w400),
                    ),
                    Flexible(
                      child: Text(
                        leaveType.name!,
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey.shade500),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).devicePixelRatio * 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${AppLocalizations.of(context)!.startdate} :",
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.w400),
                    ),
                    Flexible(
                      child: Text(
                        DateFormat("dd/MM/yyyy").format(start),
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey.shade500),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: !isFullDay,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).devicePixelRatio * 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${AppLocalizations.of(context)!.start_time} :",
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.w400),
                      ),
                      Flexible(
                        child: Text(
                          DateFormat("HH : mm").format(start),
                          style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey.shade500),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).devicePixelRatio * 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${AppLocalizations.of(context)!.enddate}:",
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.w400),
                    ),
                    Flexible(
                      child: Text(
                        DateFormat("dd/MM/yyyy").format(end),
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey.shade500),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: !isFullDay,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).devicePixelRatio * 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${AppLocalizations.of(context)!.end_time} :",
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.w400),
                      ),
                      Flexible(
                        child: Text(
                          DateFormat("HH : mm").format(end),
                          style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).devicePixelRatio * 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${AppLocalizations.of(context)!.totalDays} :",
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.w400),
                    ),
                    Flexible(
                      child: Text(
                        "${used.toStringAsFixed(2)} ${AppLocalizations.of(context)!.day} (${isFullDay ? leaveCalHour.toStringAsFixed(2) : (leaveCalHour).toStringAsFixed(2)} ${AppLocalizations.of(context)!.hour})",
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey.shade500),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).devicePixelRatio * 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${AppLocalizations.of(context)!.remainingrights} :",
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.w400),
                    ),
                    if (leaveType.isLeaveAnnual == 1) ...[
                      (leaveRemainNotUsed <= 0)
                          ? (leaveRemainNotUsed < 0
                              ? Text(
                                  "${AppLocalizations.of(context)!.leaverightsarenotenough}",
                                  style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.red))
                              : Text(
                                  "${leaveRemainNotUsed.toStringAsFixed(2)} วัน",
                                  style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey.shade500)))
                          : Text(
                              "$leaveRemainNotUsed ${leaveType.isLeaveCompensate == 1 ? AppLocalizations.of(context)!.hour : AppLocalizations.of(context)!.day}",
                              style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey.shade500))
                    ] else ...[
                      (leaveRemainNotUsed) < 0
                          ? Flexible(
                              child: Text(
                                "${AppLocalizations.of(context)!.leaverightsarenotenough}",
                                style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.red),
                              ),
                            )
                          : Text(
                              leaveRemainNotUsed > 100
                                  ? '${AppLocalizations.of(context)!.unlimited}'
                                  : "${(leaveRemainNotUsed).toStringAsFixed(2)} ${leaveType.isLeaveCompensate == 1 ? AppLocalizations.of(context)!.hour : AppLocalizations.of(context)!.day}",
                              style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey.shade500),
                            )
                    ],
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).devicePixelRatio * 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${AppLocalizations.of(context)!.remainingrightsafterrequestingleave} :",
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.w400),
                    ),
                    if (leaveType.isLeaveAnnual == 1) ...[
                      (leaveRemain <= 0)
                          ? (leaveRemain < 0
                              ? Text(
                                  "${AppLocalizations.of(context)!.leaverightsarenotenough}",
                                  style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.red))
                              : Text(
                                  "${leaveRemain.toStringAsFixed(2)} ${leaveType.isLeaveCompensate == 1 ? AppLocalizations.of(context)!.hour : AppLocalizations.of(context)!.day}",
                                  style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey.shade500)))
                          : Text(
                              "$leaveRemain ${AppLocalizations.of(context)!.day}",
                              style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey.shade500))
                    ] else ...[
                      leaveRemain < 0
                          ? Flexible(
                              child: Text(
                                "${AppLocalizations.of(context)!.leaverightsarenotenough}",
                                style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.red),
                              ),
                            )
                          : Text(
                              leaveRemain > 100
                                  ? '${AppLocalizations.of(context)!.unlimited}'
                                  : "${(leaveRemain).toStringAsFixed(2)} ${leaveType.isLeaveCompensate == 1 ? AppLocalizations.of(context)!.hour : AppLocalizations.of(context)!.day}",
                              style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey.shade500),
                            )
                    ],
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).devicePixelRatio * 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${AppLocalizations.of(context)!.description} :",
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.w400),
                    ),
                    Flexible(
                      child: Text(
                        note != null ? note! : "-",
                        softWrap: true,
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey.shade500),
                      ),
                    ),
                  ],
                ),
              ),
              if (holiday != null) ...[
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).devicePixelRatio * 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${AppLocalizations.of(context)!.dayoff} :",
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.w400),
                      ),
                      Flexible(
                        child: Text(
                          holiday!,
                          softWrap: true,
                          style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey.shade500),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).devicePixelRatio * 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 40,
                      child: Text(
                        "${AppLocalizations.of(context)!.attachfile} :",
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.w400),
                      ),
                    ),
                    Expanded(
                      flex: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                            child: Text(
                              filePath == null
                                  ? "-"
                                  : filePath!.files.first.name.toString(),
                              softWrap: true,
                              style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (file != null) ...[
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).devicePixelRatio * 5),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    // height: 100,
                    child: show(file: file!, context: context),
                  ),
                ),
              ],
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).devicePixelRatio * 30,
                    bottom: MediaQuery.of(context).devicePixelRatio * 10),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 5,
                        backgroundColor: leaveRemain < 0
                            ? const Color(0xffC4C4C4)
                            : const Color(0xffE793B8)),
                    onPressed: () {
                      if (leaveRemain >= 0) {
                        ProfileProvider profileData =
                            Provider.of<ProfileProvider>(context,
                                listen: false);
                        bloc.add(SendLeaveRequestData(
                          idManager: profileData.profileData.idManagerLv1,
                          idManagerGroup: profileData.profileData.idManagerGroupLv1,
                          idHoliday: holiday != null
                              ? holidayLeaveEntity
                                  .firstWhere((e) => e.name == holiday!)
                                  .idHoliday
                              : null,
                          idEmployees: profileData.profileData.idEmployees!,
                          isFullDay: isFullDay,
                          leaveType: leaveType,
                          startDay: start,
                          endDay: end,
                          note: note,
                          file: filePath,
                          used: double.parse(leaveType.isLeaveCompensate == 1
                              ? leaveCalHour.toStringAsFixed(2)
                              : used.toStringAsFixed(2)),
                          remaining:
                              double.parse(leaveRemain.toStringAsFixed(2)),
                          context: context,
                          managerEmail: ccMail,
                          holidayLeave: holidayLeaveEntity,
                        ));
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: SuccessPage(
                                  bloc: bloc,
                                  isFullDay: isFullDay,
                                )));
                      }
                    },
                    child: Text(
                      "${AppLocalizations.of(context)!.confirm}",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
