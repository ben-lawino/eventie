import 'package:eventie/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

import '../../bottom_nav.dart';

class CreateEventScreen extends StatelessWidget {
  const CreateEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => BottomNav()),
            );
          },
          icon: Icon(Icons.arrow_back_rounded),
          color: Colors.grey[700],
        ),
        title: Text(
          'Create Event',
          style: Theme.of(
            context,
          ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: [SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                CustomTextField(label: 'Title'),
                SizedBox(height: 12),
                CustomTextField(label: 'Date'),
                SizedBox(height: 12),
                CustomTextField(label: 'Time'),
                SizedBox(height: 12),
                CustomTextField(label: 'Location'),
                SizedBox(height: 12),
                CustomTextField(label: 'Category'),
                SizedBox(height: 12),
                CustomTextField(label: 'Description'),
                SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(14),
                  width: double.infinity,
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: Offset(0, 10),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //regular ticket
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        height: 40,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: primaryColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 20,
                              offset: Offset(0, 10),
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Regular',
                              style: Theme.of(
                                context,
                              ).textTheme.labelMedium,
                            ),
                            Text(
                              'ksh.500',
                              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),

                      //vip ticket
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        height: 40,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: primaryColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 20,
                              offset: Offset(0, 10),
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'VIP',
                              style: Theme.of(
                                context,
                              ).textTheme.labelMedium,
                            ),
                            Text(
                              'ksh.1500',
                              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),

                      //vvip ticket
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        height: 40,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: primaryColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 20,
                              offset: Offset(0, 10),
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'VVIP',
                              style: Theme.of(
                                context,
                              ).textTheme.labelMedium,
                            ),
                            Text(
                              'ksh.2000',
                              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),]
      ),
    );
  }
}