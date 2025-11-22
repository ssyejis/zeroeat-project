import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zeroeat/models.dart';
import 'package:zeroeat/config/routes.dart';

enum SortMode { relevance, reviews, rating }

class CategoryList extends StatefulWidget {
  const CategoryList({super.key, this.selectedCategory});

  final String? selectedCategory;

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList>
    with SingleTickerProviderStateMixin {
  List<String> categories = [
    '음료',
    '간식',
    '식사대용',
    '베이커리',
    '비건',
    '키토',
    '글루텐프리',
  ];
  final List<Product> topProducts = productDummyList;
  String query = "";
  SortMode _sort = SortMode.rating;

  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    int initialIndex = 0;
    if (widget.selectedCategory != null) {
      final idx = categories.indexOf(widget.selectedCategory!);
      if (idx != -1) initialIndex = idx;
    }
    _tabController = TabController(
      length: categories.length,
      vsync: this,
      initialIndex: initialIndex,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 검색어 필터링 (query 변수가 있다고 가정)
    final filtered = topProducts
        .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (_sort == SortMode.reviews) {
      filtered.sort((a, b) {
        final aCount =
            reviewDummyList.where((r) => r.productId == a.id).length;
        final bCount =
            reviewDummyList.where((r) => r.productId == b.id).length;
        return bCount.compareTo(aCount);
      });
    } else if (_sort == SortMode.rating) {
      filtered.sort((a, b) => b.rating.compareTo(a.rating));
    }

    final results = filtered;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDF6EC),
        elevation: 0,
        title: const Text(
          'ZERO:EAT',
          style: TextStyle(
            color: Color(0xFF3E2F1C),
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF3E2F1C)),
          onPressed: () => Navigator.pop(context),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: TabBar(
              isScrollable: true,
              controller: _tabController,
              padding: EdgeInsets.zero,
              labelPadding: const EdgeInsets.symmetric(horizontal: 12.0),
              indicatorPadding: EdgeInsets.zero,
              indicatorColor: Colors.green,
              labelColor: Colors.black,
              unselectedLabelColor: const Color.fromARGB(255, 90, 90, 90),
              tabs: categories.map((category) => Tab(text: category)).toList(),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: categories.map((category) {
                if (category == '음료') {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              value: _sort,
                              items: const [
                                DropdownMenuItem(
                                  value: SortMode.reviews,
                                  child: Text('리뷰 많은순'),
                                ),
                                DropdownMenuItem(
                                  value: SortMode.rating,
                                  child: Text('별점 높은순'),
                                ),
                              ],
                              onChanged: (val) {
                                if (val is SortMode) {
                                  setState(() => _sort = val);
                                }
                              },
                              icon: const Icon(Icons.tune, size: 14),
                              style: const TextStyle(fontSize: 12),
                              alignment: Alignment.centerRight,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: results.isEmpty
                            ? const Center(child: Text("검색 결과가 없습니다."))
                            : Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 8, 16, 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: ListView.separated(
                                        itemCount: results.length,
                                        separatorBuilder: (_, __) =>
                                            const Divider(height: 1),
                                        itemBuilder: (ctx, i) {
                                          final p = results[i];
                                          final reviewCount = reviewDummyList
                                              .where(
                                                  (r) => r.productId == p.id)
                                              .length;

                                          return ListTile(
                                            leading: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: kIsWeb
                                                  ? Image.network(
                                                      p.imageUrl,
                                                      width: 60,
                                                      height: 60,
                                                      fit: BoxFit.contain,
                                                    )
                                                  : Image.file(
                                                      File(p.imageUrl),
                                                      width: 60,
                                                      height: 60,
                                                      fit: BoxFit.contain,
                                                    ),
                                            ),
                                            title: Text(p.name),
                                            subtitle: Wrap(
                                              spacing: 6,
                                              children: p.tags
                                                  .map((t) => Text(
                                                        '#$t',
                                                        style: const TextStyle(
                                                            fontSize: 12,
                                                            color:
                                                                Colors.blue),
                                                      ))
                                                  .toList(),
                                            ),
                                            trailing: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Icon(Icons.star,
                                                    color: Colors.orange),
                                                Text(p.rating.toString()),
                                                Text(' ($reviewCount)'),
                                              ],
                                            ),
                                            onTap: () {
                                              Navigator.of(context).pushNamed(
                                                  '${ZeroEatRoutes.productDetail}?id=${p.id}');
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: Text(
                      '$category 카테고리 페이지 준비중',
                      style: const TextStyle(fontSize: 24),
                    ),
                  );
                }
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}