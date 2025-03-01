import 'package:flutter/material.dart';
import 'package:music_app/models/song_model.dart';
import 'package:get/get.dart';

class SongCard extends StatelessWidget {
  const SongCard({
    Key? key,
    required this.song,
    required this.index,
  }) : super(key: key);

  final  song;
  final index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.toNamed('/song',arguments:{
          'data':song,
          'index':index
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        child: Stack(
            alignment: Alignment.bottomCenter,
          children: [
            Container(

              width: MediaQuery.of(context).size.width * 0.45,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
                color: Colors.white.withOpacity(0.8),

                image: DecorationImage(
                    image: AssetImage(song[index].coverUrl),
                    fit: BoxFit.cover
                )
            ),
          ),
            Container(
              height: 50,

              width: MediaQuery.of(context).size.width * 0.37,
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white.withOpacity(0.8),


              ),
              child: Row(

                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(song[index].title,style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold
                      ),),
                      Text(song[index].artist,style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold
                      ),)
                    ],
                  ),
                  Icon(Icons.play_circle,color: Colors.deepPurple,)
                ],
              ),
            ),

        ]
        ),
      ),
    );
  }
}