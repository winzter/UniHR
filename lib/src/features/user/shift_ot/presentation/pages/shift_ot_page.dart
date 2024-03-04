import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../../core/error/token_expires.dart';
import '../provider/shift_ot_provider.dart';
import '../widgets/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SummaryShiftAndOTPage extends StatefulWidget {
  const SummaryShiftAndOTPage({super.key});
  @override
  State<SummaryShiftAndOTPage> createState() => _SummaryShiftAndOTPageState();
}

class _SummaryShiftAndOTPageState extends State<SummaryShiftAndOTPage>
    with SingleTickerProviderStateMixin {
  late GetShiftAndOTProvider shiftAndOtProvider;
  late TabController tabController1;

  @override
  void initState() {
    super.initState();
    TokenExpires.checkTokenExpires(context);
    shiftAndOtProvider = GetShiftAndOTProvider.of(context, listen: false);
    tabController1 = TabController(length: 12, vsync: this);
    shiftAndOtProvider.monthValue = shiftAndOtProvider.months[shiftAndOtProvider
        .months
        .indexOf(DateFormat('MMMM').format(DateTime.now()))];
    shiftAndOtProvider.yearNum = int.parse(shiftAndOtProvider.value);
    shiftAndOtProvider.getSummaryTime();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/splash.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 70,
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context)!.otandshift,
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.w500, color: Colors.white),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
        ),
        body: const SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              DropdownYear(),
              ShiftAndOTSumCard(),
              GifPics(),
              ShiftAndOTDetailCard()
            ],
          ),
        ),
      ),
    );
  }
}
