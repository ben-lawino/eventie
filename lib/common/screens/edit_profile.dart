import 'package:eventie/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import '../../widgets/profile_field.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Edit Profile',
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage(
                    'assets/images/profilepic.png',
                  ),
                ),

                //Edit Button
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                      child: const Icon(
                        Icons.edit,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            //Fields
            const ProfileField(text: "Ben lawin"),
            const SizedBox(height: 15),

            const ProfileField(text: "Ben"),
            const SizedBox(height: 15),

            const ProfileField(
              text: "6/27/1960",
              suffixIcon: Icons.calendar_today,
            ),
            const SizedBox(height: 15),

            const ProfileField(
              text: "Male",
              suffixIcon: Icons.keyboard_arrow_down,
            ),
            const SizedBox(height: 15),

            const ProfileField(
              text: "lawinwes@gmail.com",
              suffixIcon: Icons.email_outlined,
            ),
            const SizedBox(height: 15),

            const ProfileField(
              text: "+254 700628088",
              prefixWidget: Text("ke "),
            ),
            const SizedBox(height: 15),

            const ProfileField(
              text: "Kenya",
              suffixIcon: Icons.keyboard_arrow_down,
            ),
          ]
        ),
      ),
    );
  }
}
