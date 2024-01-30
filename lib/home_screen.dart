
import 'dart:developer';

import 'package:chatgpt_flutter_app/compnents.dart';
import 'package:chatgpt_flutter_app/openai_services.dart';
import 'package:chatgpt_flutter_app/palletes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SpeechToText speechToText = SpeechToText();
  final OpenAIServices openAIServices =  OpenAIServices();
  FlutterTts flutterTts = FlutterTts();
  String lastWords='';
  String? generatedContent;
  String? generatedUrl;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSpeechToText();
    initTextToSpeech();
    // generatedUrl = 'https://yt3.googleusercontent.com/ytc/AIf8zZS6XDo-M7dlTyolU_yBAp-cmqn0EfZ8AGkKa9yItg=s900-c-k-c0x00ffffff-no-rj';
    // generatedContent = "Hi how are you jcnjd cndjcd cd cd cd cd cd ck dkc dk ckd ckd ck dkc kd cd kc kd ckd ck d cd kc kd ckd c d ckd ckd ck dkc dk c";
  }
  Future <void> initTextToSpeech() async {
    await flutterTts.setSharedInstance(true);
    setState(() {

    });
  }
  /// this happens only once per deivce at start
  Future <void> initSpeechToText() async {
    await speechToText.initialize();
    setState(() {

    });
  }
  /// Each time to start a speech recognition session
  Future<void> startListening() async {
    if (speechToText.isAvailable) {
      await speechToText.listen(onResult: onSpeechResult);
    } else {
      debugPrint('Speech recognition is not available');
    }
  }


  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  Future <void> stopListening() async {
    await speechToText.stop();

    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
      // print(lastWords.toString());
    });
  }
  Future<void> systemSpeak(String content)async{
    await flutterTts.speak(content);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    speechToText.stop();
    flutterTts.stop();
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(top: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Pallete.whiteColor,
          elevation: 0,
          centerTitle: true,
          title: Container(child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("ChatGPT",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,fontFamily: 'Cera Pro')),
                Icon(Icons.star_rate, size: 16,)
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
              Visibility(
                visible: generatedUrl==null,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                    margin: EdgeInsets.symmetric(horizontal: 40,vertical: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Pallete.borderColor
                      ),
                      borderRadius: BorderRadius.circular(20).copyWith(topLeft: Radius.zero)
                    ),
                  child: Text(
                      generatedContent == null?"Good Morning, What task can I do for you ?":generatedContent!,
                      style: TextStyle(fontFamily: 'Cera Pro',
                        fontSize: generatedContent==null?25:18,
                        color: Pallete.mainFontColor,)),
                ),
              ),
              if (generatedUrl!=null) Padding(
                padding: const EdgeInsets.all(15.0),
                child: ClipRRect(borderRadius: BorderRadius.circular(20),child: Image.network(generatedUrl!)),
              ),
              Visibility(
                visible: generatedContent==null && generatedUrl==null,
                  child: Container(margin: EdgeInsets.only(left: 20),alignment: Alignment.centerLeft,child: Text("Here are few features",style: TextStyle(color: Pallete.mainFontColor,fontFamily: 'Cera Pro',fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.start,))),
              Visibility(
                visible: generatedContent==null && generatedUrl==null,
                child: Column(
                  children: [
                    FeatureBox(title: "ChatGPT", subTitle: "A smarter way to stay organised and informed with ChatGPT", boxColor: Pallete.firstSuggestionBoxColor),
                    FeatureBox(title: "Dall-E", subTitle: 'Get inspired and stay creative with your personal assistant powered by Dall-E', boxColor: Pallete.secondSuggestionBoxColor),
                    FeatureBox(title: "Smart Voice Assistant", subTitle: "Get the best of both worlds with a voice assistant powered by Dall-E and ChatGPT", boxColor: Pallete.thirdSuggestionBoxColor),
                  ],
                ),
              )
          
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async{
            if(await speechToText.hasPermission && await speechToText.isNotListening){
              await startListening();
            }
            else if (speechToText.isListening){
              final speech = await openAIServices.isArtPromptApi(lastWords);
              if(speech.contains('https')){
                generatedContent=null;
                generatedUrl=speech;
                setState(() {

                });
              }else{
                generatedUrl=null;
                generatedContent=speech;
                await systemSpeak(speech);
                setState(() {

                });
              }
              await stopListening();
            }else{
              initSpeechToText();
            }
          },

          child: Icon(Icons.mic),
        ),
      ),
    );
  }
}
