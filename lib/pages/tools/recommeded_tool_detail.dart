import 'package:flutter/material.dart';

class RecommendedToolDetail extends StatelessWidget {
  const RecommendedToolDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                "assets/image/tool1.jpg",
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }
}
