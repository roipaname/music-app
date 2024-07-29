import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:music_app/models/playlist_model.dart';
import '../models/playlist_model.dart';
import 'package:get/get.dart';

class Screen extends StatefulWidget {
  const Screen({Key? key}) : super(key: key);

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.deepPurple.shade800.withOpacity(0.8),
                Colors.deepPurple.shade200.withOpacity(0.8)
              ]
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title:const Text('Songs'),
          centerTitle: true,
        ),
        body: FutureBuilder(

          future: FlutterAudioQuery()
              .getSongs(sortType: SongSortType.DISPLAY_NAME),
          builder: (context, snapshot) {
            if (snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      Get.toNamed('/song',arguments: {
                        'data':snapshot.data!,
                        'index':index,
                      });
                    },
                    child: ListTile(
                      title: Text(snapshot.data![index].title),
                      leading: const CircleAvatar(
                        child: Icon(Icons.music_note),
                      ),
                      subtitle: Text(snapshot.data![index].artist),
                    ),
                  );
                },
              );


            }else{
              return Container(
                height: MediaQuery.of(context).size.height * 0.4,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Loading....",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              );
            }

          },
        ),
      ),
    );
  }
}



