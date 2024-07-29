import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_app/models/song_model.dart';
import 'package:music_app/widgets/seekbar.dart';
import 'package:rxdart/rxdart.dart' as rxdart;
import 'package:music_app/widgets/player_button.dart';
import 'package:get/get.dart';

class SongScreen extends StatefulWidget {
  const SongScreen({Key? key}) : super(key: key);

  @override
  State<SongScreen> createState() => _SongScreenState();

}




class _SongScreenState extends State<SongScreen> {
  var sung= Get.arguments['data']?? Song.songs[0];
  int index=Get.arguments['index'];
  AudioPlayer audioPlayer= AudioPlayer();

  //Song song = Song(title:sung.title,coverUrl: sung.);


  @override
  void initState(){
    super.initState();
    audioPlayer.setAudioSource(
        ConcatenatingAudioSource(
            children: [
          AudioSource.uri(
              Uri.parse(sung[index].uri),
            tag: MediaItem(
              // Specify a unique ID for each media item:
              id: sung[index].id,
              // Metadata to display in the notification:
              album: sung[index].album,
              title: sung[index].title,
              artUri: Uri.parse('https://example.com/albumart.jpg'),
            ),
          ),
              AudioSource.uri(
                  Uri.parse(sung[index+1].uri),
    tag: MediaItem(
    // Specify a unique ID for each media item:
    id: sung[index+1].id,
    // Metadata to display in the notification:
    album: sung[index+1].album,
    title: sung[index+1].title,
    artUri: Uri.parse('https://example.com/albumart.jpg'),

    )),
              AudioSource.uri(
                  Uri.parse(sung[index+2].uri),
    tag: MediaItem(
    // Specify a unique ID for each media item:
    id: sung[index+2].id,
    // Metadata to display in the notification:
    album: sung[index+2].artist,
    title: sung[index+2].title,
    artUri: Uri.parse('https://example.com/albumart.jpg'),
              ),
              )


        ])
    );


  }

  @override
  void dispose(){
    super.dispose();
    audioPlayer.dispose();

  }
  Stream<SeekBarData> get _seekBarDataStream=> rxdart.Rx.combineLatest2<Duration,Duration?,SeekBarData>(
      audioPlayer.positionStream,
      audioPlayer.durationStream,
          (Duration position,Duration? duration){
        return SeekBarData(position, duration ?? Duration.zero,);

      }
  );
  @override
  Widget build(BuildContext context) {
    print(sung);
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
        Image.asset('image/gr12.jpg',fit: BoxFit.cover,),
          const _BackgroundFilter(),
          _MusicPlayer(
              song:sung[index],
              seekBarDataStream: _seekBarDataStream,
              audioPlayer: audioPlayer)
        ],
      ),
    );
  }
}



class _MusicPlayer extends StatelessWidget {
  const  _MusicPlayer({
    Key? key,
    required Stream<SeekBarData> seekBarDataStream,
    required this.audioPlayer,
    required this.song
  }) : _seekBarDataStream = seekBarDataStream, super(key: key);

  final Stream<SeekBarData> _seekBarDataStream;
  final AudioPlayer audioPlayer;
  final song;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(song.title,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(height: 10,),
          Text(
            song.artist,
            maxLines: 2,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(height: 30,),
          StreamBuilder<SeekBarData>(
            stream: _seekBarDataStream,
              builder: (context,snapshot){
              final positionData=snapshot.data;
              return Seekbar(position: positionData?.position ?? Duration.zero,
                  duration: positionData?.duration?? Duration.zero,
              onChangedEnd: audioPlayer.seek,);
              }
          ),
          PlayerButton(audioPlayer: audioPlayer,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(iconSize:35,onPressed: (){}, icon: Icon(Icons.settings,
                color: Colors.white,)),
              IconButton(iconSize: 35,onPressed: (){}, icon: Icon(Icons.cloud_download,
                color: Colors.white,
              )),
            ],
          )
        ],
      ),
    );
  }
}



class _BackgroundFilter extends StatelessWidget {
  const _BackgroundFilter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.dstOut,
      shaderCallback: (rect){
        return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Colors.white.withOpacity(0.5),
              Colors.white.withOpacity(0.0)
            ],
          stops:const  [0.0,0.4,0.6]).createShader(rect);
      },
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.deepPurple.shade200,
                  Colors.deepPurple.shade800
                ]
            )
        ),
      ),
    );
  }
}
