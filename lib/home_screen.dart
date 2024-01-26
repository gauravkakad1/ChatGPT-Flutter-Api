import 'package:chatgpt_flutter_app/compnents.dart';
import 'package:chatgpt_flutter_app/palletes.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(top: false,
      child: Scaffold(
        appBar: AppBar(centerTitle: true,
          title: Container(child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("ChatGPT",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,fontFamily: 'Cera Pro')),
                Icon(Icons.star_rate, size: 18,)
              ],
            ),
          ),decoration: BoxDecoration(color: Color(
              0xffe8d7fc),borderRadius: BorderRadius.circular(10)),),
        leading: Icon(Icons.menu),
          actions: const [
            Icon(Icons.more_vert),
            SizedBox(width: 10,)
          ],
        ),
        
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                    Container(height: 120,width: 120,decoration: BoxDecoration(shape: BoxShape.circle,color: Pallete.assistantCircleColor),),
                    Container(height: 125,decoration: BoxDecoration(shape: BoxShape.circle,image: DecorationImage(image: AssetImage('assets/images/virtualAssistant.png'))),)
                  ],),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                  margin: EdgeInsets.symmetric(horizontal: 40,vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Pallete.borderColor
                    ),
                    borderRadius: BorderRadius.circular(20).copyWith(topLeft: Radius.zero)
                  ),
                child: Text("Good Morning, What task can I do for you ?",style: TextStyle(fontFamily: 'Cera Pro',fontSize: 25,color: Pallete.mainFontColor,)),
              ),
              Container(margin: EdgeInsets.only(left: 20),alignment: Alignment.centerLeft,child: Text("Here are few features",style: TextStyle(color: Pallete.mainFontColor,fontFamily: 'Cera Pro',fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.start,)),
              Column(
                children: [
                  FeatureBox(title: "ChatGPT", subTitle: "A smarter way to stay organised and informed with ChatGPT", boxColor: Pallete.firstSuggestionBoxColor),
                  FeatureBox(title: "Dall-E", subTitle: 'Get inspired and stay creative with your personal assistant powered by Dall-E', boxColor: Pallete.secondSuggestionBoxColor),
                  FeatureBox(title: "Smart Voice Assistant", subTitle: "Get the best of both worlds with a voice assistant powered by Dall-E and ChatGPT", boxColor: Pallete.thirdSuggestionBoxColor),
                ],
              )
          
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {  },

          child: Icon(Icons.mic),
        ),
      ),
    );
  }
}
