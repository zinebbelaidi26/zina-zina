import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MainScreen extends StatefulWidget {
  final String translatedText;

  const MainScreen({super.key, required this.translatedText});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<String> _words = [];
  int _currentWordIndex = 0;
  VideoPlayerController? _controller;
  bool _isPlaying = false;
  String? _errorMessage;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // تقسيم النص إلى كلمات وإزالة الفراغات
    _words =
        widget.translatedText
            .split(' ')
            .where((word) => word.trim().isNotEmpty)
            .toList();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    if (_words.isEmpty) {
      setState(() {
        _errorMessage = 'لا توجد كلمات للترجمة';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final currentWord = _words[_currentWordIndex].toLowerCase();
    final videoPath = _getVideoForWord(currentWord);

    try {
      // التخلص من المتحكم القديم إن وجد
      await _controller?.dispose();

      _controller = VideoPlayerController.asset(videoPath)
        ..initialize()
            .then((_) {
              setState(() {
                _isLoading = false;
              });
              _controller?.setLooping(false);
              _controller?.addListener(_videoListener);
            })
            .catchError((error) {
              setState(() {
                _isLoading = false;
                _errorMessage = 'لا يوجد فيديو متاح لكلمة "$currentWord"';
              });
            });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'حدث خطأ: ${e.toString()}';
      });
    }
  }

  void _videoListener() {
    if (_controller != null &&
        !_controller!.value.isPlaying &&
        _controller!.value.position == _controller!.value.duration) {
      setState(() {
        _isPlaying = false;
      });
    }
  }

  String _getVideoForWord(String word) {
    // خريطة الفيديوهات - يجب أن تكون كل المفاتيح بأحرف صغيرة
    final Map<String, String> videoMap = {
      "Hello": "assets/videos/Hello(240p).mp4",
      "Goodbye": "assets/videos/Goodbye(240p).mp4",
      "Whisper": "assets/videos/Whisper(240p).mp4",
      "Myself": "assets/videos/Myself(240p).mp4",
      "Herself": "assets/videos/Herself(240p).mp4",
      "Himself": "assets/videos/Himself(240p).mp4",
      "Itself": "assets/videos/Itself(240p).mp4",
      "Push": "assets/videos/Push(240p).mp4",
      "Pull": "assets/videos/Pull(240p).mp4",
      "Give": "assets/videos/Give(240p).mp4",
      "Hold": "assets/videos/Hold(240p).mp4",
      "Climb": "assets/videos/Climb(240p).mp4",
      "Take": "assets/videos/Take(240p).mp4",
      "Clothes": "assets/videos/Clothes(240p).mp4",
      "Blouse": "assets/videos/Blouse(240p).mp4",
      "Dress": "assets/videos/Dress(240p).mp4",
      "Necklace": "assets/videos/Necklace(240p).mp4",
      "Necktie": "assets/videos/Necktie(240p).mp4",
      "Glasses": "assets/videos/Glasses(240p).mp4",
      "Bowtie": "assets/videos/Bowtie(240p).mp4",
      "Cup": "assets/videos/Cup(240p).mp4",
      "Glass": "assets/videos/Glass(240p).mp4",
      "Berry": "assets/videos/Berry(240p).mp4",
      "Pear": "assets/videos/Pear(240p).mp4",
      "Deer": "assets/videos/Deer(240p).mp4",
      "Racoon": "assets/videos/Racoon(240p).mp4",
      "Skunk": "assets/videos/Skunk(240p).mp4",
      "Rooster": "assets/videos/Rooster(240p).mp4",
      "Turkey": "assets/videos/Turkey(240p).mp4",
      "Camel": "assets/videos/Camel(240p).mp4",
      "Wolf": "assets/videos/Wolf(240p).mp4",
      "Zebra": "assets/videos/Zebra(240p).mp4",
      "Card": "assets/videos/Card(240p).mp4",
      "Sign": "assets/videos/Sign(240p).mp4",
      "Jail": "assets/videos/Jail(240p).mp4",
      "Tent": "assets/videos/Tent(240p).mp4",
      "Reduce": "assets/videos/Reduce(240p).mp4",
      "Spread": "assets/videos/Spread(240p).mp4",
      "Freeze": "assets/videos/Freeze(240p).mp4",
      "Melt": "assets/videos/Melt(240p).mp4",
      "Warn": "assets/videos/Warn(240p).mp4",
      "Punish": "assets/videos/Punish(240p).mp4",
      "Chew": "assets/videos/Chew(240p).mp4",
      "Bite": "assets/videos/Bite(240p).mp4",
      "Measure": "assets/videos/Measure(240p).mp4",
      "Balance": "assets/videos/Balance(240p).mp4",
      "Vote": "assets/videos/Vote(240p).mp4",
      "Divide": "assets/videos/Divide(240p).mp4",
      "Shine": "assets/videos/Shine(240p).mp4",
      "Beg": "assets/videos/Beg(240p).mp4",
      "Bleed": "assets/videos/Bleed(240p).mp4",
      "Boil": "assets/videos/Boil(240p).mp4",
      "Fox": "assets/videos/Fox(240p).mp4",
      "Law": "assets/videos/Law(240p).mp4",
      "License": "assets/videos/License(240p).mp4",
      "Queen": "assets/videos/Queen(240p).mp4",
      "Shake": "assets/videos/Shake(240p).mp4",
      "Spread Scatter": "assets/videos/Spread Scatter(240p).mp4",
      "Sweat": "assets/videos/Sweat(240p).mp4",
      "Share": "assets/videos/Share(240p).mp4",
      "Bleed and Blood": "assets/videos/Bleed and Blood(240p).mp4",
      "Throw out": "assets/videos/Throw out(240p).mp4",
      "Wed": "assets/videos/Wed(240p).mp4",
      "Lesson and Course": "assets/videos/Lesson and Course(240p).mp4",
      "Coffee bad for you": "assets/videos/Coffee bad for you(240p).mp4",
      "President": "assets/videos/President(240p).mp4",
      "Decorate": "assets/videos/Decorate(240p).mp4",
      "Hands communicating": "assets/videos/Hands communicating(240p).mp4",
      "Give 6 meanings": "assets/videos/Give 6 meanings(240p).mp4",
      "Shhh": "assets/videos/Shhh(240p).mp4",
      "Me and I": "assets/videos/Me and I(240p).mp4",
      "My and Mine": "assets/videos/My and Mine(240p).mp4",
      "You": "assets/videos/You(240p).mp4",
      "Car": "assets/videos/Car(240p).mp4",
      "Telephone": "assets/videos/Telephone(240p).mp4",
      "Eat and Food": "assets/videos/Eat and Food(240p).mp4",
      "Drink": "assets/videos/Drink(240p).mp4",
      "Camera": "assets/videos/Camera(240p).mp4",
      "Strong": "assets/videos/Strong(240p).mp4",
      "Pray": "assets/videos/Pray(240p).mp4",
      "Stink": "assets/videos/Stink(240p).mp4",
      "Crazy": "assets/videos/Crazy(240p).mp4",
      "A little bit": "assets/videos/A little bit(240p).mp4",
      "None": "assets/videos/None(240p).mp4",
      "Big": "assets/videos/Big(240p).mp4",
      "Small": "assets/videos/Small(240p).mp4",
      "Throw": "assets/videos/Throw(240p).mp4",
      "Catch": "assets/videos/Catch(240p).mp4",

      "Drop": "assets/videos/Drop(240p).mp4",
      "Move": "assets/videos/Move(240p).mp4",
      "Carry": "assets/videos/Carry(240p).mp4",
      "Writing": "assets/videos/Writing(240p).mp4",
      "Break": "assets/videos/Break(240p).mp4",
      "Tear or rip": "assets/videos/Tear or rip(240p).mp4",
      "Exercise": "assets/videos/Exercise(240p).mp4",
      "Swim": "assets/videos/Swim(240p).mp4",
      "Tennis": "assets/videos/Tennis(240p).mp4",
      "Ball": "assets/videos/Ball(240p).mp4",
      "Boxing": "assets/videos/Boxing(240p).mp4",
      "Fishing": "assets/videos/Fishing(240p).mp4",
      "Archery": "assets/videos/Archery(240p).mp4",
      "Baseball": "assets/videos/Baseball(240p).mp4",
      "Strangle": "assets/videos/Strangle(240p).mp4",
      "Nervous": "assets/videos/Nervous(240p).mp4",
      "Time": "assets/videos/Time(240p).mp4",
      "Baby": "assets/videos/Baby(240p).mp4",
      "Umbrella": "assets/videos/Umbrella(240p).mp4",
      "Faucet": "assets/videos/Faucet(240p).mp4",
      "Razor": "assets/videos/Razor(240p).mp4",
      "Brush": "assets/videos/Brush(240p).mp4",
      "Ring": "assets/videos/Ring(240p).mp4",
      "Iron": "assets/videos/Iron(240p).mp4",
      "Sweep or broom": "assets/videos/Sweep or broom(240p).mp4",
      "Vacuum": "assets/videos/Vacuum(240p).mp4",
      "Sew": "assets/videos/Sew(240p).mp4",
      "Scissors": "assets/videos/Scissors(240p).mp4",
      "Face": "assets/videos/Face(240p).mp4",
      "Eyebrow": "assets/videos/Eyebrow(240p).mp4",
      "Eye": "assets/videos/Eye(240p).mp4",
      "Nose": "assets/videos/Nose(240p).mp4",
      "Mouth": "assets/videos/Mouth(240p).mp4",
      "Tooth": "assets/videos/Tooth(240p).mp4",
      "Hands": "assets/videos/Hands(240p).mp4",
      "Body": "assets/videos/Body(240p).mp4",
      "We": "assets/videos/We(240p).mp4",
      "Our": "assets/videos/Our(240p).mp4",
      "Your": "assets/videos/Your(240p).mp4",
      "Her": "assets/videos/Her(240p).mp4",
      "Their": "assets/videos/Their(240p).mp4",
      "Here": "assets/videos/Here(240p).mp4",
      "There": "assets/videos/There(240p).mp4",
      "This": "assets/videos/This(240p).mp4",
      "These": "assets/videos/These(240p).mp4",
      "Other": "assets/videos/Other(240p).mp4",
      "Any": "assets/videos/Any(240p).mp4",
      "Don't": "assets/videos/Don't(240p).mp4",
      "Not": "assets/videos/Not(240p).mp4",
      "Remind": "assets/videos/Remind(240p).mp4",
    };

    // إرجاع الفيديو المناسب أو فيديو افتراضي إذا لم يوجد
    return videoMap[word] ?? 'assets/videos/Hello(240p).mp4';
  }

  void _playVideo() {
    if (_controller?.value.isInitialized ?? false) {
      setState(() {
        _isPlaying = true;
      });
      _controller?.play();
    }
  }

  void _pauseVideo() {
    setState(() {
      _isPlaying = false;
    });
    _controller?.pause();
  }

  void _changeWord(int index) {
    if (index < 0 || index >= _words.length) return;

    setState(() {
      _currentWordIndex = index;
      _isPlaying = false;
    });
    _initializeVideo();
  }

  @override
  void dispose() {
    _controller?.removeListener(_videoListener);
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentWord = _words.isNotEmpty ? _words[_currentWordIndex] : '';

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 15, 39, 252),
                Color.fromARGB(255, 0, 191, 255),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text("لغة الإشارة", style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 400,
                child: Center(
                  child:
                      _isLoading
                          ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(height: 10),
                              Text('جاري تحميل الفيديو...'),
                            ],
                          )
                          : _errorMessage != null
                          ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error_outline,
                                color: Colors.red,
                                size: 50,
                              ),
                              SizedBox(height: 10),
                              Text(
                                _errorMessage!,
                                style: TextStyle(color: Colors.red),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          )
                          : _controller != null &&
                              _controller!.value.isInitialized
                          ? AspectRatio(
                            aspectRatio: _controller!.value.aspectRatio,
                            child: VideoPlayer(_controller!),
                          )
                          : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.videocam_off,
                                size: 50,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 10),
                              Text('لا يتوفر فيديو'),
                            ],
                          ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      _isPlaying
                          ? Icons.pause_circle_filled
                          : Icons.play_circle_fill,
                      size: 50,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      if (_isPlaying) {
                        _pauseVideo();
                      } else {
                        _playVideo();
                      }
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.replay_circle_filled,
                      size: 50,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      _controller?.seekTo(Duration.zero);
                      _playVideo();
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                currentWord,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                widget.translatedText,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: Colors.blue),
                    onPressed:
                        _currentWordIndex > 0
                            ? () => _changeWord(_currentWordIndex - 1)
                            : null,
                  ),
                  SizedBox(width: 20),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios, color: Colors.blue),
                    onPressed:
                        _currentWordIndex < _words.length - 1
                            ? () => _changeWord(_currentWordIndex + 1)
                            : null,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
