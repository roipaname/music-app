import 'package:flutter/material.dart';
import 'package:music_app/models/song_model.dart';
import 'package:music_app/widgets/section_header.dart';
import 'package:music_app/widgets/song_card.dart';
import 'package:music_app/models/playlist_model.dart';
import 'package:music_app/widgets/playlist_card.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Song> song= Song.songs;
    List<Playlist> playlist= Playlist.playlist;
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
        appBar: _CustomAppBar(),
        bottomNavigationBar:_customNavBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const _discoverMusic(),
              _TrendigMusic(song: song),
              _PlaylistMusic(playlist: playlist),
              Center(
                child: TextButton.icon(onPressed: (){
                  Get.toNamed('/screen');
                }, icon: Icon(Icons.arrow_forward_ios), label: Text('Songs',style:Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),)),
              )


            ],
          ),
        ),
      ),
    );
  }
}

class _PlaylistMusic extends StatelessWidget {
  const _PlaylistMusic({
    Key? key,
    required this.playlist,
  }) : super(key: key);

  final List<Playlist> playlist;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const SectionHeader(title: 'PlayList'),
          ListView.builder(
            padding: const EdgeInsets.only(top: 20),
            shrinkWrap: true,
            physics:const  NeverScrollableScrollPhysics(),
            itemCount: playlist.length,
            itemBuilder: (context,index){
              return PlaylistCard(playlist: playlist[index],index: index,);

            },

          )
        ],
      ),
    );
  }
}



class _TrendigMusic extends StatelessWidget {
  const _TrendigMusic({
    Key? key,
    required this.song,
  }) : super(key: key);

  final  song;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20,top: 20,bottom: 20),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: SectionHeader(title: 'Trending music',),
          ),
          const SizedBox(height: 20,),
          SizedBox(height: MediaQuery.of(context).size.height*0.27,child:ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: song.length,
            itemBuilder:(context,index){
              return SongCard(song: song,index: index,);
            } ,

          ),)

        ],
      ),
    );
  }
}





class _discoverMusic extends StatelessWidget {
  const _discoverMusic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              'Welcome',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 5),
          Text(
            'Enjoy your favorite music',
            style: Theme.of(context).textTheme.headline6!.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8,),
          TextFormField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              isDense: true,
              hintText: 'Search',
              hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.grey..shade400),
              prefixIcon: Icon(Icons.search,color: Colors.grey.shade400,),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide.none
              )
            ),
          )
        ],
      ),
    );
  }
}
class _CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const _CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: const Icon(Icons.grid_view_rounded),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 20),
          child: CircleAvatar(
            backgroundImage: AssetImage('image/mist2.png'),
          ),
        )
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(56.0);
}
class _customNavBar extends StatelessWidget {
  const _customNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.deepPurple.shade800,
      unselectedItemColor: Colors.white,
      selectedItemColor: Colors.white,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(icon: IconButton(icon:Icon(Icons.home),onPressed: (){
          Get.toNamed('/home');
        },),label: 'Home',),

        BottomNavigationBarItem(icon: IconButton(icon:Icon(Icons.favorite_outline),onPressed: (){
          Get.toNamed('/playlist',arguments: {
            'playlist':Playlist.playlist[0]
          });
        },),label: 'Favorite'),
        BottomNavigationBarItem(icon: IconButton(icon:Icon(Icons.play_circle_outline),onPressed: (){
          Get.toNamed('/screen');
        },),label: 'Play'),
        BottomNavigationBarItem(icon: Icon(Icons.people_outline),label: 'Profile'),
      ],
    );
  }
}

