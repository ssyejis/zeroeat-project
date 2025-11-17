import 'package:flutter/material.dart';
import 'package:zeroeat/models.dart';
import 'package:zeroeat/config/routes.dart';

enum SortMode { relevance, reviews, rating }

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Product> topProducts = productDummyList;
  
  String query = "";
  SortMode _sort = SortMode.relevance;

  @override
  Widget build(BuildContext context) {
    // filter
    final filtered = topProducts
      .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
      .toList();

    // sort according to selected mode
    if (_sort == SortMode.reviews) {
      filtered.sort((a, b) {
        final aCount = reviewDummyList.where((r) => r.productId == a.id).length;
        final bCount = reviewDummyList.where((r) => r.productId == b.id).length;
        return bCount.compareTo(aCount);
      });
    } else if (_sort == SortMode.rating) {
      filtered.sort((a, b) => b.rating.compareTo(a.rating));
    }

    final results = filtered;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: "제로 음료 검색",
            prefixIcon: const Icon(Icons.search),
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _controller.clear();
                setState(() => query = "");
              },
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
          onChanged: (val) => setState(() => query = val),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Align(
              alignment: Alignment.topRight,
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  value: _sort,
                  items: [
                    DropdownMenuItem(
                      value: SortMode.relevance,
                      child: Text('정확도'),
                    ),
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
                  icon: const Icon(Icons.tune, size: 14,),
                  style: const TextStyle(fontSize: 12),
                  alignment: Alignment.centerRight,
                ),
              
              ),
            ),
          ),
          Expanded(
            child: results.isEmpty
                ? const Center(child: Text("검색 결과가 없습니다."))
                :
                Padding(
                        padding: EdgeInsets.fromLTRB(16, 8 , 16, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('현재 많이 검색된 식품', style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),),
                      const SizedBox(height: 4),
                      Expanded(
                        child: ListView.separated(
                          itemCount: results.length,
                          separatorBuilder: (_, __) => const Divider(height: 1),
                          itemBuilder: (ctx, i) {
                            final p = results[i];
                            return ListTile(
                              leading: const Icon(Icons.local_drink, color: Colors.green),
                              title: Text(p.name),
                              subtitle: Wrap(
                                spacing: 6,
                                children: p.tags
                                    .map((t) => Text('#$t',
                                        style: const TextStyle(
                                            fontSize: 12, color: Colors.blue)))
                                    .toList(),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.star, color: Colors.orange),
                                  Text(p.rating.toString()),
                                  Text(' (${reviewDummyList.where((r) => r.productId == p.id).length})'),
                                ],
                              ),
                              onTap: () {
                                Navigator.of(context).pushNamed('${ZeroEatRoutes.productDetail}?id=${p.id}');
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
          ),
        ],
      ),
    );
  }
}
