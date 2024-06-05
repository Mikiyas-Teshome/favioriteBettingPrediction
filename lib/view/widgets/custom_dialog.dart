import 'package:flutter/material.dart';

import 'custom_icon_button.dart';

// class CustomDialog extends StatelessWidget {
//   final String hintText;
//   final VoidCallback onButtonClick;
//   final Color strokeColor;
//   final TextEditingController phoneNumberController;
//   CustomDialog({
//     required this.hintText,
//     required this.onButtonClick,
//     required this.strokeColor,
//     required this.phoneNumberController,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     // final TextEditingController _phoneNumberController =
//     //     TextEditingController();
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8.0),
//       ),
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8.0),
//           color: Theme.of(context).brightness == Brightness.light
//               ? Colors.white
//               : Colors.black,
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(32.0),
//               child: InternationalPhoneNumberInput(
//                 onInputChanged: (PhoneNumber number) {
//                   print(number.phoneNumber);
//                 },
//                 spaceBetweenSelectorAndTextField: 0,
//
//                 textFieldController: phoneNumberController,
//                 inputDecoration: InputDecoration(
//                   labelText: 'Phone Number',
//                   labelStyle: TextStyle(color: strokeColor),
//                   floatingLabelBehavior: FloatingLabelBehavior.auto,
//                   // contentPadding: EdgeInsets.symmetric(vertical: 8.0),
//                   enabledBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(color: strokeColor),
//                   ),
//                   focusedBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(color: strokeColor),
//                   ),
//                 ),
//                 selectorConfig: SelectorConfig(
//                   selectorType: PhoneInputSelectorType.DIALOG,
//                 ),
//                 errorMessage:
//                     'Invalid phone number', // Validation error message
//                 selectorTextStyle: TextStyle(color: strokeColor),
//                 ignoreBlank: false, // Validate empty input
//                 autoValidateMode: AutovalidateMode
//                     .onUserInteraction, // Validate on user interaction
//                 formatInput: true,
//               ),
//             ),
//             SizedBox(height: 16.0),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: CustomIconButton(
//                 text: "Login with Telegram",
//                 strokeColor: Colors.blue,
//                 onPressed: onButtonClick,
//                 image: "assets/telegramIcon.png",
//               ),
//             ),
//             const SizedBox(height: 16.0),
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _phoneNumberController.dispose();
//     super.dispose();
//   }
// }
class CustomDialog extends StatefulWidget {
  final Function(String) onDialogSubmit;
  final Color strokeColor;

  CustomDialog({
    required this.onDialogSubmit,
    required this.strokeColor,
  });

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  String phone = "";
  bool validated = false;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      backgroundColor: Colors.white, // Set background color to white
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : Color(0xff595959),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 40.0,
            ),
            Image.asset(
              "assets/telegramIcon.png",
              width: 55.0,
            ),
            SizedBox(height: 20.0),
            Text(
              "Continue With Telegram",
              style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(32.0),
            //   child: InternationalPhoneNumberInput(
            //     onInputChanged: (PhoneNumber number) {
            //       setState(() {
            //         phone = number.phoneNumber.toString();
            //       });
            //     },
            //     spaceBetweenSelectorAndTextField: 0,
            //     inputDecoration: InputDecoration(
            //       labelText: 'Phone Number',
            //       labelStyle: TextStyle(color: widget.strokeColor),
            //       floatingLabelBehavior: FloatingLabelBehavior.auto,
            //       contentPadding: EdgeInsets.symmetric(vertical: 8.0),
            //       enabledBorder: UnderlineInputBorder(
            //         borderSide: BorderSide(color: widget.strokeColor),
            //       ),
            //       focusedBorder: UnderlineInputBorder(
            //         borderSide: BorderSide(color: widget.strokeColor),
            //       ),
            //     ),
            //     selectorConfig: SelectorConfig(
            //       selectorType: PhoneInputSelectorType.DIALOG,
            //     ),
            //     errorMessage:
            //         'Invalid phone number', // Validation error message
            //     selectorTextStyle: TextStyle(color: widget.strokeColor),
            //     ignoreBlank: false, // Validate empty input
            //     autoValidateMode: AutovalidateMode
            //         .onUserInteraction, // Validate on user interaction
            //     formatInput: true, // Format input
            //     keyboardType: TextInputType.phone, // Set keyboard type
            //     inputBorder: UnderlineInputBorder(
            //       borderSide: BorderSide(color: widget.strokeColor),
            //     ),
            //     onInputValidated: (bool value) {
            //       // Validation callback
            //       print('Is input valid? $value');
            //       setState(() {
            //         validated = value;
            //       });
            //     },
            //   ),
            // ),
            SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CustomIconButton(
                text: "Login with Telegram",
                textColor: Theme.of(context).brightness == Brightness.light
                    ? Colors.white
                    : Colors.black,
                strokeColor: Colors.blue,
                backgroundColor: Color(0xff29A9EB),
                image: "assets/telegramIcon.png",
                onPressed: () {
                  if (validated) {
                    widget.onDialogSubmit(phone); // Execute button function
                    // Navigator.of(context).pop();
                  }
                },
              ),
            ),
            SizedBox(height: 40.0),
          ],
        ),
      ),
    );
  }
}
