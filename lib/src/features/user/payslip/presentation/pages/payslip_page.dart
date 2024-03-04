import 'package:flutter/material.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:provider/provider.dart';
import '../../../../../core/error/token_expires.dart';
import '../../../../../core/features/profile/presentation/provider/profile_provider.dart';
import '../provider/payslip_provider.dart';
import '../widgets/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PaySlipPage extends StatefulWidget {
  const PaySlipPage({super.key});
  @override
  State<PaySlipPage> createState() => _PaySlipPageState();
}

class _PaySlipPageState extends State<PaySlipPage> {
  PageController pageController = PageController(initialPage: 0);
  late GetPayslipProvider payslipProvider;

  @override
  void initState() {
    super.initState();
    TokenExpires.checkTokenExpires(context);
    payslipProvider = GetPayslipProvider.of(context, listen: false);
    payslipProvider.getPayslipData();
  }

  @override
  Widget build(BuildContext context) {
    final data = context.watch<GetPayslipProvider>();
    final ProfileProvider profileData = Provider.of<ProfileProvider>(context);
    bool isAvailable = data.payslipData != null && data.payslipData!.isNotEmpty;
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
          scrolledUnderElevation: 0,
          elevation: 0,
          toolbarHeight: 70,
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context)!.salaryslip,
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.w500, color: Colors.white),
          ),
          leading: IconButton(
              onPressed: () {
                if (profileData.isPayslipValidate) {
                  Navigator.pop(context);
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                }
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
        ),
        body: RefreshIndicator(
          onRefresh: ()async{
            payslipProvider.getPayslipData();
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const DropdownYear(),
                  const SizedBox(
                    height: 5,
                  ),
                  ExpandablePageView.builder(
                    controller: pageController,
                    physics: const BouncingScrollPhysics(),
                    itemCount: data.months.length,
                    onPageChanged: (index) {
                      data.setIndex(index);
                      data.setMonth(data.months[data.currentPageIndex]);
                      payslipProvider.getPayslipData();
                    },
                    itemBuilder: (context, index) {
                      return CardList(
                        index: index,
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "${AppLocalizations.of(context)!.retainedincome} - ${data.month} - ${data.year}",
                          style: TextStyle(
                              fontSize: 17,
                              color: const Color(0xff275F77),
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                  if (isAvailable) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            BenefitBox(
                              title:
                                  AppLocalizations.of(context)!.accumulatedincome,
                              total:
                                  (data.payslipData![0].accumulateEarnings ?? 0),
                              profit1:
                                  (data.payslipData![0].accumulateEarnings ?? 0) -
                                      (data.payslipData![0].totalEarnings ?? 0),
                              profit2: (data.payslipData![0].totalEarnings ?? 0),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            BenefitBox(
                                title: AppLocalizations.of(context)!
                                    .accumulatedwithholdingtax,
                                total: data.payslipData![0].accumulateTax ?? 0)
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            BenefitBox(
                                title: AppLocalizations.of(context)!
                                    .calculateprovidentfund,
                                total: (data.payslipData![0].accumulatePf ?? 0),
                                profit1:
                                    (data.payslipData![0].accumulatePf ?? 0) -
                                        (data.deductionPF.value ?? 0),
                                profit2: (data.deductionPF.value ?? 0))
                          ],
                        ),
                        Column(
                          children: [
                            BenefitBox(
                                title: AppLocalizations.of(context)!
                                    .accumulatedsocialsecurity,
                                total: (data.payslipData![0].accumulateSso ?? 0),
                                profit1:
                                    (data.payslipData![0].accumulateSso ?? 0) -
                                        (data.deductionSSO.value ?? 0),
                                profit2: (data.deductionSSO.value ?? 0))
                          ],
                        )
                      ],
                    ),
                  ] else ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            BenefitBox(
                                title: AppLocalizations.of(context)!
                                    .accumulatedincome,
                                total: 0)
                          ],
                        ),
                        Column(
                          children: [
                            BenefitBox(
                                title: AppLocalizations.of(context)!
                                    .accumulatedwithholdingtax,
                                total: 0)
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            BenefitBox(
                                title: AppLocalizations.of(context)!
                                    .calculateprovidentfund,
                                total: 0)
                          ],
                        ),
                        Column(
                          children: [
                            BenefitBox(
                                title: AppLocalizations.of(context)!
                                    .accumulatedsocialsecurity,
                                total: 0)
                          ],
                        )
                      ],
                    ),
                  ],
                  const SizedBox(
                    height: 10,
                  ),
                  // isAvailable
                  //     ? DownloadButton(
                  //         data: data.payslipData![0],
                  //       )
                  //     :
                  Container(),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
