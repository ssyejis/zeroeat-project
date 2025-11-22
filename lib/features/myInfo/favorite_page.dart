import 'package:flutter/material.dart';
import 'package:zeroeat/config/theme.dart';
import 'package:zeroeat/config/routes.dart';

class FavoriteProduct {
  final String id;
  final String name;
  final String imageUrl;
  bool isFavorite;

  FavoriteProduct({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.isFavorite = true,
  });
}

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  // 👇 임시 상품 4개
  List<FavoriteProduct> favoriteProducts = [
    FavoriteProduct(
      id: 'prod_001',
      name: "제로 콜라 라임",
      imageUrl: "assets/images/zeroCola.png",
    ),
    FavoriteProduct(
      id: 'prod_003',
      name: "파인트 생우유",
      imageUrl: "assets/images/pintMilk.png",
    ),
    FavoriteProduct(
      id: 'prod_004',
      name: "에이스저당 검은콩 두유",
      imageUrl: "assets/images/soyMilk.png",
    ),
    FavoriteProduct(
      id: 'prod_006',
      name: "프로틴 그래놀라",
      imageUrl: 'assets/images/granola.png',
    ),
  ];

  void _toggleFavorite(FavoriteProduct product) {
    setState(() {
      favoriteProducts.remove(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDF6EC),
        elevation: 0,
        title: const Text(
          '찜목록',
          style: TextStyle(
            color: Color(0xFF3E2F1C),
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF3E2F1C)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: favoriteProducts.isEmpty
          ? const Center(child: Text("찜한 상품이 없습니다."))
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 155,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.95,
                ),
                itemCount: favoriteProducts.length,
                itemBuilder: (context, index) {
                  final product = favoriteProducts[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        '${ZeroEatRoutes.productDetail}?id=${product.id}',
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: zeroEatTheme.colorScheme.secondary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                product.imageUrl,
                                width: 100,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    product.name,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.favorite,
                                    size: 20,
                                    color: Color.fromARGB(255, 255, 66, 66)
                                  ),
                                  onPressed: () => _toggleFavorite(product),
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
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