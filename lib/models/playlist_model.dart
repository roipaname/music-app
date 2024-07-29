import 'package:flutter/material.dart';
import 'package:music_app/models/song_model.dart';
import 'package:music_app/widgets/section_header.dart';
import 'package:music_app/widgets/song_card.dart';

class Playlist{

  final String title;
  final List<Song> songs;
  final String imageUrl;
  Playlist({required this.title,required this.songs,required this.imageUrl});

  static List<Playlist> playlist=[
    Playlist(title: 'Hip-hop R&B Mix', songs: Song.songs, imageUrl: 'image/mist2.png'),
    Playlist(title: 'Rock & Roll', songs: Song.songs, imageUrl: 'image/gr8.jpg'),
    Playlist(title: 'Techno', songs: Song.songs, imageUrl: 'image/gr12.jpg')
  ];
}
