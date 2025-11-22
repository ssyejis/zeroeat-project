import 'package:flutter/material.dart';

class FavoriteProduct  {
  final int id;
  final String name;
  final String imageUrl;
  bool isFavorite;

  FavoriteProduct ({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.isFavorite = true, // 기본값: 찜 상태
  });
}

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  // 👇 임시 상품 4개
  List<FavoriteProduct > favoriteProducts = [
    FavoriteProduct (
      id: 1,
      name: "제로 콜라 라임",
      imageUrl: "assets/images/zeroCola.png",
    ),
    FavoriteProduct (
      id: 2,
      name: "파인트 생우유",
      imageUrl: "assets/images/pintMilk.png",
    ),
    FavoriteProduct (
      id: 3,
      name: "에이스저당 검은콩 두유",
      imageUrl: "assets/images/soyMilk.png",
    ),
    FavoriteProduct (
      id: 4,
      name: "프로틴 그래놀라",
      imageUrl: 'assets/images/granola.png',
    ),
  ];

  void _toggleFavorite(FavoriteProduct  product) {
    setState(() {
      favoriteProducts.remove(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("찜목록")),
      body: favoriteProducts.isEmpty
          ? const Center(child: Text("찜한 상품이 없습니다."))
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.6,
                ),
                itemCount: favoriteProducts.length,
                itemBuilder: (context, index) {
                  final product = favoriteProducts[index];
                  return GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("${product.name} 페이지로 이동")),
                      );
                    },
                    child: Column(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              product.imageUrl,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          product.name,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        IconButton(
                          icon: const Icon(Icons.favorite, color: Colors.red),
                          onPressed: () => _toggleFavorite(product),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }
}
