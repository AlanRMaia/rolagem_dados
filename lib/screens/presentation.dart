import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:rolagem_dados/widget/my_text_button.dart';
import 'package:rolagem_dados/widget/slide_tile.dart';

class Presentation extends StatefulWidget {
  @override
  _PresentationState createState() => _PresentationState();
}

class _PresentationState extends State<Presentation> {
  final PageController _pageController = PageController(viewportFraction: 0.8);
  int _currentPage = 0;

  final _listSlide = [
    {
      'id': 0,
      'image': 'assets/images/undraw_Chatting_re_j55r.svg',
      'messeger':
          'Crie salas interativas para jogar RPG com seus amigos, com rolagem de dados do D4 ao D20'
    },
    {
      'id': 1,
      'image': 'assets/images/undraw_add_friends_re_3xte.svg',
      'messeger':
          'Faça novos amigos e os adicione a sua sala de bate-papo e comece a jogar com eles'
    },
  ];

  @override
  void initState() {
    _pageController.addListener(() {
      final int next = _pageController.page.round();
      if (_currentPage != next) {
        setState(() {
          _currentPage = next;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _listSlide.length,
                itemBuilder: (_, currentIndex) {
                  // final activePage = currentIndex == _currentPage;
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            child: Image(
                              height: Get.height,
                              width: Get.width,
                              fit: BoxFit.fitWidth,
                              image: Svg(
                                  _listSlide[currentIndex]['image'].toString()),
                            ),
                          ),
                        ),
                        Container(
                            child: Text(
                          _listSlide[currentIndex]['messeger'].toString(),
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        )),
                      ]);
                },
              ),
            ),
            _buildBullets(),
            Row(
              children: [
                Expanded(
                  child: MyTextButton(
                      buttonName: 'Registrar',
                      onTap: () {
                        Get.toNamed('/signup');
                      },
                      bgColor: Get.isDarkMode ? Colors.white : Colors.black,
                      textColor:
                          Get.isDarkMode ? Colors.black87 : Colors.white),
                ),
                Expanded(
                  child: MyTextButton(
                      buttonName: 'Acessar',
                      onTap: () {
                        Get.toNamed('/login');
                      },
                      bgColor: Colors.transparent,
                      textColor:
                          Get.isDarkMode ? Colors.white : Colors.black87),
                ),
              ],
            ),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }

  Widget _buildBullets() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _listSlide.map((i) {
          return InkWell(
            onTap: () {
              setState(() {
                _pageController.jumpToPage(i['id'] as int);
                _currentPage = i['id'] as int;
              });
            },
            child: Container(
              margin: EdgeInsets.all(10),
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: _currentPage == i['id'] ? Colors.white : Colors.grey,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
