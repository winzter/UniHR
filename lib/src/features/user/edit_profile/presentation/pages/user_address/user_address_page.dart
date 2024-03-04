import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../core/features/profile/presentation/provider/profile_provider.dart';
import '../../widgets/shimmer_profile.dart';
import '../../widgets/user_address_widgets/reuse_more_lines.dart';
import '../../widgets/user_address_widgets/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserAddress extends StatefulWidget {
  const UserAddress({super.key});

  @override
  State<UserAddress> createState() => _UserAddressState();
}

class _UserAddressState extends State<UserAddress> {
  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context, listen: true);
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 150),
        child: Column(
          children: [
            profileProvider.isLoading
                ? Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: ShimmerProfile(
                        width: MediaQuery.of(context).size.width, height: 270),
                  )
                : ReuseMoreLinesBox(
                    title: AppLocalizations.of(context)!.current_address,
                    detail_1: AppLocalizations.of(context)!.houseno,
                    detail_2: AppLocalizations.of(context)!.village,
                    detail_3: AppLocalizations.of(context)!.villageno,
                    detail_4: AppLocalizations.of(context)!.alley,
                    detail_5: AppLocalizations.of(context)!.road,
                    detail_6: AppLocalizations.of(context)!.subdistrict,
                    detail_7: AppLocalizations.of(context)!.district,
                    detail_8: AppLocalizations.of(context)!.province,
                    detail_9: AppLocalizations.of(context)!.areacode,
                    data_1: profileProvider.houseNo ??
                        '${AppLocalizations.of(context)!.notspecified}',
                    data_2: profileProvider.village ??
                        '${AppLocalizations.of(context)!.notspecified}',
                    data_3: profileProvider.villageNo ??
                        '${AppLocalizations.of(context)!.notspecified}',
                    data_4: profileProvider.alley ??
                        '${AppLocalizations.of(context)!.notspecified}',
                    data_5: profileProvider.road ??
                        '${AppLocalizations.of(context)!.notspecified}',
                    data_6: profileProvider.subDistrict ??
                        '${AppLocalizations.of(context)!.notspecified}',
                    data_7: profileProvider.district ??
                        '${AppLocalizations.of(context)!.notspecified}',
                    data_8: profileProvider.province ??
                        '${AppLocalizations.of(context)!.notspecified}',
                    data_9: profileProvider.areaCode ??
                        '${AppLocalizations.of(context)!.notspecified}',
                  ),
            if (profileProvider.profileData.educations == null) ...[
              profileProvider.isLoading
                  ? Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: ShimmerProfile(
                          width: MediaQuery.of(context).size.width,
                          height: 150),
                    )
                  : EducationDetail(
                      title: AppLocalizations.of(context)!.educationinfo,
                      degree: "-",
                      university:
                          "(- ${AppLocalizations.of(context)!.to} -) ${AppLocalizations.of(context)!.notspecifiedschool}",
                      faculty: "${AppLocalizations.of(context)!.faculty} -",
                      major: "${AppLocalizations.of(context)!.major} -",
                      grade: "-")
            ] else ...[
              profileProvider.isLoading
                  ? Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: ShimmerProfile(
                          width: MediaQuery.of(context).size.width,
                          height: 150),
                    )
                  : EducationDetail(
                      title: AppLocalizations.of(context)!.educationinfo,
                      degree:
                          "${profileProvider.profileData.educations!.isNotEmpty ? profileProvider.profileData.educations![0].degree : '${AppLocalizations.of(context)!.notspecified}'}",
                      university:
                          "(${profileProvider.profileData.educations!.isNotEmpty ? profileProvider.profileData.educations![0].fromYear : '-'} ${AppLocalizations.of(context)!.to} ${profileProvider.profileData.educations!.isNotEmpty ? profileProvider.profileData.educations![0].endYear : '-'}) ${profileProvider.profileData.educations!.isNotEmpty ? profileProvider.profileData.educations![0].university : '${AppLocalizations.of(context)!.notspecifiedschool}'}",
                      faculty:
                          "${profileProvider.profileData.educations!.isNotEmpty ? profileProvider.profileData.educations![0].faculty : '${AppLocalizations.of(context)!.notspecified}'}",
                      major:
                          "${profileProvider.profileData.educations!.isNotEmpty ? profileProvider.profileData.educations![0].major : '${AppLocalizations.of(context)!.notspecified}'}",
                      grade:
                          "${profileProvider.profileData.educations!.isNotEmpty ? profileProvider.profileData.educations![0].gpa : '${AppLocalizations.of(context)!.notspecified}'}")
            ]
          ],
        ),
      ),
    );
  }
}
