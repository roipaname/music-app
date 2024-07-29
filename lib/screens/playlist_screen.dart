import 'package:flutter/material.dart';

import '../models/playlist_model.dart';
import 'package:get/get.dart';

class PlaylistScreen extends StatelessWidget {
   const PlaylistScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {

    Playlist playlist= Get.arguments['playlist']??Playlist.playlist[0];
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
          title:const Text('Playlist'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Center(child: _playlistInformation(playlist: playlist)),
                const SizedBox(height: 30,),
                const _PlayShuffleSwitch(),
                _PlaylistSongs(playlist: playlist)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PlaylistSongs extends StatelessWidget {
  const _PlaylistSongs({
    Key? key,
    required this.playlist,
  }) : super(key: key);

  final Playlist playlist;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: playlist.songs.length,
      itemBuilder: (context,index){
        return GestureDetector(
          onTap: (){
            Get.toNamed('/song',arguments: {
              'data':playlist.songs,
              'index':index
            });
          },
          child: ListTile(
            leading: Text(
              '${index+1}',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold
              ),
            ),
            title:Text(
              playlist.songs[index].title,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold
              ),
            ) ,
            subtitle: Text('${playlist.songs[index].artist}° 0${index<=1?index+1:(index/2).round()}:4${index}'),
            trailing: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}

class _PlayShuffleSwitch extends StatefulWidget {
  const _PlayShuffleSwitch({
    Key? key,
  }) : super(key: key);

  @override
  State<_PlayShuffleSwitch> createState() => _PlayShuffleSwitchState();
}

class _PlayShuffleSwitchState extends State<_PlayShuffleSwitch> {
  bool isPlay=true;
  
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: (){
        setState(() {
          isPlay=!isPlay;
        });
      },
      child: Container(
        height: 50,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15)
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 100),
              left: isPlay?0:width*0.45,
              child: Container(
              height: 50,
              width: width*0.45,
              decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(15)
              ),),
            ),
            Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                          'Play',
                        style: TextStyle(
                          color: isPlay? Colors.white:Colors.deepPurple,
                          fontSize: 17
                        ),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Icon(Icons.play_circle,
                      color: isPlay? Colors.white:Colors.deepPurple,)
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        'Shuffle',
                        style: TextStyle(
                          color: isPlay? Colors.deepPurple:Colors.white,
                          fontSize: 17
                        ),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Icon(Icons.shuffle,
                      color: isPlay? Colors.deepPurple:Colors.white,)
                  ],
                ),
              )
            ],
          ),
                  ]
        ),
      ),
    );
  }
}

class _playlistInformation extends StatelessWidget {
  const _playlistInformation({
    Key? key,
    required this.playlist,
  }) : super(key: key);

  final Playlist playlist;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.asset(playlist.imageUrl,
            height: MediaQuery.of(context).size.height*0.3,
            width: MediaQuery.of(context).size.height*0.3,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 30,),
        Text(
          playlist.title,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              fontWeight: FontWeight.bold
          ),
        )

      ],
    );
  }
}
