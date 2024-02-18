import 'package:flutter/material.dart';
import 'package:calculator/controller/handle.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class Calculator extends StatelessWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HandleController controller = HandleController();

    // Function to create a TextButton
    Widget createButton(String buttonText, Function() onPressed) {
      return TextButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(getButtonColor(buttonText)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      );
    }

    // List of button texts
    List<String> buttonLabels = [
      "C",
      "%",
      "+/-",
      "÷",
      "7",
      "9",
      "8",
      "x",
      "5",
      "4",
      "6",
      "-",
      "1",
      "2",
      "3",
      "+",
      ".",
      "0",
      "<",
      "="
    ];

    return Scaffold(
      backgroundColor: Colors.black12,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Display area
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            alignment: Alignment.bottomRight,
            child: Obx(
              () => Text(
                controller.previousDisplayText.value,
                style: TextStyle(fontSize: 32.0, color: Colors.grey),
              ),
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            alignment: Alignment.bottomRight,
            child: Obx(() => Text(
                  controller.displayText.value,
                  style: TextStyle(fontSize: 52.0, color: Colors.white),
                )),
          ),
          // Button grid
          Flexible(
            flex: 2,
            child: GridView.count(
              shrinkWrap: true,
              padding: const EdgeInsets.all(16.0),
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              childAspectRatio: 1.0,
              crossAxisCount: 4,
              children: buttonLabels.map((label) {
                return createButton(label, () {
                  controller.handleButtonPress(label);
                });
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // Function to determine button color based on its label
  Color getButtonColor(String buttonText) {
    if (buttonText == "C") {
      return Colors.red[700]!;
    } else if (buttonText == "1" ||
        buttonText == "2" ||
        buttonText == "3" ||
        buttonText == "4" ||
        buttonText == "5" ||
        buttonText == "6" ||
        buttonText == "7" ||
        buttonText == "8" ||
        buttonText == "." ||
        buttonText == "<" ||
        buttonText == "9" ||
        buttonText == "0") {
      return Colors.grey[900]!;
    } else if (buttonText == "=" ||
        buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "÷" ||
        buttonText == "x") {
      return Colors.blue[500]!;
    } else {
      return Colors.grey[700]!;
    }
  }
}
