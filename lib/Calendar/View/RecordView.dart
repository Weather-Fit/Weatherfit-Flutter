import 'package:flutter/material.dart';
import '../../Util/calendar_service.dart';
import '../../app_theme.dart';

class RecordView extends StatefulWidget {
  const RecordView({
    Key? key,
  }) : super(key: key);

  @override
  State<RecordView> createState() => _RecordViewState();
}

class _RecordViewState extends State<RecordView> {
  TextEditingController textController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController temperatureController =
      TextEditingController(); // temperature input controller

  DateTime currentTime = DateTime.now();
  @override
  void initState() {
    super.initState();
    print(RecordService.instance.user);
  }

  final List<String> _imagePaths = [
    'asset/images/img_t_white.jpg',
    'asset/images/img_t_yellow.jpg',
    'asset/images/img_t_gray.jpg',
    'asset/images/img_t_green.jpg',
    'asset/images/img_t_short_white.jpg',
    'asset/images/img_t_short_pink.jpg',
    'asset/images/img_t_short_purple.jpg',
    'asset/images/img_t_short_blue.jpg',
    'asset/images/img_vest_grey.png',
    'asset/images/img_jacket_gray.jpg',
    'asset/images/img_jacket_black.jpg',
    'asset/images/img_jacket_ivory.jpg',
    'asset/images/img_hoodie_grey.png',
    'asset/images/img_hoodie_black.png',
    'asset/images/img_padding_navy.png',
    'asset/images/img_coat_black.jpg',
    'asset/images/img_coat_brown.jpg',
    'asset/images/img_moostang.png',
    'asset/images/img_padding_black.png',
    'asset/images/img_ops_long_white.jpg',
    'asset/images/img_ops_long_pink.jpg',
    'asset/images/img_ops_black.png',
    'asset/images/img_shirt_sora.jpg',
    'asset/images/img_shirt_white.jpg',
    'asset/images/img_cardigan_grey.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 100),
            Text(
              "코디와 어울리는 아이콘을 선택하세요.",
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w600,
                color: AppTheme().lightTheme.colorScheme.tertiary,
              ),
            ),
            ImageGrid(
              imagePaths: _imagePaths,
              imageController: imageController,
            ),
            SizedBox(height: 10),
            TextField(
              controller: textController,
              decoration: InputDecoration(
                hintText: "코디를 작성해주세요.",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16), // additional spacing
            TextField(
              controller: temperatureController,
              decoration: InputDecoration(
                hintText: "현재 온도를 입력해주세요.",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number, // input for number
            ),
            SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme().lightTheme.colorScheme.tertiary,
              ),
              onPressed: () {
                if (textController.text.isNotEmpty &&
                    imageController.text.isNotEmpty) {
                  RecordService.instance.create(
                    textController.text,
                    imageController.text,
                    RecordService.instance.selectedDay,
                    currentTime,
                    int.parse(temperatureController.text),
                  );
                }
                Navigator.pop(context, true);
              },
              child: Text("완료", style: TextStyle(fontSize: 21)),
            )
          ],
        ),
      ),
    );
  }
}

class ImageGrid extends StatefulWidget {
  final List<String> imagePaths;
  final TextEditingController imageController;

  ImageGrid({required this.imagePaths, required this.imageController});

  @override
  _ImageGridState createState() => _ImageGridState();
}

class _ImageGridState extends State<ImageGrid> {
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
        ),
        itemCount: widget.imagePaths.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: Stack(
              children: [
                Image.asset(widget.imagePaths[index]),
                if (_selectedIndex == index)
                  Container(
                    color: Colors.black26,
                    child: Icon(Icons.check, color: Colors.white),
                  ),
              ],
            ),
            onTap: () {
              widget.imageController.text = widget.imagePaths[index];
              setState(() {
                _selectedIndex = index;
              });
            },
          );
        },
      ),
    );
  }
}
