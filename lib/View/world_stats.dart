import 'package:covid_tracker/View/countries_list.dart';
import 'package:covid_tracker/models/world_states_model.dart';
import 'package:covid_tracker/services/states_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStatsScreen extends StatefulWidget {
  const WorldStatsScreen({Key? key}) : super(key: key);

  @override
  State<WorldStatsScreen> createState() => _WorldStatsScreenState();
}

class _WorldStatsScreenState extends State<WorldStatsScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 7), vsync: this)
        ..repeat();
  final colorList = <Color>[
    const Color(0xff4285f4),
    const Color(0xff1aa260),
    const Color(0xffde5246)
  ];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            FutureBuilder(
              future: statesServices.WorldStatesFunction(),
              builder: (context, AsyncSnapshot<WorldStatesModel> snapshot) {
                if (!snapshot.hasData) {
                  return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50,
                        controller: _controller,
                      ));
                } else {
                  return Column(
                    children: [
                      PieChart(
                        dataMap: {
                          "Total":
                              double.parse(snapshot.data!.cases.toString()),
                          "Recovered":
                              double.parse(snapshot.data!.recovered.toString()),
                          "Deaths":
                              double.parse(snapshot.data!.deaths.toString()),
                        },
                        chartValuesOptions: const ChartValuesOptions(
                            showChartValuesInPercentage: true),
                        animationDuration: Duration(milliseconds: 120),
                        chartType: ChartType.ring,
                        colorList: colorList,
                        chartRadius: MediaQuery.of(context).size.width / 3.2,
                        legendOptions:
                            LegendOptions(legendPosition: LegendPosition.left),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical:
                                MediaQuery.of(context).size.height * 0.06),
                        child: Card(
                          child: Column(
                            children: [
                              ReusableRow(
                                  title: 'Total cases',
                                  vale: snapshot.data!.cases.toString()),
                              ReusableRow(
                                  title: 'Today Recovered cases',
                                  vale:
                                      snapshot.data!.todayRecovered.toString()),
                              ReusableRow(
                                  title: 'Today Death cases',
                                  vale: snapshot.data!.todayDeaths.toString()),
                              ReusableRow(
                                  title: 'Active Cases',
                                  vale: snapshot.data!.active.toString()),
                              ReusableRow(
                                  title: 'Critical',
                                  vale: snapshot.data!.critical.toString())
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CountriesList(),
                              ));
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Color(0xff1aa260),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              'Track countries',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                }
              },
            ),
          ],
        ),
      )),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title, vale;
  ReusableRow({Key? key, required this.title, required this.vale})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(title), Text(vale)],
          ),
          SizedBox(
            height: 5,
          ),
          Divider()
        ],
      ),
    );
  }
}
