import 'package:covid_tracker/View/world_stats.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  String name;
  String image;
  int totalCases,
      totalDeaths,
      totalRecovered,
      active,
      critical,
      todayRecovered,
      test;
  DetailScreen({
    required this.name,
    required this.image,
    required this.totalCases,
    required this.todayRecovered,
    required this.totalDeaths,
    required this.active,
    required this.critical,
    required this.test,
    required this.totalRecovered,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.name),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .06,
                      ),
                      ReusableRow(
                          title: 'Cases', vale: widget.totalCases.toString()),
                      ReusableRow(
                          title: 'Recovered',
                          vale: widget.todayRecovered.toString()),
                      ReusableRow(
                          title: 'Deaths', vale: widget.totalDeaths.toString()),
                      ReusableRow(
                          title: 'Active', vale: widget.active.toString()),
                      ReusableRow(
                          title: 'Critical', vale: widget.critical.toString()),
                      ReusableRow(
                          title: 'Total Recovered',
                          vale: widget.totalRecovered.toString()),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 55,
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          )
        ],
      ),
    );
  }
}
