import 'package:eventie/widgets/button.dart';
import 'package:flutter/material.dart';

class CancelReason extends StatefulWidget {
  const CancelReason({super.key});

  @override
  State<CancelReason> createState() => _CancelReasonState();
}

class _CancelReasonState extends State<CancelReason> {
  final List<String> reasons = [
    "Scheduling conflict with another event",
    "I am unwell and unable to attend",
    "An urgent matter has arisen",
    "I am unable to arrange transportation",
    "I have no one to attend with",
    "I intend to attend a different event",
    "I no longer wish to attend",
    "Others",
  ];

  String? selectedReason;
  final TextEditingController otherReasonController = TextEditingController();

  @override
  void dispose() {
    otherReasonController.dispose();
    super.dispose();
  }

  void _onSubmitCancellation() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(36),
          ),
          contentPadding: EdgeInsets.only(
            top: 30,
            left: 40,
            right: 40,
            bottom: 25,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 140,
                    width: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.check_rounded,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),

              // Success title
              Text(
                'Successful!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              SizedBox(height: 12),

              // Success message
              Text(
                'You have successfully cancelled the event! 90% of the funds will be returned to you.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  height: 1.4,
                ),
              ),

              SizedBox(height: 24),

              Button(
                width: double.infinity,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  text: 'ok'),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: BackButton(),
        title: Text(
          'Cancel Booking',
          style: Theme.of(
            context,
          ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Please select reason for cancellation:",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Divider(color: Colors.grey[400], thickness: 1, height: 20),
          ),
          SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: reasons.length,
              itemBuilder: (context, index) {
                final reason = reasons[index];
                return RadioListTile<String>(
                  fillColor: WidgetStateProperty.resolveWith<Color?>((states) {
                    if (states.contains(WidgetState.selected)) {
                      return Theme.of(context).colorScheme.primary;
                    }
                    if (states.contains(WidgetState.disabled)) {
                      return Theme.of(context).colorScheme.primary;
                    }
                    return Theme.of(context).colorScheme.primary;
                    ;
                  }),
                  selectedTileColor: Colors.blue[50],
                  // Background when selected
                  title: Text(
                    reason,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  value: reason,
                  groupValue: selectedReason,
                  onChanged: (value) {
                    setState(() {
                      selectedReason = value;
                      if (value != "Others") {
                        otherReasonController.clear();
                      }
                    });
                  },
                );
              },
            ),
          ),
          if (selectedReason == "Others")
            Padding(
              padding: const EdgeInsets.only(bottom: 100, left: 18, right: 18),
              child: TextField(
                controller: otherReasonController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: "Other reason...",
                  hintStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Colors.grey[500],
                    fontSize: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.primaryContainer,
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(bottom: 18, left: 18, right: 18),
            child: Button(
              onPressed: _onSubmitCancellation,
              width: double.infinity,
              text: 'Cancel Booking',
            ),
          ),
        ],
      ),
    );
  }
}
