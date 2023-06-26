library globals;

import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';
import 'package:banktime/model/dog.dart';

Dog? currentDog;
VideoPlayerController? controller;
ChewieController? chweiecontroller;

class DogSelectedProvider extends ChangeNotifier {
  Dog? dogSelectedProvider;
  void changeDogSelected(Dog? newValue) {
    dogSelectedProvider = newValue;
    notifyListeners();
  }
}
