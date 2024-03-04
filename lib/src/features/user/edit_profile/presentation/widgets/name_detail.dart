import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/features/profile/presentation/provider/profile_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NameDetail extends StatelessWidget {
  const NameDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    return Consumer(builder: (context, ProfileProvider data, child) {
      return Positioned(
        top: 70, // 70 default
        left: 0,
        right: 0,
        child: Column(
          children: [
            if (profileProvider.profileData.imageProfile != null) ...[
              Center(
                child: Container(
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
                    radius: 55,
                    backgroundColor: Color(0xffc4c4c4),
                    backgroundImage: NetworkImage(
                        "${profileProvider.profileData.imageProfile}"),
                  ),
                ),
              ),
            ] else ...[
              Center(
                child: Container(
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
                    radius: 55,
                    backgroundColor: Color(0xffc4c4c4),
                    child: Icon(
                      Icons.person,
                      size: 70,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              // width: 170,
              child: Text(
                AppLocalizations.supportedLocales == "th"
                    ? "${data.profileData.titleTh} ${data.profileData.firstnameTh} ${data.profileData.lastnameTh}"
                    : "${data.profileData.titleEn} ${data.profileData.firstnameEn} ${data.profileData.lastnameEn}",
                // "นาง นงรักษ์ ฉิมวัย",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
