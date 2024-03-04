import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:unihr/src/features/user/working_record/presentation/pages/map_page.dart';
import '../../../../../core/features/profile/presentation/provider/profile_provider.dart';
import '../bloc/WorkRecord_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WorkRecordBody extends StatelessWidget {
  final WorkRecordBloc workRecordBloc;
  WorkRecordBody({super.key, required this.workRecordBloc});

  @override
  Widget build(BuildContext context) {
    final ProfileProvider profileProvider = Provider.of<ProfileProvider>(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "${AppLocalizations.of(context)!.hello}...",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: Colors.blueGrey),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).devicePixelRatio * 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  AppLocalizations.of(context)!.hello == "Hello"
                      ? "${profileProvider.profileData.firstnameEn ?? "ไม่ระบุ"} ${profileProvider.profileData.lastnameEn ?? "ไม่ระบุ"}"
                      : "${profileProvider.profileData.firstnameTh ?? "ไม่ระบุ"} ${profileProvider.profileData.lastnameTh ?? "ไม่ระบุ"}",
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              )
            ],
          ),
        ),
        BlocBuilder<WorkRecordBloc, WorkRecordState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).devicePixelRatio * 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (state.isCheckInData != null) ...[
                    state.isCheckInData!.checkIn == 0
                        ? RecordButton(
                            title:
                                '${AppLocalizations.of(context)!.savestartingpoint}',
                            color: Color(0xff87DC45),
                            context: context,
                            isCheck: true,
                            bloc: workRecordBloc,
                            idEmp: profileProvider.profileData.idEmployees!,
                          )
                        : RecordButton(
                            title:
                                '${AppLocalizations.of(context)!.savetheendpoint}',
                            color: Color(0xffDC4545),
                            context: context,
                            isCheck: false,
                            bloc: workRecordBloc,
                            idEmp: profileProvider.profileData.idEmployees!,
                          ),
                  ]
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

Widget RecordButton({
  required int idEmp,
  required WorkRecordBloc bloc,
  required String title,
  required Color color,
  required BuildContext context,
  required bool isCheck,
}) {
  return ElevatedButton(
      onPressed: () {
        Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.leftToRight,
              child: MapPage(
                isCheck: isCheck,
              ),
            )).then((value) => bloc.add(GetIsCheckIn(idEmp: idEmp)));
      },
      style: ElevatedButton.styleFrom(backgroundColor: color),
      child: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.logout_sharp,
              color: Colors.white,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: TextStyle(fontSize: 19, color: Colors.white),
            )
          ],
        ),
      ));
}
