import 'package:flutter/material.dart';
import 'package:petzy_optimized/core/common/global_widgets/service_card/global_servicecard.dart';

class SpecialServices extends StatelessWidget {
  final List<Map<String, dynamic>> services;
  final VoidCallback? onSeeAll;

  const SpecialServices({
    super.key,
    required this.services,
    this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 🔹 Header
        Padding(
          padding:  const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            
            children: [
              const Text(
                "Special Services",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              GestureDetector(
                onTap: onSeeAll,
                child: const Text(
                  "See All",
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        SizedBox(
          height: (.40 * MediaQuery.of(context).size.width) + 96,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: services.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final service = services[index];

              return ServiceCard(
                imageUrl: service['imageUrl'],
                rating: (service['rating'] as num?)?.toDouble() ?? 4.5,
                title: service['title'],
                location: service['location'],
                price: (service['price'] as num).toDouble(),
                onTap: service['onTap'],
              );
            },
          ),
        ),
      ],
    );
  }
}