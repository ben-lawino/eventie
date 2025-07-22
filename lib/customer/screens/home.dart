import 'package:eventie/common/constants/colors.dart';
import 'package:eventie/widgets/filter_button.dart';
import 'package:flutter/material.dart';
import '../../data/dummy_data.dart';
import '../../data/models/category_model.dart';
import '../../widgets/featured_list.dart';

class HomePage extends StatelessWidget {
  final List<CategoryModel> categories;

  const HomePage({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    int selectedIndex = 0;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                children: [
                  Column(
                    children: [

                      /// Top Row with Avatar, Greeting, and Notification
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundImage: AssetImage(
                              'assets/images/hacker.png',
                            ),
                          ),
                          SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Good Morning',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(color: Colors.grey),
                              ),
                              Text(
                                'Ben lawin',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Spacer(),
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Center(
                              child: IconButton(
                                onPressed: () {},
                                icon: Image.asset(
                                  'assets/icons/notification.png',
                                  scale: 2.5,
                                  color: Theme
                                      .of(
                                    context,
                                  )
                                      .colorScheme
                                      .onSurface,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 18),

                      /// Search Bar
                      TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xffeeeeee),
                          hintText: 'What events are looking for',
                          hintStyle: Theme
                              .of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(color: Colors.grey[500], fontSize: 14),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey[500],
                            size: 20,
                          ),
                          suffixIcon: Icon(
                            Icons.filter_list_outlined,
                            color: Colors.grey[500],
                            size: 20,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          // Add some padding
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                      SizedBox(height: 18),

                      /// Featured Events
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Featured',
                            style: Theme
                                .of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'See all',
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                    ],
                  ),
                ],
              ),
            ),
            EventsList(dummyEvents: dummyEvents),
            SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Popular Events',
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'See all',
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            FilterButton(label: 'Hello', icon: Icons.headphones)
          ],
        ),
      ),
    );
  }
}
