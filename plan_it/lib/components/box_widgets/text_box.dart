import 'package:flutter/material.dart';
import 'package:plan_it/theme/color.dart';
import 'package:plan_it/theme/text.dart';

class TextBox extends StatelessWidget {
  final String textHeader;
  final String textBody;
  const TextBox({
    super.key,
    required this.textHeader,
    required this.textBody,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   color: MyColor.containerRed,
      //   borderRadius: BorderRadius.circular(15),
      // ),
      //padding: const EdgeInsets.all(2),
      margin: const EdgeInsets.symmetric(vertical: 3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            textHeader,
            style: TextDesign().header.copyWith(fontSize: 17, height: 0),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: MyColor.scaffoldColor,
                borderRadius: BorderRadius.circular(5)),
            // margin: const EdgeInsets.only(top: 1, bottom: 3),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: Text(
              textBody,
              style: TextDesign().bodyText.copyWith(
                  fontSize: 16, fontWeight: FontWeight.w400, height: 0),
            ),
          ),
        ],
      ),
    );
  }
}

// class TextBox extends StatefulWidget {
//   final String textHeader;
//   final String textBody;
//   const TextBox({
//     super.key,
//     required this.textHeader,
//     required this.textBody,
//   });

//   @override
//   State<TextBox> createState() => _TextBoxState();
// }

// class _TextBoxState extends State<TextBox> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         children: [Text(widget.textBody), Text(widget.textHeader)],
//       ),
//     );
//   }
// }
