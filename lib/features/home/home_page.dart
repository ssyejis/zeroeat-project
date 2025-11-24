import 'dart:async';

import 'package:flutter/material.dart';

import 'package:zeroeat/config/routes.dart';
import 'package:zeroeat/models.dart';

import 'package:zeroeat/config/theme.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final PageController _pageController = PageController(initialPage: 1000);
  Timer? timer;

  final List<Product> topProducts = productDummyList;

  List<Widget> banners = [
    _HomeBanner(bannerUrl: 'assets/images/banner1.png'),
    _HomeBanner(bannerUrl: 'assets/images/banner2.png'),
  ];


  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(seconds: 3), (_) {
      _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    if (timer != null) {
      timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFDF6EC),
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            const Text(
              'ZERO:EAT',
              style: TextStyle(
                color: Color(0xFF3E2F1C),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.of(context).pushNamed(ZeroEatRoutes.search);
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AspectRatio(
            aspectRatio: 1536/1024,
            child: PageView.builder(
              controller: _pageController,
              itemBuilder: (context, index) {
                final child = banners[index % banners.length];
                    return GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                        timer?.cancel();
                        timer = Timer.periodic(const Duration(seconds: 3), (_) {
                          _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                        });
                      },
                      child: child,
                    );
              },
            ),
          ),
          const SizedBox(height: 16),

          // 카테고리 버튼
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child:
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _CategoryButton(label: '음료', icon: Icons.local_drink, onTap: () {
                  Navigator.of(context).pushNamed(ZeroEatRoutes.category, arguments: '음료');
                }),
                const SizedBox(width: 30),
                _CategoryButton(label: '간식', icon: Icons.cookie, onTap: () {
                  Navigator.of(context).pushNamed(ZeroEatRoutes.category, arguments: '간식');
                }),
                const SizedBox(width: 30),
                _CategoryButton(label: '식사대용', icon: Icons.rice_bowl, onTap: () {
                  Navigator.of(context).pushNamed(ZeroEatRoutes.category, arguments: '식사대용');
                }),
                const SizedBox(width: 30),
                _CategoryButton(label: '베이커리', icon: Icons.bakery_dining, onTap: () {
                  Navigator.of(context).pushNamed(ZeroEatRoutes.category, arguments: '베이커리');
                }),
                const SizedBox(width: 30),
                _CategoryButton(label: '비건', icon: Icons.eco, onTap: () {
                  Navigator.of(context).pushNamed(ZeroEatRoutes.category, arguments: '비건');
                }),
                const SizedBox(width: 30),
                _CategoryButton(label: '키토', icon: Icons.kitchen, onTap: () {
                  Navigator.of(context).pushNamed(ZeroEatRoutes.category, arguments: '키토');
                }),
                const SizedBox(width: 30),
                _CategoryButton(label: '글루텐프리', icon: Icons.eco, onTap: () {
                  Navigator.of(context).pushNamed(ZeroEatRoutes.category, arguments: '글루텐프리');
                }),
              ],
            ),
          ),
          const SizedBox(height: 16),

          const Text('🔥 핫한 제로식품',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),

          SizedBox(
            height: 200,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: topProducts.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (ctx, i) {
                final product = topProducts[i];
                return _FoodRankButton(
                  product: product,
                    onTap: () {
                    Navigator.of(context).pushNamed(
                      '${ZeroEatRoutes.productDetail}?id=${product.id}',
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 0) {
            Navigator.of(context).pushNamed(ZeroEatRoutes.home);
          } else if (index == 1) {
            Navigator.of(context).pushNamed(ZeroEatRoutes.search);
          } else if (index == 2) {
            Navigator.of(context).pushNamed(ZeroEatRoutes.favorite);
          } else if (index == 3) {
            Navigator.of(context).pushNamed(ZeroEatRoutes.myPage);
          }

        },
        selectedItemColor: Colors.grey,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: '검색'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: '찜목록'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '마이페이지'),
        ],
      ),

    );
  }
}

class _CategoryButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onTap;

  const _CategoryButton({required this.label, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: zeroEatTheme.colorScheme.secondary,
            child: Icon(icon, color: zeroEatTheme.colorScheme.primary),
          ),
          const SizedBox(height: 6),
          Text(label),
        ],
      ),
    );
  }
}

class _FoodRankButton extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const _FoodRankButton({required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140,
        decoration: BoxDecoration(
          color: zeroEatTheme.colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                product.imageUrl,
                height: 100,
                width: 100,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.local_cafe,
                  size: 60,
                  color: zeroEatTheme.colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              product.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
              maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              '⭐ ${product.rating.toStringAsFixed(1)}',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeBanner extends StatelessWidget {
  final String bannerUrl;

  const _HomeBanner({required this.bannerUrl});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        bannerUrl,
        width: double.infinity,
        fit: BoxFit.fitWidth,
        errorBuilder: (context, error, stackTrace) => Icon(
          Icons.local_cafe,
          size: 60,
          color: zeroEatTheme.colorScheme.primary,
        ),
      ),
    );
  }
}