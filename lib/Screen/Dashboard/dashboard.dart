import '../../responsive.dart' as res;
import 'package:flutter/material.dart';
import '../Widgets/Topbar/topbar.dart';
import '../Widgets/Constant Data/constant.dart';
import '../Widgets/Sidebar/sidebar_widget.dart';
import '../../model/subscription_plan_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../Provider/subacription_plan_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Widgets/Table Widgets/Dashboard/dashboard_table.dart';
import 'package:salespro_saas_admin/model/seller_info_model.dart';
import '../Widgets/Table Widgets/Total Count/total_count_widget.dart';
import 'package:salespro_saas_admin/Provider/seller_info_provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MtDashboard extends StatefulWidget {
  const MtDashboard({Key? key}) : super(key: key);

  static const String route = '/dashBoard';

  @override
  State<MtDashboard> createState() => _MtDashboardState();
}

class _MtDashboardState extends State<MtDashboard> {
  int numberOfFree = 0;
  int monthly = 0;
  int yearly = 0;
  int newReg = 0;

  void getData() async {
    //var data = await FirebaseDatabase.instance.ref('Admin panel');
  }

  @override
  void initState() {
    getData();
    super.initState();
    for (int i = 0;
        i < DateTime(currentDate.year, currentDate.month + 1, 0).day;
        i++) {
      everyDayOfCurrentMonth.add(0);
    }
    for (int i = 0;
        i < DateTime(currentDate.year, currentDate.month + 1, 0).day;
        i++) {
      everyDay.add(0);
    }
    print('tota in${monthly}');
  }

  int i = 0;

  List<SellerInfoModel> yearlySubscribed = [];
  List<SellerInfoModel> expiredList = [];
  List<SellerInfoModel> todayRegistration = [];
  List<SellerInfoModel> free = [];

  ///____________Incomes___________________________
  List<SubscriptionPlanModel> subOfCurrentYear = [];
  List<SubscriptionPlanModel> subOfCurrentMonth = [];
  List<SubscriptionPlanModel> subOfLastMonth = [];
  List<SubscriptionPlanModel> subOfLastYear = [];
  double totalIncomeOfCurrentYear = 0;
  double totalIncomeOfPreviousYear = 0;
  double totalIncomeOfCurrentMonth = 0;
  List<double> everyMonthOfYear = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  List<int> everyDayOfCurrentMonth = [];
  List<int> everyDay = [];
  double totalIncomeOfLastMonth = 0;
  List<SellerInfoModel> shopList = [];
  List<SellerInfoModel> newUser = [];
  int newUserOfCurrentYear = 0;
  List<double> newUserMonthlyOfCurrentYear = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0
  ];
  List<SellerInfoModel> newUser30Days = [];
  List<SellerInfoModel> previousMonthRegistration = [];

  @override
  Widget build(BuildContext context) {
    i++;
    return Scaffold(
      backgroundColor: kDarkWhite,
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: 240,
              child: SideBarWidget(
                index: 0,
                isTab: false,
              ),
            ),
            Consumer(
              builder: (_, ref, watch) {
                AsyncValue<List<SellerInfoModel>> infoList =
                    ref.watch(sellerInfoProvider);
                AsyncValue<List<SubscriptionPlanModel>> subsList =
                    ref.watch(subscriptionPlanProvider);
                return infoList.when(data: (infoList) {
                  DateTime t = DateTime.now();
                  free = [];
                  if (i == 1) {
                    for (var element in infoList) {
                      if (element.subscriptionName == 'Free') {
                        free.add(element);
                        numberOfFree++;
                      } else if (element.subscriptionName == 'Monthly') {
                        monthly++;
                      } else if (element.subscriptionName == 'Yearly') {
                        yearly++;
                        yearlySubscribed.add(element);
                      }
                      //______________________//////__________

                      final subscriptionDate = DateTime.parse(
                          element.subscriptionDate ??
                              (element.subscriptionDate.toString()));
                      if (subscriptionDate.isAfter(sevenDays)) {
                        newUser.add(element);
                      }
                      if (subscriptionDate.isAfter(firstDayOfCurrentYear)) {
                        newUserOfCurrentYear++;
                        newUserMonthlyOfCurrentYear[
                            subscriptionDate.month - 1]++;
                        if (subscriptionDate.isAfter(firstDayOfCurrentMonth)) {
                          newUser30Days.add(element);
                          everyDayOfCurrentMonth[subscriptionDate.day - 1]++;
                        }
                        if (subscriptionDate.isAfter(firstDayOfPreviousMonth) &&
                            subscriptionDate.isBefore(firstDayOfCurrentMonth)) {
                          previousMonthRegistration.add(element);
                        }
                      }
                      if (DateTime.parse(element.subscriptionDate.toString())
                              .difference(t)
                              .inHours
                              .abs() <=
                          24) {
                        newReg++;
                        todayRegistration.add(element);
                      }
                      if (element.subscriptionName == 'Monthly') {
                        if (DateTime.parse(element.subscriptionDate.toString())
                                .difference(t)
                                .inDays
                                .abs() >=
                            23) {
                          expiredList.add(element);
                        }
                      }
                      if (element.subscriptionName == 'Yearly') {
                        if (DateTime.parse(element.subscriptionDate.toString())
                                .difference(t)
                                .inDays
                                .abs() >=
                            358) {
                          expiredList.add(element);
                        }
                      }
                    }
                  }
                  return subsList.when(data: (subSnap) {
                    subOfCurrentYear = [];
                    subOfCurrentMonth = [];
                    subOfLastMonth = [];
                    subOfLastYear = [];
                    totalIncomeOfCurrentYear = 0;
                    totalIncomeOfPreviousYear = 0;
                    totalIncomeOfCurrentMonth = 0;
                    everyMonthOfYear = List.filled(12, 0);
                    totalIncomeOfLastMonth = 0;
                    shopList = [];

                    for (var element in subSnap) {
                      for (var sub in infoList) {
                        if (element.subscriptionName == sub.subscriptionName) {
                          final subscriptionDate = DateTime.tryParse(
                                  sub.subscriptionDate.toString()) ??
                              DateTime.now();

                          if (subscriptionDate.isAfter(firstDayOfCurrentYear)) {
                            totalIncomeOfCurrentYear +=
                                element.subscriptionPrice;
                            everyMonthOfYear[subscriptionDate.month - 1] +=
                                element.subscriptionPrice;
                            everyDay[subscriptionDate.day - 1] +=
                                element.subscriptionPrice;

                            subOfCurrentYear.add(element);

                            if (subscriptionDate
                                .isAfter(firstDayOfCurrentMonth)) {
                              totalIncomeOfCurrentMonth +=
                                  element.subscriptionPrice;
                              subOfCurrentMonth.add(element);
                            }

                            if (subscriptionDate
                                    .isAfter(firstDayOfPreviousMonth) &&
                                subscriptionDate
                                    .isBefore(firstDayOfCurrentMonth)) {
                              totalIncomeOfLastMonth +=
                                  element.subscriptionPrice;
                              subOfLastMonth.add(element);
                            }
                            if (subscriptionDate
                                    .isAfter(firstDayOfPreviousYear) &&
                                subscriptionDate
                                    .isBefore(firstDayOfCurrentYear)) {
                              totalIncomeOfPreviousYear +=
                                  element.subscriptionPrice;
                              subOfLastYear.add(element);
                            }
                          }
                        }
                      }
                    }
                    return SizedBox(
                      width: MediaQuery.of(context).size.width < 1275
                          ? 1275 - 240
                          : MediaQuery.of(context).size.width - 240,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            //TopBar
                            Container(
                              padding: const EdgeInsets.all(6.0),
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: kWhiteTextColor,
                              ),
                              child: const TopBar(),
                            ),

                            //Counter
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  TotalCount(
                                    icon: MdiIcons.accountGroup,
                                    title: 'Total User',
                                    count: infoList.length.toString(),
                                    backgroundColor: const Color(0xFFFFDFE2),
                                    iconBgColor: const Color(0xFFFF4A72),
                                  ),
                                  const SizedBox(width: 10.0),
                                  TotalCount(
                                    icon: MdiIcons.accountPlus,
                                    title: 'New Registration',
                                    count: newReg.toString(),
                                    backgroundColor: const Color(0xFFFFF3DC),
                                    iconBgColor: const Color(0xFFFFAA06),
                                  ),
                                  const SizedBox(width: 10.0),
                                  TotalCount(
                                    icon: FontAwesomeIcons.trophy,
                                    title: 'Total Customer',
                                    count: numberOfFree.toString(),
                                    backgroundColor: const Color(0xFFCDFFDE),
                                    iconBgColor: const Color(0xFF2EE34D),
                                  ),
                                  const SizedBox(width: 10.0),
                                  // TotalCount(
                                  //   icon: MdiIcons.crown,
                                  //   title: 'Monthly Plan User',
                                  //   count: monthly.toString(),
                                  //   backgroundColor: const Color(0xFFEFE1FF),
                                  //   iconBgColor: const Color(0xFFB671FF),
                                  // ),
                                  // const SizedBox(width: 10.0),
                                  // TotalCount(
                                  //   icon: FontAwesomeIcons.crown,
                                  //   title: 'Yearly User Plan ',
                                  //   count: yearly.toString(),
                                  //   backgroundColor: const Color(0xFFFFE1E1),
                                  //   iconBgColor: const Color(0xFFFF436C),
                                  // ),
                                ],
                              ),
                            ),
                            // Dashboard Table
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20.0, right: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: TopSellingStore(
                                    todayReg: todayRegistration,
                                  )),
                                  const SizedBox(width: 20.0),
                                  Expanded(
                                      child: YearlySubscribed(
                                    lifeTimeSeller: yearlySubscribed,
                                  )),
                                  const SizedBox(width: 20.0),
                                  Expanded(
                                      child:
                                          ExpiredShop(expiredShop: expiredList))
                                ],
                              ),
                            ),
                            //
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: StatisticsData(
                                      totalIncomeCurrentMonths:
                                          totalIncomeOfCurrentMonth,
                                      totalIncomeLastMonth:
                                          totalIncomeOfLastMonth,
                                      totalIncomeCurrentYear:
                                          totalIncomeOfCurrentYear,
                                      allMonthData: everyMonthOfYear,
                                      allDay: everyDay,
                                      totalUser: double.parse(
                                        infoList.length.toString(),
                                      ),
                                      freeUser: double.parse(
                                        free.length.toString(),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20.0),
                                  Expanded(
                                    flex: 2,
                                    child: UserOverView(
                                      currentMonth: double.parse(
                                        totalIncomeOfCurrentYear.toString(),
                                      ),
                                      lastMonth: double.parse(
                                        totalIncomeOfLastMonth.toString(),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),

                            //___________________monthly_______________________________
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0),
                              child: NewRegisteredUser(
                                  allDay: everyDayOfCurrentMonth),
                            ),
                            const SizedBox(height: 20.0),
                          ],
                        ),
                      ),
                    );
                  }, error: (e, stack) {
                    return Center(
                      child: Text(e.toString()),
                    );
                  }, loading: () {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  });
                }, error: (e, stack) {
                  return Center(
                    child: Text(e.toString()),
                  );
                }, loading: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                });
              },
            ),
          ],
        ),
      ),

      // res.Responsive(
      //   mobile: Container(),
      //   tablet: const MtDashboard(),
      //   desktop:
      // ),
    );
  }
}
