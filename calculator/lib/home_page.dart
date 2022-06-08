import 'package:calculator/pages/data_page.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:math_expressions/math_expressions.dart';
import 'pages/bmi_page.dart';
import 'pages/history_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static bool darkmode = false;
  var input = '';
  var answer = '';
  List<String> history = [];
  final List<String> buttons = [
    '=','C','DEL','(',')',
    'ln','sin','cos','tan','e',
    '5','6','7','8','9',
    '4','3','2','1','0',
    '/',
    '*',
    '-',
    '+',
    '.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: darkmode?Colors.black:Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(
              Icons.calculate,
              color: Colors.deepPurple,
              size: 25,
            ),
            "CALCULATOR".text.xl2.extraBold.purple900.make(),
            
          ],
        ),
        actions: [
          GestureDetector(
            child: const Icon(
                Icons.history,
                color: Colors.deepPurple,
                size: 25,
              ).px8(),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryPage(history: history,)));
              },
          ),
          GestureDetector(
            child: darkmode?const Icon(
                Icons.light_mode,
                color: Color.fromARGB(255, 216, 196, 15),
                size: 25,
              ).px8(): const Icon(
                Icons.dark_mode,
                color: Color.fromARGB(255, 81, 78, 84),
                size: 25,
              ).px8(),
              onTap: (){
                if(darkmode){
                  darkmode = false;
                }
                else{
                  darkmode = true;
                }
                setState(() {});
              },
          ),
          PopupMenuButton(
            icon: const Icon(
              
              Icons.menu,
              color: Colors.deepPurple,
              size: 30,
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
            Expanded(
                child: Container(
              color: Colors.black,
              child: ListView(
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    child: input.text.xl3.blue500.make(),
                  ).p8(),
                  Container(
                    alignment: Alignment.centerRight,
                    child: answer.text.green400.bold.xl5.make(),
                  ).p8()
                ],
              ),
            )),
            Expanded(
                flex: 2,
                child: Container(
                  color: darkmode?const Color.fromARGB(255, 77, 69, 91):Colors.white,
                  child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5),
                      itemCount: buttons.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (buttons[index] == 'C') {
                          return MyButton(
                              darkmode: darkmode,
                              buttonText: buttons[index],
                              buttontapped: () {
                                setState(() {
                                  input = '';
                                  answer = '';
                                });
                              });
                        } else if (buttons[index] == '=') {
                          return MyButton(
                              darkmode: darkmode,
                              buttonText: buttons[index],
                              buttontapped: () {
                                setState(() {
                                  equalPressed();
                                  history.add(input+" = "+answer);
                                });
                              });
                        } else if (buttons[index] == 'DEL') {
                          return MyButton(
                            darkmode: darkmode,
                              buttonText: buttons[index],
                              buttontapped: () {
                                setState(() {
                                  input = input.substring(0, input.length - 1);
                                });
                              });
                        
                        } else {
                          return MyButton(
                            darkmode: darkmode,
                            buttonText: buttons[index],
                            buttontapped: () {
                              setState(() {
                                input += buttons[index];
                              });
                            },
                          );
                        }
                      }).px24(),
                )),
                const SizedBox(height: 10,)
          ],
        ),
      ),
    );
  }

  void equalPressed() {
    Parser p = Parser();
    Expression exp = p.parse(input);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toString();
  }
}

class MyButton extends StatelessWidget {
  final darkmode;
  final String buttonText;
  final buttontapped;

  
  MyButton({required this.buttonText, required this.buttontapped, required this.darkmode});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttontapped,
      
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: ClipRRect(
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: (buttonText == '=') ? Colors.orange : (darkmode?Colors.black12:Colors.white),
            child: Center(
              child: Text(
                buttonText,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
