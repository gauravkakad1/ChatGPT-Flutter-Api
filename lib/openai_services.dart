import 'dart:convert';

import 'package:chatgpt_flutter_app/secret_key.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'dart:io';

class OpenAIServices{

  final List<Map<String,String>> messages=[];

  Future <String> isArtPromptApi (String prompt)async{

    try{
      final res = await http.post(Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Content-Type': 'application/json',
          'Authorization': 'Bearer $openAIAPIKey'},
          body: jsonEncode(
              {
                "model": "gpt-3.5-turbo",
                "messages": [
                  {
                    'role': 'user',
                    'content': 'Does this message want to generate an AI picture, image, art or anything similar? $prompt . Simply answer with a yes or no.',
                  }
                ],
              }
          )
      );
      if(res.statusCode ==200){
        String content = jsonDecode(res.body)['choices'][0]['messages']['content'];
        content=content.trim();
        switch(content){
          case 'Yes':
            final res = await dallEApi(prompt);
            return res;
          case 'yes':
            final res = await dallEApi(prompt);
            return res;
          case 'Yes.':
            final res = await dallEApi(prompt);
            return res;
          case 'yes.':
            final res = await dallEApi(prompt);
            return res;
          default:
            final res = await chatGPTApi(prompt);
            return res;
        }
      }
      return 'An internal error occurred';
    }catch (e){
      throw e.toString();
    }
  }

  Future <String> chatGPTApi (String prompt)async{
    messages.add(
        {
          'role':'user',
          'content':prompt
        }
    );
    try{
      
      final res = await http.post(Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $openAIAPIKey',
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": messages,
        }),
      );
      if(res.statusCode==200){
        String content = jsonDecode(res.body)['choices'][0]['message']['content'];
        content = content.trim();
        messages.add(
          {
            'role':'assistant',
            'content':content
          }
        );
        return content;
      }
      return 'An internal error occured';
    }catch(e){
      throw e.toString();
    }
  }

  Future <String> dallEApi (String prompt)async{
    messages.add(
        {
          'role':'user',
          'content':prompt
        }
    );
  try{
    final res  = await http.post(Uri.parse('https://api.openai.com/v1/images/generations'),
    headers: {
       'Content-Type': 'application/json',
       'Authorization': 'Bearer $openAIAPIKey'
        },
      body: {
        "model": "dall-e-3",
        "prompt": prompt,
        "n": 1,
        "size": "1024x1024"
      }
    );
    if(res.statusCode==200){
      String url = jsonDecode(res.body)['data'][0]['url'];
      url = url.trim();
      messages.add(
          {
            'role':'assistant',
            'content':url
          }
      );
      return url;
    }
    return 'An internal error occured';
  }catch (e) {
    throw e.toString();
  }
  }

}