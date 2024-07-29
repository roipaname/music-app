import 'package:flutter/material.dart';

class Song{
  final String title;
  final String artist;
  final String uri;
  final String coverUrl;
  final String id;
  final String album;

  Song({
    required this.title,
    required this.coverUrl,
    required this.artist,
    required this.uri,
    required this.id,
    required this.album
});

  static List<Song> songs=[
    Song(title: 'Amari', coverUrl: 'image/gr3.jpg', artist:'Jcole', uri:'asset:///assets/amari.mp3',id: '1',album: 'Jcole'),
    Song(title: 'Arcade', coverUrl: 'image/gr5.jpg', artist:'Duncan', uri:'asset:///assets/arcade.mp3',id: '2',album: 'Duncan'),
    Song(title: 'Gbona', coverUrl: 'image/gr8.jpg', artist:'African Giant', uri:'asset:///assets/gbona.mp3',id: '3',album: 'one'),
    Song(title: 'Grand Bain', coverUrl: 'image/gr10.jpg', artist:'Dadju', uri:'asset:///assets/grandbain.mp3',id: '4',album: 'one'),
    Song(title: 'Heaven Gate', coverUrl: 'image/gr12.jpg', artist:'Burna', uri:'asset:///assets/heavengate.mp3',id: '5',album: 'one'),
    Song(title: 'Wednesday Child', coverUrl: 'image/s1.jpg', artist:'Alicia', uri:'asset:///assets/wednesdaychild.mp3',id: '6',album: 'one'),

  ];



}