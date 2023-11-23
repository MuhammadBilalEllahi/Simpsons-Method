import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

double h = 0;
double res1by3 =0;
double res3by8 = 0;


class _MyAppState extends State<MyApp> {
  final equationEditingController = TextEditingController();

  final numberOFSubIntervalsEditingController = TextEditingController();

  final lowerSubIntervalEditingController = TextEditingController();

  final upperSubIntervalEditingController = TextEditingController();

  double result = 0.0;
 List<String> val = [];
  List<double> fx = [];
    List<double> xVal = [];

  int n = 0;

  int xN = 0;

  int xZero = 0;

  bool showVal = false;
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent.shade100.withOpacity(0.8),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.deepPurpleAccent.shade100.withOpacity(0.5),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            myTextField(
                editingController: equationEditingController,
                headingtext: "Enter Equation",
                labelText: "equation like 14^2"),
            myTextField(
                editingController: numberOFSubIntervalsEditingController,
                headingtext: "Enter Number of Segments",
                labelText: "e.g 4"),
            myTextField(
                editingController: lowerSubIntervalEditingController,
                headingtext: "Enter Lower Sub Interval",
                labelText: "e.g x0 = 0"),
            myTextField(
                editingController: upperSubIntervalEditingController,
                headingtext: "Enter Upper Sub Interval",
                labelText: "e.g xn = 3"),
            OutlinedButton(
              onPressed: () {
                fx = [];
                val = [];
                xVal = [];
                if (equationEditingController.text.contains('^')) {
                  val = equationEditingController.text.split('^');
                  val[1] = val[1].split('').toString();
                  // math.pow(val[0], val[1]);
                  // debugPrint("Should be [14, [2, x]]  -> $val");

                  // debugPrint("Should be 2 ->${val[1][1]}");
                }
                // double equation = double.parse(equationEditingController.text);
                // debugPrint("$equation");

                xZero = int.parse(lowerSubIntervalEditingController.text);
                xN = int.parse(upperSubIntervalEditingController.text);
                n = int.parse(numberOFSubIntervalsEditingController.text);

                h = double.parse(((xN - xZero) / n).toStringAsPrecision(6));
                debugPrint(h.toStringAsPrecision(6));

                for (int i = 0; i <= n; i++) {
                  if (i == 0) {
                    double xZeroDouble = double.parse(xZero.toString());
                    xVal.add(xZeroDouble);
                    fx.add(myFunction(double.parse(val[1][1]),
                        double.parse(val[0]), xZeroDouble));
                  } else {
                    double xi =
                        double.parse((xVal[i - 1] + h).toStringAsFixed(6));
                    xVal.add(xi);
                    fx.add(myFunction(double.parse(val[1][1]),
                        double.parse(val[0]), xVal[i]));

                    if (i == n) {
                      xVal[i] = double.parse(xVal[i].round().toString());
                      fx[i] = myFunction(double.parse(val[1][1]),
                          double.parse(val[0]), xVal[i]);

                      debugPrint("${xVal[i]}");
                    }
                  }
                  debugPrint("Should be 14 ->${val[0]}");
                  debugPrint("Should be 2 ->${val[1][1]}");
                  debugPrint("Should be x ->${val[1][4]}");
                  debugPrint("Should be i ->${xVal[i]}");

                  // fx.add(myFunction(double.parse(val[1][1]), double.parse(val[0]), xVal[i]));
                }
                debugPrint("f(x) -> $fx");

                debugPrint("Xi -> $xVal");

                // ValofXi(n: n,list : xVal);
                setState(() {
                  showVal = true;
                });
              },
              child: const Text("Calculate"),
            ),

            //             Visibility(
            //   visible: showVal,
            //   child: ValofXi(n: n, list: xVal),
            // ),

            xVal.isNotEmpty
                ? ValofXi(
                    n: n,
                    list: xVal,
                    fx: fx,
                    xVal: xVal,
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}

dynamic myFunction(x, y, z) {
  debugPrint("x is $x");
  debugPrint("y is $y");
  debugPrint("z is $z");
  // String hs= math.pow(y,x*z).toString().split('.').elementAt(1);
//  double cnvhs = double.parse(double.parse(hs).toStringAsPrecision(6));
  // debugPrint("test result is $result,------- $hs ------ $cnvhs");

  double innerResult = double.parse(math.pow(y, x * z).toString());

  debugPrint("test result is $innerResult");

  return double.parse(innerResult.toStringAsFixed(6));
}

dynamic integration(n, fx,xVal) {
  if ((n % 2) == 1 ) {
    

    f(x) => math.pow(14, 2*x);
    List<double> x = [for(int i =0; i<= n ; i++) xVal[i]];
    // List<double> y = [for(int i =n-3; i<= n ; i++) xVal[i]];

     res1by3 = callOneByThree(fx,f,x,n);
     res3by8 = callThreeByEight(fx,n);

    debugPrint("Res1/3 -> $res1by3");
    debugPrint("Res3/8 -> $res3by8");
    var mySum = res1by3  + res3by8;


    // double evenSum = sum_on_function(f, x, 1, n-2, (num x) => x % 2 == 0);
    // double oddSum = sum_on_function(f, x, 1, n-1, (num x) => x % 2 == 1);

  
    // double sum = fx[n-3] + 3*fx[n-2] + 3*fx[n-1] + fx[n];
    // debugPrint("This is Value of £/8 -> ${(3*h/8)*sum}");

    // var a = {for(int i=50; i<200; i+=2) i*2};
    // var a = [
    //   [for(int i=0; i<10; i++) Text('$i')]
    // ];
    //   var a = 
    //   [for(int i=0; i<10; i++) Text('$i')];

    // var a = [for(int i=0; i < 100; i++) switch(i%3) {
    //   0 => 'zero', 1 => 'one', 2 => 'three', _ => 'other'
    // }];

    debugPrint("This is Value of X-----> $x");
    // debugPrint("This is Value of Y-----> $y");
    debugPrint("This is Value of Xi$xVal");
    // debugPrint("This is Value of SUM-> $evenSum");
    // debugPrint("This is Value of ODD-> $oddSum");

    // debugPrint("-------------------$mySum");
    // debugPrint("-------------------${fx[0]}");
    // debugPrint("-------------------${fx[n]}");
    // debugPrint("-------------------4*oddsum->  ${(4*oddSum)}");
    // debugPrint("-------------------2*evenSum->  ${(2*evenSum )}");

    // debugPrint("-------------------ODD Sum-> ${(oddSum)}");
    // debugPrint("-------------------EVEN Sum-> ${(evenSum )}");


    return mySum;
  } else {
    return -1;
  }
}

typedef Condition = bool Function(num x);

double sum_on_function({required dynamic f,required List<double> x, required int lower,required int upper, required Condition condition}) {
  double sum=0;
  //lower and upper specify which indexes to use in list
  for(int i=lower-1; i < upper-1; i++) {
    if(condition(i)) {
      sum += f(x[i]);
    }
  }
  return sum;
}

double callOneByThree(fx,f,x,n){


    double oddSum = sum_on_function(f: f, x: x, lower: 2, upper: n-1, condition:(num x) => x % 2 == 1 );
    double evenSum = sum_on_function(f: f, x: x, lower: 3, upper: n-2, condition: (num x) => x % 2 == 0);

    var mySum = fx[0] + (4*oddSum) + (2*evenSum )+ fx[n-3];

    double res = double.parse(((h/3)*mySum).toStringAsFixed(6));


    debugPrint("-------------------fx0 -> ${fx[0]}");
    debugPrint("-------------------fxN -> ${fx[n]}");
    debugPrint("-------------------4*oddsum->  ${(4*oddSum)}");
    debugPrint("-------------------2*evenSum->  ${(2*evenSum )}");
    debugPrint("-------------------MySum -> $mySum");
    return res;
}


double callThreeByEight(fx,n){
      double sum = fx[n-3] + 3*fx[n-2] + 3*fx[n-1] + fx[n];
      double res = double.parse(((3*h/8)*sum).toStringAsFixed(6));
      return res;
}












class ValofXi extends StatelessWidget {
  const ValofXi(
      {super.key, required this.n, required this.list, required this.fx, required this.xVal});
  final int n;
  final List<double> list;
  final List<double> fx;
  final List<double> xVal;

  @override
  Widget build(BuildContext context) {
    // debugPrint("$n");
    //                 debugPrint(list.toString());

    // List.generate(n, (index) {

    // });
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Total Segments: $n"),
          Text("Total Segments: $h"),
          Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.all(20),
                scrollDirection: Axis.vertical,
                itemCount: n + 1,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("X$index:\t\t ${list[index]}\t"),
                        Text("${fx[index]} <- F(x$index)"),
                      ],
                    ),
                  );
                }),
          ),
          Text("Integration: ${integration(n, fx,xVal).toStringAsFixed(6)}"),
          Text("Added: $res1by3 + $res3by8"),
        ],
      ),
    );
  }
}
















class myTextField extends StatelessWidget {
  const myTextField({
    super.key,
    required this.editingController,
    required this.headingtext,
    required this.labelText,
  });

  final TextEditingController editingController;
  final String headingtext;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 2),
            child: Text(
              headingtext,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              controller: editingController,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(), label: Text(labelText)),
            ),
          ),
        ],
      ),
    );
  }
}
