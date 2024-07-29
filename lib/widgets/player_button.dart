import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/models/song_model.dart';
import 'package:music_app/widgets/seekbar.dart';
import 'package:rxdart/rxdart.dart' as rxdart;


class PlayerButton extends StatelessWidget {
   const PlayerButton({
    Key? key,
    required this.audioPlayer,

  }) : super(key: key);

  final AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: StreamBuilder<SequenceState?>(
            stream: audioPlayer.sequenceStateStream,
              builder:(context,snapshot){
              return IconButton(
                onPressed:audioPlayer.hasPrevious? audioPlayer.seekToPrevious: null,
                  icon: Icon(Icons.skip_previous,color: Colors.white,),
              iconSize: 45,);
              }
          ),
        ),
        StreamBuilder<PlayerState>(
            stream: audioPlayer.playerStateStream,
            builder: (context,snapshot) {
              if(snapshot.hasData){
                final playerState= snapshot.data;
                final processingState= (playerState! as PlayerState).processingState ;
                if(processingState== ProcessingState.loading ||processingState==ProcessingState.buffering){
                  return Container(
                    width: 64.0,
                    height: 64.0,
                    margin: const EdgeInsets.all(10.0),
                    child:const CircularProgressIndicator(),
                  );
                }else if(!audioPlayer.playing) {
                  return IconButton(onPressed: audioPlayer.play,
                      icon: Icon(Icons.play_circle,color: Colors.white,size: 75,)
                  );
                }else if(processingState!=ProcessingState.completed){
                  return IconButton(onPressed: audioPlayer.pause,
                      icon: Icon(Icons.pause_circle_filled_outlined,color: Colors.white,size: 75,)
                  );
                }else{
                  return IconButton(onPressed:()=> audioPlayer.seek(Duration.zero,
                      index: audioPlayer.effectiveIndices!.first),
                      icon: Icon(Icons.replay_circle_filled_outlined,color: Colors.white,size: 75,)
                  );
                }

              }else{
                return const CircularProgressIndicator();
              }
            }
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 20, 0, 0),
          child: StreamBuilder<SequenceState?>(
              stream: audioPlayer.sequenceStateStream,
              builder:(context,snapshot){
                return IconButton(onPressed: audioPlayer.hasNext? audioPlayer.seekToNext: null,
                  icon: Icon(Icons.skip_next,color: Colors.white,),
                  iconSize: 45,);
              }
          ),
        ),
      ],
    );
  }
}