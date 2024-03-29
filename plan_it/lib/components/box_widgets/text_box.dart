import 'package:flutter/material.dart';
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
      padding: const EdgeInsets.all(5),
      // margin: const EdgeInsets.only(top: 30, left: 40, right: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            textHeader,
            style: TextDesign().header.copyWith(fontSize: 17),
          ),
          Text(
            textBody,
            style: TextDesign()
                .bodyText
                .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
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
