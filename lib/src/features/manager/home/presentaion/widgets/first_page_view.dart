import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../core/features/profile/presentation/provider/profile_provider.dart';

class FirstPageView extends StatefulWidget {
  const FirstPageView({super.key});

  @override
  State<FirstPageView> createState() => _FirstPageViewState();
}

class _FirstPageViewState extends State<FirstPageView> {
  @override
  Widget build(BuildContext context) {
    final managerProfileProvider = Provider.of<ProfileProvider>(context);
    return Align(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (managerProfileProvider.isLoading) ...[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        enabled: true,
                        child: Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: CircleAvatar(
                            radius: 45,
                            backgroundColor: Color(0xffc4c4c4),
                          ),
                        )),
                  ),
                ]
                else if (managerProfileProvider.profileData.imageProfile != null) ...[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                          "${managerProfileProvider.profileData.imageProfile}"),
                    ),
                  )
                ]
                else ...[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const CircleAvatar(
                      radius: 40,
                      backgroundColor: Color(0xffc4c4c4),
                      child: Icon(
                        Icons.person,
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('EE dd MMM yy').format(DateTime.now()),
                        style: GoogleFonts.kanit(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      Text(
                        "${AppLocalizations.of(context)!.hello}, ${AppLocalizations.of(context)!.hello == "Hello" ? managerProfileProvider.profileData.firstnameEn ?? 'ไม่ระบุ' : managerProfileProvider.profileData.firstnameTh ?? 'ไม่ระบุ'} "
                        "${AppLocalizations.of(context)!.hello == "Hello" ? managerProfileProvider.profileData.lastnameEn ?? 'ไม่ระบุ' : managerProfileProvider.profileData.lastnameTh ?? 'ไม่ระบุ'}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: false,
                        style: GoogleFonts.kanit(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
