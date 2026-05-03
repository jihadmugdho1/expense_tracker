import 'package:flutter/material.dart';
import 'package:petzy_optimized/core/common/global_widgets/common_button/common_button.dart';
import 'package:petzy_optimized/core/common/global_widgets/quick_button/quick_button.dart';
import 'package:petzy_optimized/core/common/styles/global_text_style.dart';
import 'package:petzy_optimized/core/utils/constants/colors.dart';

class FilterService extends StatefulWidget {
  final bool showStayType;
  final void Function(FilterResult)? onApply;

  const FilterService({
    super.key,
    this.showStayType = false,
    this.onApply,
  });

  static void show(
    BuildContext context, {
    bool showStayType = false,
    void Function(FilterResult)? onApply,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.background(context),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => FilterService(
        showStayType: showStayType,
        onApply: onApply,
      ),
    );
  }

  @override
  State<FilterService> createState() => _FilterServiceState();
}

class _FilterServiceState extends State<FilterService> {
  bool _onlyPet = false;
  bool _humanAndPet = false;
  RangeValues _priceRange = const RangeValues(0, 300);
  final Map<String, bool> _categories = {
    'Name Training': false,
    'Potty Training': false,
    'Leash': false,
    'Behavior': false,
    'Socialization': false,
    'Agility Training': false,
    'Guard Training': false,
    'Puppy Training': false,
  };
  String _selectedSort = 'Most Popular';
  Set<int> _ratings = {};

  static const _sortOptions = [
    'Most Popular',
    'Most Recent',
    'Top Selling',
    'Low to High',
    'High to Low',
  ];

  static const _categoryImages = {
    'Name Training': 'assets/icons/name.png',
    'Potty Training': 'assets/icons/potty.png',
    'Leash': 'assets/icons/leash.png',
    'Behavior': 'assets/icons/behavior.png',
    'Socialization': 'assets/icons/social.png',
    'Agility Training': 'assets/icons/agility.png',
    'Guard Training': 'assets/icons/guard.png',
    'Puppy Training': 'assets/icons/puppy.png',
  };

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.9,
      builder: (_, scrollController) {
        return Column(
          children: [
            const SizedBox(height: 10),

            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.darkBorder,
                borderRadius: BorderRadius.circular(4),
              ),
            ),

            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Text(
                    'Filter By',
                    style: AppTextStyle(context)
                        .semiBoldTextStyle(fontSize: AppTextStyle.xl),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.close,
                          color: AppColors.textSecondary(context)),
                    ),
                  ),
                ],
              ),
            ),

            const Divider(),

            Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    if (widget.showStayType) ...[
                      _label(context, 'Stay Type'),

                      ListTile(
                        title: const Text('Only Pet'),
                        trailing: _checkbox(_onlyPet),
                        onTap: () => setState(() => _onlyPet = !_onlyPet),
                      ),

                      ListTile(
                        title: const Text('Human And Pet'),
                        trailing: _checkbox(_humanAndPet),
                        onTap: () =>
                            setState(() => _humanAndPet = !_humanAndPet),
                      ),
                    ],

                    if (!widget.showStayType) ...[
                      _label(context, 'Categories'),

                      LayoutBuilder(
                        builder: (context, constraints) {
                          final itemWidth = constraints.maxWidth / 4;
                          return Column(
                            children: [
                              for (var i = 0; i < _categories.length; i += 4)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    for (final key in _categories.keys
                                        .toList()
                                        .sublist(i, (i + 4).clamp(0, _categories.length)))
                                      SizedBox(
                                        width: itemWidth,
                                        child: GestureDetector(
                                          onTap: () => setState(() =>
                                              _categories[key] = !(_categories[key] ?? false)),
                                          child: QuickButton(
                                            image: _categoryImages[key] ?? '',
                                            title: key,
                                            isSelected: _categories[key] ?? false,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                            ],
                          );
                        },
                      ),
                    ],

                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _label(context, 'Price'),
                        Text(
                          '\$${_priceRange.start.toInt()} - \$${_priceRange.end.toInt()}',
                        ),
                      ],
                    ),

                    RangeSlider(
                      values: _priceRange,
                      min: 0,
                      max: 300,
                      onChanged: (v) => setState(() => _priceRange = v),
                    ),

                    const SizedBox(height: 20),

                    if (!widget.showStayType) ...[
                      _label(context, 'Sort by'),

                      ..._sortOptions.map((e) => ListTile(
                            title: Text(e),
                            trailing: _radio(e == _selectedSort),
                            onTap: () => setState(() => _selectedSort = e),
                          )),
                    ],

                    const SizedBox(height: 20),

                    _label(context, 'Ratings'),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(5, (i) {
                        final star = 5 - i;
                        final selected = _ratings.contains(star);

                        return GestureDetector(
                          onTap: () => setState(() {
                            if (selected) {
                              _ratings.remove(star);
                            } else {
                              _ratings = {..._ratings, star};
                            }
                          }),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: selected
                                    ? AppColors.primary
                                    : AppColors.darkBorder,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.star,
                                    size: 16, color: AppColors.warning),
                                const SizedBox(width: 4),
                                Text('$star'),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: ProElevatedButton(
                text: 'Apply Filter',
                onPressed: () {
                  widget.onApply?.call(
                    FilterResult(
                      onlyPet: _onlyPet,
                      humanAndPet: _humanAndPet,
                      minPrice: _priceRange.start,
                      maxPrice: _priceRange.end,
                      categories: _categories,
                      sortBy: _selectedSort,
                      ratings: _ratings,
                    ),
                  );
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _label(BuildContext context, String text) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(
          text,
          style: AppTextStyle(context)
              .semiBoldTextStyle(fontSize: AppTextStyle.lg),
        ),
      );

  Widget _checkbox(bool checked) => Container(
        width: 22,
        height: 22,
        decoration: BoxDecoration(
          color: checked ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: AppColors.darkBorder),
        ),
      );

  Widget _radio(bool selected) => Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.darkBorder),
        ),
        child: selected
            ? const Center(
                child:
                    CircleAvatar(radius: 4, backgroundColor: AppColors.primary),
              )
            : null,
      );
}

class FilterResult {
  final bool onlyPet;
  final bool humanAndPet;
  final double minPrice;
  final double maxPrice;
  final Map<String, bool> categories;
  final String sortBy;
  final Set<int> ratings;

  FilterResult({
    required this.onlyPet,
    required this.humanAndPet,
    required this.minPrice,
    required this.maxPrice,
    required this.categories,
    required this.sortBy,
    required this.ratings,
  });
}
