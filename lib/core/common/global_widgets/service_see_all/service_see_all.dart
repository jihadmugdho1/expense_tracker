import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:petzy_optimized/core/common/global_widgets/appbar/header.dart';
import 'package:petzy_optimized/core/common/global_widgets/filter_service/filter_service.dart';
import 'package:petzy_optimized/core/common/global_widgets/searchbar/searchbar.dart';
import 'package:petzy_optimized/core/common/global_widgets/service_card/global_servicecard.dart';
import 'package:petzy_optimized/core/common/styles/global_text_style.dart';
import 'package:petzy_optimized/core/utils/constants/colors.dart';

class ServiceSeeAll extends StatefulWidget {
  final String serviceType;
  final bool isHotel;

  const ServiceSeeAll({
    super.key,
    this.serviceType = '',
    this.isHotel = false,
  });

  @override
  State<ServiceSeeAll> createState() => _ServiceSeeAllState();
}

class _ServiceSeeAllState extends State<ServiceSeeAll> {
  final TextEditingController _searchController = TextEditingController();
  RangeValues _priceRange = const RangeValues(0, 300);

  static const _demoItems = [
    {
      'imageUrl':
          'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=400',
      'rating': 4.9,
      'title': 'Eliinate Galian Hotel',
      'location': 'Chestnut Street Rome, NY',
      'price': 248.0,
      'beds': 3,
      'baths': 2,
      'pets': 1,
    },
    {
      'imageUrl':
          'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?w=400',
      'rating': 4.9,
      'title': 'Eliinate Galian Hotel',
      'location': 'Chestnut Street Rome, NY',
      'price': 248.0,
      'beds': 3,
      'baths': 2,
      'pets': 1,
    },
  ];

  List<Map<String, dynamic>> get _filtered {
    final query = _searchController.text.trim().toLowerCase();
    return _demoItems.where((e) {
      final matchSearch = query.isEmpty ||
          (e['title'] as String).toLowerCase().contains(query) ||
          (e['location'] as String).toLowerCase().contains(query);
      final matchPrice = (e['price'] as double) >= _priceRange.start &&
          (e['price'] as double) <= _priceRange.end;
      return matchSearch && matchPrice;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProAppBar(
        title: widget.serviceType,
        onBackPressed: () => Get.back(),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant(context),
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              icon: Icon(
                LucideIcons.layoutGrid,
                size: 20,
                color: AppColors.textPrimary(context),
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: Row(
              children: [
                Expanded(
                  child: ProSearchBar(
                    controller: _searchController,
                    hintText: 'Search',
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                const SizedBox(width: 10),

                GestureDetector(
                  onTap: () => FilterService.show(
                    context,
                    showStayType: widget.isHotel,
                    onApply: (result) => setState(
                      () => _priceRange =
                          RangeValues(result.minPrice, result.maxPrice),
                    ),
                  ),
                  child: Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceVariant(context),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      LucideIcons.slidersHorizontal,
                      size: 20,
                      color: AppColors.textPrimary(context),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: _filtered.isEmpty
                ? Center(
                    child: Text(
                      'No results found',
                      style: AppTextStyle(context).regularTextStyle(
                        color: AppColors.textSecondary(context),
                      ),
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.72,
                    ),
                    itemCount: _filtered.length,
                    itemBuilder: (context, index) {
                      final item = _filtered[index];
                      return ServiceCard(
                        imageUrl: item['imageUrl'] as String,
                        rating: item['rating'] as double,
                        title: item['title'] as String,
                        location: item['location'] as String,
                        price: item['price'] as double,
                        beds: item['beds'] as int?,
                        baths: item['baths'] as int?,
                        pets: item['pets'] as int?,
                        onTap: () {},
                        onFavorite: () {},
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
