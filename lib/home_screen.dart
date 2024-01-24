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
        
        body: Column(
          children: [
            SizedBox(height: 20,),
            // Virtual Assistant image
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                Container(height: 120,width: 120,decoration: BoxDecoration(shape: BoxShape.circle,color: Pallete.assistantCircleColor),),
                Container(height: 125,decoration: BoxDecoration(shape: BoxShape.circle,image: DecorationImage(image: AssetImage('assets/images/virtualAssistant.png'))),)
              ],),
            ),

          ],
        ),
        
      ),
    );
  }
}
