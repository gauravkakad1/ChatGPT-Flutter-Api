import 'package:chatgpt_flutter_app/palletes.dart';
import 'package:flutter/material.dart';

class FeatureBox extends StatefulWidget {
  final String title;
  final String subTitle;
  final Color boxColor;
  const FeatureBox({super.key, required this.title, required this.subTitle, required this.boxColor});

  @override
  State<FeatureBox> createState() => _FeatureBoxState();
}

class _FeatureBoxState extends State<FeatureBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right:20),

      margin: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 10,
      ),
      decoration: BoxDecoration(
          color: widget.boxColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Pallete.borderColor),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20).copyWith(left:15),
        child: Column(
          children: [
            Align(alignment: Alignment.centerLeft,child: Text(widget.title,style: TextStyle(color: Pallete.blackColor,fontFamily: 'Cera Pro',fontSize: 18,fontWeight: FontWeight.bold))),
            Text(widget.subTitle,style: TextStyle(color: Pallete.blackColor,fontFamily: 'Cera Pro')),
          ],
        ),
      ),
    );
  }
}
