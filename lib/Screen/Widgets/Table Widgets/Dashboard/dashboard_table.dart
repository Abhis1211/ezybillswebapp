// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pie_chart/pie_chart.dart' as pie;
import 'package:salespro_saas_admin/Screen/Widgets/Constant%20Data/constant.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../model/seller_info_model.dart';

//Top Selling Store
class TopSellingStore extends StatelessWidget {
  const TopSellingStore({Key? key, required this.todayReg}) : super(key: key);
  final List<SellerInfoModel> todayReg;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: kWhiteTextColor),
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            horizontalTitleGap: 10,
            leading: Icon(
              MdiIcons.bank,
              color: kGreyTextColor,
            ),
            title: Text(
              'Today Registered',
              style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            children: List.generate(
                800 ~/ 5,
                (index) => Expanded(
                      child: Container(
                        color: index % 2 == 0 ? Colors.transparent : Colors.grey,
                        height: 1,
                      ),
                    )),
          ),
          Expanded(
            child: todayReg.isNotEmpty ?? true
                ? ListView.builder(
                    itemCount: todayReg.length < 5 ? todayReg.length : 5,
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (_, i) {
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        horizontalTitleGap: 0,
                        title: Text(
                          todayReg[i].companyName.toString(),
                          style: kTextStyle.copyWith(color: kTitleColor),
                        ),
                        subtitle: Text(
                          todayReg[i].businessCategory.toString(),
                          style: kTextStyle.copyWith(color: kBlueTextColor),
                        ),
                        trailing: Text(
                          'Today',
                          style: kTextStyle.copyWith(color: kGreyTextColor),
                        ),
                      );
                    },
                  )
                : const Center(child: Text('List is empty')),
          ),
        ],
      ),
    );
  }
}

//Lifetime Subscribed
class YearlySubscribed extends StatelessWidget {
  const YearlySubscribed({Key? key, required this.lifeTimeSeller}) : super(key: key);
  final List<SellerInfoModel> lifeTimeSeller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: kWhiteTextColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            horizontalTitleGap: 10,
            leading: Icon(
              MdiIcons.accountGroupOutline,
              color: kGreyTextColor,
            ),
            title: Text(
              'Yearly Subscribed',
              style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            children: List.generate(
                800 ~/ 5,
                (index) => Expanded(
                      child: Container(
                        color: index % 2 == 0 ? Colors.transparent : Colors.grey,
                        height: 1,
                      ),
                    )),
          ),
          Expanded(
            child: lifeTimeSeller.isNotEmpty ?? true
                ? ListView.builder(
                    itemCount: lifeTimeSeller.length < 5 ? lifeTimeSeller.length : 5,
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (_, i) {
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        horizontalTitleGap: 20,
                        leading: CircleAvatar(
                          radius: 20.0,
                          backgroundImage: NetworkImage(lifeTimeSeller[i].pictureUrl ?? ''),
                        ),
                        title: Text(
                          lifeTimeSeller[i].companyName.toString(),
                          style: kTextStyle.copyWith(color: kTitleColor),
                        ),
                        subtitle: Text(
                          lifeTimeSeller[i].businessCategory.toString(),
                          style: kTextStyle.copyWith(color: kBlueTextColor),
                        ),
                        trailing: Text(
                          lifeTimeSeller[i].subscriptionDate.toString().substring(0, 10),
                          style: kTextStyle.copyWith(color: kTitleColor),
                        ),
                      );
                    },
                  )
                : const Center(child: Text('List is empty')),
          ),
        ],
      ),
    );
  }
}

//Expired Shop
class ExpiredShop extends StatelessWidget {
  const ExpiredShop({Key? key, required this.expiredShop}) : super(key: key);
  final List<SellerInfoModel> expiredShop;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: kWhiteTextColor),
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            horizontalTitleGap: 10,
            leading: Icon(
              MdiIcons.clockAlertOutline,
              color: kGreyTextColor,
            ),
            title: Text(
              'Expired Shop',
              style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
            ),
            trailing: Text(
              'Package',
              style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            children: List.generate(
                800 ~/ 5,
                (index) => Expanded(
                      child: Container(
                        color: index % 2 == 0 ? Colors.transparent : Colors.grey,
                        height: 1,
                      ),
                    )),
          ),
          Expanded(
            child: expiredShop.isNotEmpty ?? true
                ? ListView.builder(
                    itemCount: expiredShop.length < 5 ? expiredShop.length : 5,
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (_, i) {
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        horizontalTitleGap: 0,
                        title: Text(
                          expiredShop[i].companyName.toString(),
                          style: kTextStyle.copyWith(color: kTitleColor),
                        ),
                        subtitle: Text(
                          expiredShop[i].businessCategory.toString(),
                          style: kTextStyle.copyWith(color: kBlueTextColor),
                        ),
                        trailing: Text(
                          expiredShop[i].subscriptionDate.toString().substring(0, 10),
                          style: kTextStyle.copyWith(color: kGreyTextColor),
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Text('List is empty'),
                  ),
          ),
        ],
      ),
    );
  }
}

class NewRegisteredUser extends StatefulWidget {
  const NewRegisteredUser({Key? key, required this.allDay}) : super(key: key);

  final List<int> allDay;

  @override
  State<NewRegisteredUser> createState() => _NewRegisteredUserState();
}

class _NewRegisteredUserState extends State<NewRegisteredUser> {
  late List<RegData> data;

  @override
  void initState() {
    super.initState();
    data = initializeRegData();
  }

  List<RegData> initializeRegData() {
    return List.generate(
      widget.allDay.length,
      (index) => RegData((index + 1).toString(), widget.allDay[index].toDouble()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 400,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: kWhiteTextColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    MdiIcons.accountGroupOutline,
                    color: kGreyTextColor,
                  ),
                  const SizedBox(width: 10.0),
                  Text(
                    'Plan subscribers (current month)',
                    style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                children: List.generate(
                    800 ~/ 2,
                    (index) => Expanded(
                          child: Container(
                            color: index % 2 == 0 ? Colors.transparent : Colors.grey,
                            height: 1,
                          ),
                        )),
              ),
              const SizedBox(height: 20.0),
              SfCartesianChart(
                primaryXAxis:  CategoryAxis(),
                plotAreaBorderColor: Colors.transparent,
                legend: Legend(
                  isVisible: true,
                  alignment: ChartAlignment.center,
                  position: LegendPosition.bottom,
                ),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <CartesianSeries<RegData, String>>[
                  ColumnSeries<RegData, String>(
                    legendIconType: LegendIconType.rectangle,
                    dataSource: data,
                    xValueMapper: (RegData day, _) => day.day,
                    yValueMapper: (RegData count, _) => count.count,
                    name: 'Subscribers',
                    color: Colors.blue,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(30.0),
                      topLeft: Radius.circular(30.0),
                    ),
                    // Enable data label
                    dataLabelSettings: const DataLabelSettings(isVisible: false),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class RegData {
  RegData(this.day, this.count);

  final String day;
  final double count;
}

class StatisticsData extends StatefulWidget {
  const StatisticsData(
      {Key? key,
      required this.totalIncomeCurrentYear,
      required this.totalIncomeCurrentMonths,
      required this.totalIncomeLastMonth,
      required this.allMonthData,
      required this.allDay,
      required this.totalUser,
      required this.freeUser})
      : super(key: key);
  final double totalIncomeCurrentYear;
  final double totalIncomeCurrentMonths;
  final double totalIncomeLastMonth;
  final List<double> allMonthData;
  final List<int> allDay;
  final double totalUser;
  final double freeUser;

  @override
  State<StatisticsData> createState() => _StatisticsDataState();
}

class _StatisticsDataState extends State<StatisticsData> {
  List<MonthlyIncomeData> data = [
    MonthlyIncomeData('Jan', 0),
    MonthlyIncomeData('Feb', 0),
    MonthlyIncomeData('Mar', 0),
    MonthlyIncomeData('Apr', 0),
    MonthlyIncomeData('May', 0),
    MonthlyIncomeData('Jun', 0),
    MonthlyIncomeData('July', 0),
    MonthlyIncomeData('Aug', 0),
    MonthlyIncomeData('Sep', 0),
    MonthlyIncomeData('Oct', 0),
    MonthlyIncomeData('Nov', 0),
    MonthlyIncomeData('Dec', 0),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = [
      MonthlyIncomeData('Jan', widget.allMonthData[0]),
      MonthlyIncomeData('Feb', widget.allMonthData[1]),
      MonthlyIncomeData('Mar', widget.allMonthData[2]),
      MonthlyIncomeData('Apr', widget.allMonthData[3]),
      MonthlyIncomeData('May', widget.allMonthData[4]),
      MonthlyIncomeData('Jun', widget.allMonthData[5]),
      MonthlyIncomeData('Jul', widget.allMonthData[6]),
      MonthlyIncomeData('Aug', widget.allMonthData[7]),
      MonthlyIncomeData('Sep', widget.allMonthData[8]),
      MonthlyIncomeData('Oct', widget.allMonthData[9]),
      MonthlyIncomeData('Nov', widget.allMonthData[10]),
      MonthlyIncomeData('Dec', widget.allMonthData[11]),
    ];
    dailyData = initializeSalesData();
  }

  List<String> monthList = [
    'This Month',
    'Yearly',
  ];

  String selectedMonth = 'Yearly';

  DropdownButton<String> getCategories() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String des in monthList) {
      var item = DropdownMenuItem(
        value: des,
        child: Text(
          des,
          style: const TextStyle(color: kTitleColor, fontWeight: FontWeight.normal, fontSize: 14),
        ),
      );
      dropDownItems.add(item);
    }
    return DropdownButton(
      icon: Icon(Icons.keyboard_arrow_down),
      // padding: EdgeInsets.zero,
      items: dropDownItems,
      value: selectedMonth,
      onChanged: (value) {
        setState(() {
          selectedMonth = value!;
        });
      },
    );
  }

  final ScrollController stockInventoryScrollController = ScrollController();

  late List<DailyIncomeData> dailyData;

  List<DailyIncomeData> initializeSalesData() {
    return List.generate(
      widget.allDay.length,
      (index) => DailyIncomeData((index + 1).toString(), widget.allDay[index].toDouble()),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    double percentageChange = 0.0;
    double freePercentage = ((widget.freeUser * 100) / widget.totalUser);
    double paidPercentage = 100 - freePercentage;
    print(freePercentage);
    print(paidPercentage);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        //________________________________________________Statistics______
        Expanded(
          flex: 2,
          child: Container(
            height: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: kBorderColorTextField.withOpacity(0.1), blurRadius: 4, blurStyle: BlurStyle.inner, spreadRadius: 1, offset: const Offset(0, 1))
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20, top: 15.0),
                  child: Row(
                    children: [
                      const Icon(Icons.show_chart,color: kGreyTextColor),
                      const SizedBox(width: 10.0),
                      Text(
                        'Statistic (Total income)',
                        style: textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold, color: kTitleColor),
                      ),
                      const Spacer(),
                      Container(
                        height: 36,
                        padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.0),
                          border: Border.all(color: kBorderColorTextField),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: getCategories(),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: List.generate(
                      800 ~/ 5,
                          (index) => Expanded(
                        child: Container(
                          color: index % 2 == 0 ? Colors.transparent : Colors.grey,
                          height: 1,
                        ),
                      )),
                ),
                Visibility(
                  visible: selectedMonth == 'Yearly',
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: SfCartesianChart(
                      borderWidth: 1.0,
                      backgroundColor: Colors.white,
                      borderColor: Colors.transparent,
                      primaryXAxis:  CategoryAxis(
                        majorGridLines: MajorGridLines(width: 0),
                      ),
                      plotAreaBorderColor: Colors.transparent,
                      legend:  Legend(
                        isVisible: true,
                        alignment: ChartAlignment.center,
                        position: LegendPosition.top,
                      ),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <CartesianSeries<MonthlyIncomeData, String>>[
                        SplineSeries<MonthlyIncomeData, String>(
                          splineType: SplineType.natural,
                          legendIconType: LegendIconType.circle,
                          dataSource: data,
                          xValueMapper: (MonthlyIncomeData sales, _) => sales.month,
                          yValueMapper: (MonthlyIncomeData sales, _) => sales.sales,
                          name: 'Total income:\$${widget.totalIncomeCurrentYear}',
                          color: kMainColor,
                          enableTooltip: true,
                          // borderRadius: const BorderRadius.only(
                          //   topRight: Radius.circular(30.0),
                          //   topLeft: Radius.circular(30.0),
                          // ),
                          // Enable data label
                          dataLabelSettings: const DataLabelSettings(isVisible: false),
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: selectedMonth == 'This Month',
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: SfCartesianChart(
                      borderWidth: 1.0,
                      backgroundColor: Colors.white,
                      borderColor: Colors.transparent,
                      primaryXAxis: CategoryAxis(
                        majorGridLines: const MajorGridLines(width: 0),
                      ),
                      plotAreaBorderColor: Colors.transparent,
                      legend: Legend(
                        isVisible: true,
                        alignment: ChartAlignment.center,
                        position: LegendPosition.top,
                      ),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <CartesianSeries<DailyIncomeData, String>>[
                        SplineSeries<DailyIncomeData, String>(
                          splineType: SplineType.natural,
                          legendIconType: LegendIconType.circle,
                          dataSource: dailyData,
                          xValueMapper: (DailyIncomeData sales, _) => sales.day,
                          yValueMapper: (DailyIncomeData sales, _) => sales.sales,
                          name: 'Total income:\$${widget.totalIncomeCurrentYear}',
                          color: kMainColor,
                          enableTooltip: true,
                          // borderRadius: const BorderRadius.only(
                          //   topRight: Radius.circular(30.0),
                          //   topLeft: Radius.circular(30.0),
                          // ),
                          // Enable data label
                          dataLabelSettings: const DataLabelSettings(isVisible: false),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class MonthlyIncomeData {
  MonthlyIncomeData(this.month, this.sales);

  final String month;
  final double sales;
}

class DailyIncomeData {
  DailyIncomeData(this.day, this.sales);

  final String day;
  final double sales;
}

class UserOverView extends StatefulWidget {
  const UserOverView({super.key, required this.currentMonth, required this.lastMonth});

  final double currentMonth;
  final double lastMonth;

  @override
  State<UserOverView> createState() => _UserOverViewState();
}

class _UserOverViewState extends State<UserOverView> {

  late Map<String, double> dataMap;

  @override
  void initState() {
    super.initState();
    dataMap = <String, double>{
      "Last": widget.currentMonth,
      "Current": widget.lastMonth,
    };
  }
  final colorList = <Color>[
    kBlueTextColor,
    kBlueTextColor.withOpacity(0.3),
  ];

  @override
  Widget build(BuildContext context) {
    double last = ((widget.lastMonth * 100) / widget.currentMonth);
    double current = 100 - last;

    return Container(
      padding: const EdgeInsets.all(10),
      height: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: kBorderColorTextField.withOpacity(0.1),
            blurRadius: 4,
            blurStyle: BlurStyle.inner,
            spreadRadius: 1,
            offset: const Offset(0, 1),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                const Icon(Icons.pie_chart_outline_outlined,color: kGreyTextColor),
                const SizedBox(width: 10.0),
                Text(
                  'Income overview',
                  style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: List.generate(
                800 ~/ 5,
                    (index) => Expanded(
                  child: Container(
                    color: index % 2 == 0 ? Colors.transparent : Colors.grey,
                    height: 1,
                  ),
                )),
          ),
          const SizedBox(height: 60),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  height: 200,
                  child: pie.PieChart(
                    dataMap: dataMap,
                    animationDuration: const Duration(milliseconds: 800),
                    // chartLegendSpacing: 32,
                    chartRadius: MediaQuery.of(context).size.width / 3.2,
                    // colorList: Color(value),
                    initialAngleInDegree: 0,
                    chartType: pie.ChartType.ring,
                    ringStrokeWidth: 32,
                    // centerText: "HYBRID",
                    baseChartColor: Colors.grey[50]!.withOpacity(0.15),
                    colorList: colorList,
                    legendOptions: const pie.LegendOptions(
                      showLegendsInRow: false,
                      legendPosition: pie.LegendPosition.right,
                      showLegends: false,
                      // legendShape: _BoxShape.circle,
                      legendTextStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    chartValuesOptions: const pie.ChartValuesOptions(
                      showChartValueBackground: true,
                      showChartValues: true,
                      showChartValuesInPercentage: true,
                      showChartValuesOutside: false,
                      decimalPlaces: 1,

                    ),
                    // gradientList: ---To add gradient colors---
                    // emptyColorGradient: ---Empty Color gradient---
                  ),
                ),
                const SizedBox(width: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Indicator(
                      size: 12,
                      color: kBlueTextColor.withOpacity(0.3),
                      text: 'Last Month: ',
                      isSquare: false,
                      percent: '\$${widget.lastMonth}',
                    ),
                    const SizedBox(height: 20),
                    Indicator(
                      size: 12,
                      color: kBlueTextColor,
                      text: 'This Month: ',
                      isSquare: false,
                      percent: '\$${widget.currentMonth}',
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.percent,
    required this.isSquare,
    this.size = 16,
    this.textColor,
  });

  final Color color;
  final String text;
  final String percent;
  final bool isSquare;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: 4),
        RichText(
          text: TextSpan(
              text: text,
              style: const TextStyle(
                color: kGreyTextColor,
                  overflow: TextOverflow.ellipsis
              ),
              children: [
                TextSpan(
                  text: percent,
                  style: const TextStyle(
                    color: kTitleColor,fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis
                  ),
                )
              ]),
        ),
      ],
    );
  }
}
