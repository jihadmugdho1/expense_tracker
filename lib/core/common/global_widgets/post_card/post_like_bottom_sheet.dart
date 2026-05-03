import 'package:flutter/material.dart';

class LikesBottomSheet extends StatelessWidget {
  final int likes;

  const LikesBottomSheet({super.key, required this.likes});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Column(
        children: [
          const SizedBox(height: 10),
          Container(
            height: 5,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 20),
          const Text("Likes"),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: likes,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("User $index"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}