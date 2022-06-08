import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../home_page.dart';
import 'bmi_page.dart';
import 'data_page.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key, required this.history}) : super(key: key);
  final List<String> history;

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
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

          child: Column(
            children: [
              Container(child: Center(child: "History".text.extraBold.xl5.make())).p12(),
              Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.history.length,
                      itemBuilder: (context, index) =>
                          Container(
                            color: const Color.fromARGB(255, 130, 151, 255),
                            child: Center(child: widget.history[(widget.history).length- index-1].text.xl.bold.make().p16())
                            ).p12()
                            )
                            ).p12(),
                            
            ],
          )),
    );
  }
}
