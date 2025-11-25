import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        if (index == 0) {
          Navigator.of(context).pushNamed('/');
        } else if (index == 1) {
          Navigator.of(context).pushNamed('/search');
        } else if (index == 2) {
          Navigator.of(context).pushNamed('/favorite');
        } else if (index == 3) {
          Navigator.of(context).pushNamed('/myPage');
        }
      },
      selectedItemColor: Colors.grey,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: '검색'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: '찜목록'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: '마이페이지'),
      ]
    );
  }
}