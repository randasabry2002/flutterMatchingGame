import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'ImageModel.dart';

class Images extends StatefulWidget {
  @override
  State<Images> createState() {
    return ImagesState();
  }
}

class ImagesState extends State<Images> {
  ///array dor the images values
  List<ImageModel> imagesList = [
    ImageModel(image: 'assets/images/image1.png'),
    ImageModel(image: 'assets/images/image2.png'),
    ImageModel(image: 'assets/images/image3.jpeg'),
    ImageModel(image: 'assets/images/image4.png'),
    ImageModel(image: 'assets/images/image5.jpeg'),
    ImageModel(image: 'assets/images/image1.png'),
    ImageModel(image: 'assets/images/image2.png'),
    ImageModel(image: 'assets/images/image6.jpeg'),
    ImageModel(image: 'assets/images/image4.png'),
    ImageModel(image: 'assets/images/image5.jpeg'),
    ImageModel(image: 'assets/images/image6.jpeg'),
    ImageModel(image: 'assets/images/image3.jpeg'),
  ];

  ///string variables to save the two paths of the clicked images
  String img1 = '', img2 = '';

  int click = 0,

      ///the number of clicks
      i1 = 20,

      ///the index of image 1
      i2 = 20,

      ///the index of image 2
      score = 0;

  ///the count of the matched images
  bool wonVisable = false,

      ///the message show
      clickable = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ///title
          AppBar(
            title: const Center(
              child: Text(
                'Matching Game',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            backgroundColor: Colors.orange,
          ),

          ///space
          const SizedBox(
            height: 30,
          ),

          ///images view
          Expanded(
            flex: 3,
            child: GridView.builder(
              itemCount: imagesList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemBuilder: (BuildContext context, int index) {
                return GridTile(
                    child: InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Image.asset(
                      ///لو القيمة بتاعت ال visable ب true يعرض الصورة غير كدا يعرض صورة علامة الاستفهام اللي هي ال default
                      imagesList[index].visable
                          ? imagesList[index].image!
                          : 'assets/images/imageQMark.png',

                      /// 'assets/images/imageQMark.png',
                      width: 60,
                      height: 200,
                    ),
                  ),
                  onTap: () {
                    // print('score = $score');
                    if (clickable) {
                      ///if nothing clicked yet
                      if (!imagesList[index].visable) {
                        ///if the image isn't shown already!!
                        click++;
                        if (click == 1) {
                          ///if it is the first image click!!
                          img1 = imagesList[index].image!;

                          ///save the image path
                          i1 = index;

                          ///save its index
                          imagesList[index].visable = true;

                          ///show the image
                          setState(() {});
                        } else if (click == 2) {
                          ///if it is the second image click!!
                          clickable = false;

                          ///stop clicking
                          img2 = imagesList[index].image!;

                          ///save the image path
                          i2 = index;

                          ///save its index
                          imagesList[index].visable = true;

                          ///show the image
                          setState(() {});
                          Future.delayed(
                            const Duration(milliseconds: 400),
                            () {
                              ///delay timer
                              if (img1 != img2) {
                                ///if they aren't the same!!
                                imagesList[i1].visable = false;
                                imagesList[i2].visable = false;
                                setState(() {});
                              } else {
                                score++;
                                if (score == 6) {
                                  ///if all images completed
                                  wonVisable = true;

                                  ///make win sound
                                  AssetsAudioPlayer assetsAudioPlayer =
                                      AssetsAudioPlayer();

                                  assetsAudioPlayer.open(
                                    Audio("assets/audios/success.mp3"),
                                  );
                                  assetsAudioPlayer.play();

                                  /// //////////////////////////////////

                                  setState(() {});
                                }
                              }
                              clickable = true;
                            },
                          );

                          click = 0;
                        }
                      }
                    }
                  },
                ));
              },
            ),
          ),

          ///win message
          Expanded(
            flex: 1,
            child: Visibility(
              visible: wonVisable,
              child: const Center(
                child: Text(
                  'Congratulations!! You Won',
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
