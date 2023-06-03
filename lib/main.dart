import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:calculator/theme/them_contants.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:math_expressions/math_expressions.dart';
import 'package:url_launcher/link.dart';

void main() {
  runApp(const MaterialApp(home: Calculator()));
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final Uri _urlEmail = Uri.parse('https://jafarrezazadeh76@gmail.com');
  final Uri _urlTelegram = Uri.parse('https://t.me/@jafar_rzzd');
  bool isDark = false;
  bool showAbout = false;
  String userInput = "";
  String result = "0";
  bool isEvaluvationed = false;
  List<String> buttonsList = [
    'C',
    '()',
    '/',
    '%',
    '7',
    '8',
    '9',
    '×',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '0',
    '.',
    'clear',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    //Size in logical pixels
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    ThemeData mainTheme = isDark ? darkTheme : lightTheme;
    double? inputFontsize;
    if (userInput.length > 15) {
      inputFontsize = 25 / userInput.length * 15;
    } else {
      inputFontsize = 25;
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            title: IconButton(
              splashRadius: 15,
              onPressed: () {
                showAboutDialog(
                  context: context,
                  children: [
                    Center(
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        height: screenHeight / 2,
                        width: screenWidth / 1.5,
                        child: Scaffold(
                          body: Container(
                            padding: const EdgeInsets.all(10),
                            height: double.infinity,
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              textDirection: TextDirection.rtl,
                              children: [
                                //header
                                Text(
                                  "درباره",
                                  style: mainTheme.textTheme.titleLarge,
                                ),
                                //contents
                                const Text.rich(
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  TextSpan(
                                    text: "توسعه دهنده:",
                                    children: [
                                      TextSpan(
                                        text: " جعفر رضازاده",
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  "راه های ارتباطی",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Link(
                                      target: LinkTarget.blank,
                                      uri: _urlEmail,
                                      builder: (context, followLink) =>
                                          IconButton(
                                        onPressed: followLink,
                                        icon: const Icon(
                                          Icons.email_outlined,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                    Link(
                                      uri: _urlTelegram,
                                      builder: (context, followLink) =>
                                          IconButton(
                                        onPressed: followLink,
                                        icon: const Icon(
                                          Icons.telegram,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                                //buttons
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
              icon: const Icon(
                Icons.info,
                color: Colors.grey,
              ),
            ),
            actions: [
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: AnimatedToggleSwitch<bool>.dual(
                  current: isDark,
                  first: false,
                  second: true,
                  borderColor: Colors.transparent,
                  borderWidth: 0,
                  indicatorBorder: Border.all(
                    width: 1,
                    color: isDark ? Colors.white : Colors.blue,
                  ),
                  dif: 8,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(0, 1.5),
                    ),
                  ],
                  onChanged: (b) {
                    setState(() => isDark = b);
                  },
                  colorBuilder: (b) =>
                      b ? Colors.transparent : Colors.transparent,
                  iconBuilder: (value) => value
                      ? const Icon(
                          Icons.dark_mode,
                          color: Colors.white,
                          size: 10,
                        )
                      : const Icon(
                          Icons.light_mode,
                          size: 10,
                          color: Colors.blue,
                        ),
                  textBuilder: (value) => value
                      ? const Center(
                          child: Text(
                          'Dark Mode',
                          style: TextStyle(
                            fontSize: 6,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ))
                      : const Center(
                          child: Text(
                            'Light Mode',
                            style: TextStyle(
                                fontSize: 6,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                ),
              ),
            ],
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // results
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: 50,
                      padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child: Text(
                        userInput,
                        style: TextStyle(
                          fontSize: inputFontsize,
                          color: mainTheme.textTheme.titleLarge!.color,
                        ),
                      )
                          .animate(
                            target: isEvaluvationed ? 1 : 0,
                          )
                          .fadeOut(begin: 1)
                          .scaleXY(begin: 1, end: 0.5),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "=",
                              style: TextStyle(
                                color: mainTheme.textTheme.labelLarge!.color,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              result,
                              style: TextStyle(
                                  fontSize: screenWidth / 25,
                                  color: mainTheme.textTheme.titleSmall!.color),
                            )
                                .animate(
                                  target: isEvaluvationed ? 1 : 0,
                                )
                                .scaleXY(
                                    begin: 1,
                                    end: 1.5,
                                    curve: Curves.easeInExpo)
                                .moveY(end: -50, curve: Curves.easeInExpo)
                                .moveX(end: -30),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                height: screenHeight / 1.5,
                padding: const EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: buttonsList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: screenWidth / 25,
                      mainAxisSpacing: screenHeight / 55,
                      mainAxisExtent: screenHeight / 10,
                    ),
                    itemBuilder: (context, index) {
                      return customButton(buttonsList[index], mainTheme);
                    },
                  ),
                ),
              )
            ],
          )),
    );
  }

// custom button
  Widget customButton(String text, ThemeData mainTheme) {
    var brightness = mainTheme.brightness;

    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          brightness == Brightness.dark
              ? const BoxShadow(
                  color: Color.fromARGB(255, 77, 77, 77),
                  blurStyle: BlurStyle.normal,
                  offset: Offset(-6, -5),
                  blurRadius: 5,
                )
              : const BoxShadow(
                  color: Color.fromARGB(207, 186, 232, 238),
                  blurStyle: BlurStyle.normal,
                  offset: Offset(5, 7),
                  blurRadius: 5,
                ),
          brightness == Brightness.dark
              ? const BoxShadow(
                  color: Color.fromARGB(255, 34, 34, 34),
                  blurStyle: BlurStyle.normal,
                  offset: Offset(4, 6),
                  blurRadius: 10,
                )
              : const BoxShadow(color: Colors.transparent),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            handleInput(text);
          });
        },
        child: text == "clear"
            ? Image.asset(
                "assets/icons/clearIcon.png",
                color: mainTheme.brightness == Brightness.light
                    ? Colors.blue
                    : Colors.grey,
              )
            : Text(
                text,
                style:
                    TextStyle(color: getcolor(text, mainTheme), fontSize: 20),
              ),
      ),
    );
  }

// Todo: seprate number and others color
  Color getcolor(text, ThemeData mainTheme) {
    if (mainTheme.brightness == Brightness.light) {
      switch (text) {
        case 'C':
        case '()':
        case '/':
        case '%':
        case '×':
        case '-':
        case '+':
        case 'clear':
        case '=':
          return Colors.blue;

        default:
          return Colors.black;
      }
    } else {
      switch (text) {
        case 'C':
        case '()':
        case '/':
        case '%':
        case '×':
        case '-':
        case '+':
        case 'clear':
        case '=':
          return Colors.grey;

        default:
          return Colors.white;
      }
    }
  }
  //todo: put the project to git hub

  handleInput(String text) {
    if (text == "()") {
      userInput = "($userInput)";
    }

    if (text == "clear") {
      if (userInput.isNotEmpty) {
        userInput = userInput.substring(0, userInput.length - 1);
        return;
      }
    } else {
      if (text != "=" && text != "()") {
        userInput += text;
      }
    }

    if (text == 'C') {
      userInput = "";
      result = "0";
      isEvaluvationed = false;
      return;
    }

    String calcValue = calculate(userInput);
    if (calcValue.endsWith(".0")) {
      calcValue = calcValue.replaceAll(".0", "");
      result = calcValue;
    }

    if (text == '=') {
      isEvaluvationed = true;
      result = calculate(userInput);
      if (result.endsWith(".0")) {
        result = result.replaceAll(".0", "");
        return;
      }
    } else {
      isEvaluvationed = false;
    }
  }

  calculate(String value) {
    value = value.replaceAll('×', "*");

    try {
      var exp = Parser().parse(value);

      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return "error";
    }
  }
}
