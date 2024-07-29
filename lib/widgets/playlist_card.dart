import 'package:flutter/material.dart';
import 'package:music_app/models/playlist_model.dart';
import 'package:get/get.dart';

class PlaylistCard extends StatelessWidget {
  const PlaylistCard({
    Key? key,
    required this.playlist,
    required this.index,
  }) : super(key: key);

  final Playlist playlist;
  final int index;

  @override
  Widget build(BuildContext context) {
    return
      InkWell(
        onTap: (){
          Get.toNamed('/playlist',arguments:{
            'index':index,
            'playlist':playlist
          });
        },
        child: Container(
        height: 75,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20,),
        decoration: BoxDecoration(
          color: Colors.deepPurple.shade800.withOpacity(0.6),
          borderRadius: BorderRadius.circular(15)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,

          children: [
            ClipRRect(
              child: Image.asset(playlist.imageUrl,height: 50,width: 50,fit: BoxFit.cover,),
              borderRadius: BorderRadius.circular(15),
            ),
            const SizedBox(width: 20,),
            Expanded(

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    playlist.title,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold,),
                  ),
                  Text(
                    '${playlist.songs.length} songs',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold,),
                  )
                ],
              ),

            ),
            IconButton(onPressed: (){}, icon: Icon(Icons.play_circle,color: Colors.white,))

          ],
        ),
    ),
      );
  }
}