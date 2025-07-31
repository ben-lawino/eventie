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
                      return Theme.of(context).colorScheme.primary;;
                    }),
                    selectedTileColor: Colors.blue[50],   // Background when selected
                    title: Text(reason,style: Theme.of(context).textTheme.titleMedium,),
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
                    hintStyle: Theme.of(context).textTheme.labelMedium!
                        .copyWith(
                      color: Colors.grey[500],
                      fontSize: 16,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none
                    ),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.primaryContainer,
                  ),
                ),
              ),
           Padding(
             padding: const EdgeInsets.only(
               bottom: 18,
               left: 18,
               right: 18,
             ),
             child: Button(
                 onPressed: (){},
                 width: double.infinity,
                 text: 'Cancel Booking'),
           ),
          ],
        ),
    );
  }
}
