import 'package:flutter/material.dart';
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
    final profileProvider = Provider.of<ProfileProvider>(context);
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (profileProvider.isLoading) ...[
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
                  ] else if (profileProvider.profileData.imageProfile !=
                      null) ...[
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
                        radius: 45,
                        backgroundImage: NetworkImage(
                            "${profileProvider.profileData.imageProfile}"),
                      ),
                    ),
                  ] else ...[
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
                        radius: 45,
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
                        profileProvider.isLoading
                            ? Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                enabled: true,
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  height: 20,
                                  decoration: ShapeDecoration(
                                      color: Colors.grey,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5))),
                                ))
                            : Text(
                                DateFormat('EE dd MMM yy')
                                    .format(DateTime.now()),
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.02,
                        ),
                        profileProvider.isLoading
                            ? Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                enabled: true,
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  height: 20,
                                  decoration: ShapeDecoration(
                                      color: Colors.grey,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5))),
                                ))
                            : AppLocalizations.of(context)!.hello == 'Hello'
                                ? Text(
                                    "${AppLocalizations.of(context)!.hello}, ${profileProvider.profileData.firstnameEn ?? 'ไม่ระบุ'} "
                                    "${profileProvider.profileData.lastnameEn ?? 'ไม่ระบุ'}",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    softWrap: false,
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  )
                                : Text(
                                    "${AppLocalizations.of(context)!.hello}, ${profileProvider.profileData.firstnameTh ?? 'ไม่ระบุ'} "
                                    "${profileProvider.profileData.lastnameTh ?? 'ไม่ระบุ'}",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    softWrap: false,
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
