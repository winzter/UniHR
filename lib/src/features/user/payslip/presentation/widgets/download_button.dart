import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../domain/entities/payslip.dart';
import '../pages/payslip_download_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DownloadButton extends StatelessWidget {
  final PayslipEntity data;
  const DownloadButton({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff6FC9E4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      PayslipDownloadPage(payslipData: data)));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ColorFiltered(
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                      child: SvgPicture.asset(
                        "assets/icons/download.svg",
                        width: 35,
                      )),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "${AppLocalizations.of(context)!.downloadsalaryslip}",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white,
              )
            ],
          ),
        ));
  }
}
