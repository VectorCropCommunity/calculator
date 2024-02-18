import 'package:get/get.dart';

class HandleController extends GetxController {
  RxString previousDisplayText = "0".obs;
  RxString displayText = "0".obs;
  RxString currentOperand = "".obs;
  RxString operator = "".obs;
  RxString previousOperand = "".obs;
  double operation = 0;

  handleButtonPress(String buttonText) {
    if (buttonText == "C") {
      // Clear display and reset operands and operator
      displayText.value = "0";
      previousOperand.value = "";
      currentOperand.value = "";
      operator.value = "";
    } else if (buttonText == "%") {
      // Calculate percentage
      if (currentOperand.isNotEmpty) {
        double percent = double.parse(currentOperand.value) / 100;
        displayText.value = percent.toString();
        currentOperand.value = percent.toString();
      }
    } else if (buttonText == "+/-") {
      // Change sign
      if (currentOperand.isNotEmpty) {
        double value = double.parse(currentOperand.value);
        value *= -1;
        displayText.value = value.toString();
        currentOperand.value = value.toString();
      }
    } else if (buttonText == "÷" ||
        buttonText == "x" ||
        buttonText == "-" ||
        buttonText == "+") {
      // Handle operator buttons
      if (operator.isNotEmpty &&
          currentOperand.isEmpty &&
          previousOperand.isNotEmpty) {
        // Operator pressed again after cancelling, show previous answer with the appropriate sign
        currentOperand.value = displayText.value;
        previousOperand.value = displayText.value;
        displayText.value += buttonText;
      } else if (operator.isEmpty && currentOperand.isNotEmpty) {
        operator.value = buttonText;
        previousOperand.value = currentOperand.value;
        currentOperand.value = "";
        displayText.value += buttonText;
      }
    } else if (buttonText == "=") {
      // Perform calculation
      if (displayText.value.isNotEmpty) {
        previousDisplayText.value = displayText.value;
        switch (operator.value) {
          case "+":
            operation = double.parse(previousOperand.value) +
                double.parse(currentOperand.value);
            displayText.value = "$operation";
            break;
          case "-":
            operation = double.parse(previousOperand.value) -
                double.parse(currentOperand.value);
            displayText.value = "$operation";
            break;
          case "÷":
            operation = double.parse(previousOperand.value) /
                double.parse(currentOperand.value);
            displayText.value = "$operation";
            break;
          case "x":
            operation = double.parse(previousOperand.value) *
                double.parse(currentOperand.value);
            displayText.value = "$operation";
            break;
        }
        previousOperand.value = "";
        currentOperand.value = "";
        operator.value = "";
      }
    } else if (buttonText == ".") {
      // Add decimal point
      if (!currentOperand.value.contains(".")) {
        currentOperand.value += buttonText;
        displayText.value += buttonText;
      }
    } else if (buttonText == "0" ||
        buttonText == "1" ||
        buttonText == "2" ||
        buttonText == "3" ||
        buttonText == "4" ||
        buttonText == "5" ||
        buttonText == "6" ||
        buttonText == "7" ||
        buttonText == "8" ||
        buttonText == "9") {
      // Handle digits
      if (displayText.value == "0") {
        displayText.value = "";
      }
      currentOperand.value += buttonText;
      displayText.value += buttonText;
    } else if (buttonText == "<") {
      // Backspace or delete functionality
      if (displayText.value.isNotEmpty) {
        displayText.value =
            displayText.value.substring(0, displayText.value.length - 1);
        if (currentOperand.value.isNotEmpty) {
          currentOperand.value = currentOperand.value
              .substring(0, currentOperand.value.length - 1);
        }
      }
    }
  }
}
