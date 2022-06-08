import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:velocity_x/velocity_x.dart';

import '../home_page.dart';
import 'bmi_page.dart';


class DataPage extends StatefulWidget {
  const DataPage({Key? key}) : super(key: key);
 
  
  
  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  List<double> x = [];
  var xval, yval;
  List<double> y = []; 
  List<MyData> data = [];
  var plottapped = false;
  void getData(){
    for(int i = 0;i< x.length;i++){
      data.add(MyData(x[i], y[i]));
    }
  }
  @override
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(
              Icons.calculate,
              color: Colors.deepPurple,
              size: 30,
            ).px8(),
            "CALCULATOR".text.xl3.extraBold.purple900.make(),
          ],
        ),
        actions: [
          
          PopupMenuButton(
            icon: const Icon(
              
              Icons.menu,
              color: Colors.deepPurple,
              size: 40,
            ),
            itemBuilder: (BuildContext conntext) {
              return [
                PopupMenuItem(
                  child: InkWell(
                    child: const Text("Basic Calculator"),
                    onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => const HomePage()
                        )
                    );
                  },

                  ),
                  
                ),
                PopupMenuItem(
                  child: InkWell(
                    child: const Text("BMI Calculator"),
                    onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => const BMICalculator()
                        )
                    );
                  },

                  ),
                  
                ),
                PopupMenuItem(
                  child: GestureDetector(
                    child: const Text("Data Visualisation"),
                    onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => const DataPage()
                        )
                    );
                  },
                    )
                  
                  ),
                
              ];
            },
          ),
        ],
      ),
      body: SafeArea(
          child: ListView(children: [
        
        (plottapped)?Container(
            child: Column(
              children: [
                "Line Graph".text.xl5.extraBold.make().p24(),
                Container(
                  height: 500,
                  child: SfCartesianChart(
                    enableAxisAnimation: true,
                    borderWidth: 5,
                    borderColor: Colors.deepPurple,
                      series: <ChartSeries<MyData, double>>[
                      LineSeries<MyData, double>(
                          dataSource: data,
                          xValueMapper: (MyData mydata, _) => mydata.xval,
                          yValueMapper: (MyData mydata, _) => mydata.yval,
                          )
                    ]
                  ),
                ).p24(),
              ],
            ),
          ):Container(),
          Center(child: "Data Table".text.extraBold.xl5.make()),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Center(child: 'x'.text.bold.make().p16()),
                color: const Color.fromARGB(255, 177, 163, 121),
                width: 100,
              ),
              Container(
                  child: Center(child: 'y'.text.bold.make().p16()),
                  color: const Color.fromARGB(255, 154, 101, 163),
                  width: 100)
            ],
          ),
        ),
        ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: x.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        child: Center(
                            child: x[index].toString().text.make().p16()),
                        color: Colors.amber,
                        width: 100),
                    Container(
                        child: Center(
                            child: y[index].toString().text.make().p16()),
                        color: Colors.purple,
                        width: 100)
                  ],
                ),
              );
            }),
        Container(
          // color: Colors.amber,
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                    hintText: "Enter value of x",
                    labelText: "X",
                    labelStyle: TextStyle(color: Colors.deepPurple)),
                onChanged: (value) {
                  xval = value;
                  setState(() {});
                },
              ),
              TextField(
                decoration: const InputDecoration(
                    hintText: "Enter value of y",
                    labelText: "Y",
                    labelStyle: TextStyle(color: Colors.deepPurple)),
                onChanged: (value) {
                  yval = value;
                  setState(() {});
                },
              ),
              GestureDetector(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: 150,
                    color: const Color.fromARGB(255, 149, 145, 135),
                    child: Center(child: "ADD".text.xl3.make()),
                  ),
                ),
                onTap: () {
                  x.add(double.parse(xval));
                  y.add(double.parse(yval));
                  setState(() {});
                },
              ).p12(),
              GestureDetector(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: 150,
                    color: const Color.fromARGB(255, 149, 145, 135),
                    child: Center(child: "Clear".text.xl3.make()),
                  ),
                ),
                onTap: () {
                  x = [];
                  y = [];
                  setState(() {});
                },
              ).p12(),
              GestureDetector(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: 150,
                    color: const Color.fromARGB(255, 149, 145, 135),
                    child: Center(child: "Plot".text.xl3.make()),
                  ),
                ),
                onTap: () {
                  getData();
                  plottapped = true;
                  
                  setState(() {});
                },
              ).p12()
            ],
          ),
        )
      ])),
    );
  }
}


class MyData{
  MyData(this.xval, this.yval);
  final xval;
  final yval;
}