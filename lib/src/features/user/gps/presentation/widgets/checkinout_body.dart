import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../core/features/profile/presentation/provider/profile_provider.dart';

class CheckInOutBody extends StatelessWidget {
  const CheckInOutBody({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileProvider profileProvider =
        Provider.of<ProfileProvider>(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.hello + "...",
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                AppLocalizations.of(context)!.hello == 'Hello'
                    ? "${profileProvider.profileData.firstnameEn ?? "ไม่ระบุ"} ${profileProvider.profileData.lastnameEn ?? "ไม่ระบุ"}"
                    : "${profileProvider.profileData.firstnameTh ?? "ไม่ระบุ"} ${profileProvider.profileData.lastnameTh ?? "ไม่ระบุ"}",
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.workinglocationplace,
              style: TextStyle(
                fontSize: 17,
                color: Colors.blueGrey,
              ),
            )
          ],
        ),
      ],
    );
  }
}
