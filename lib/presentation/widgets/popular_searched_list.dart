import 'package:flutter/material.dart';

import '../search/demo_data.dart';
import '../styles/app_colors.dart';

class PopularSearchedList extends StatelessWidget {
  const PopularSearchedList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.05,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
        scrollDirection: Axis.horizontal,
        children: popularSearched
            .map((text) => GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            offset: const Offset(0.0, 1),
                            blurRadius: 3.0),
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            offset: const Offset(1, 0.0),
                            blurRadius: 3.0),
                      ],
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Center(
                      child: Text(text,
                          style: const TextStyle(color: AppColors.grey)),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
