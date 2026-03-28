import 'package:eventie/widgets/button.dart';
import 'package:flutter/material.dart';


class LogOut extends StatefulWidget {
  const LogOut({super.key});

  @override
  State<LogOut> createState() => _LogOutState();
}

class _LogOutState extends State<LogOut> {

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;


    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(18.0),
          child: Column(
            children: [
              Text(
                'Log Out',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 20,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Divider(color: Colors.grey[400], thickness: 1, height: 20),
              SizedBox(height: 10),
              Text(
                'Are you sure you want to log out?',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: Button(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      color: primaryColor.withOpacity(0.15),
                      text: "Cancel",
                      textColor: primaryColor,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Button(
                      onPressed: () {},
                      text: "Yes, Logout",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
