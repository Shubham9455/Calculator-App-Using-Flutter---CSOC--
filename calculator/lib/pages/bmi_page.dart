import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../home_page.dart';
import 'data_page.dart';
class BMICalculator extends StatefulWidget {
  const BMICalculator({Key? key}) : super(key: key);

  @override
  State<BMICalculator> createState() => _BMICalculatorState();

}

class _BMICalculatorState extends State<BMICalculator> {
  var weight = 0.0;
  var height = 0.0;
  var bmi = 0.0;
  var gotapped = false;
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
              size: 40,
            ).px8(),
            "CALCULATOR".text.xl4.extraBold.purple900.make(),
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
      body: Container(
        // height: 300,
        // color: Colors.black,
        child: Column(children: [
          "BMI CALCULATOR".text.bold.xl4.make().py8(),
          const SizedBox(height: 10,),
          TextFormField(
            decoration: const InputDecoration(
                            hintText: "Enter Weight In KG", labelText: "Weight"),
            onChanged: (value){
              weight = double.parse(value);
              gotapped = false;
              setState(() {});
            },                
          ).p12(),
          
          TextFormField(
            decoration: const InputDecoration(
                            hintText: "Enter Height In cm", labelText: "Height"),
            onChanged: (value){
              height = double.parse(value);
              gotapped = false;
              setState(() {});
            },
          
          ).p12(),
          InkWell(
            onTap: () {
              bmi = (weight*100*100)/(height*height);
              setState(() {
                gotapped = true;
              });
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                child: Center(
                  child:gotapped
                  ?("BMI = "+bmi.toStringAsFixed(2)).text.bold.xl3.make()
                  : "Go".text.xl3.bold.make()),
                height: 50,
                width: 200,
                color: const Color.fromARGB(255, 149, 145, 135),
              ),
            ).py16(),
          )

        ]),
      ),
    );
  }
}
