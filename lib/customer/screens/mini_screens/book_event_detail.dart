import 'package:eventie/customer/screens/mini_screens/payment_method.dart';
import 'package:eventie/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/booking_model.dart';
import '../../../data/models/event_model.dart';
import '../../../data/models/ticket_model.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../providers/booking_provider.dart';

class BookEventDetail extends ConsumerStatefulWidget {
  final EventModel event;
  final TicketModel ticket;
  final int quantity;
  final double total;
  const BookEventDetail({
    super.key,
    required this.event,
    required this.ticket,
    required this.quantity,
    required this.total,
  });

  @override
  ConsumerState<BookEventDetail> createState() => _BookEventScreenState();
}

class _BookEventScreenState extends ConsumerState<BookEventDetail> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  String _selectedGender = 'Male';
  bool _acceptTerms = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final isKeyboardOpen = bottomInset > 0;

    return Scaffold(
      resizeToAvoidBottomInset: true, //  scaffold shrinks with keyboard
      appBar: CustomAppBar(
        title: 'Book Event',
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Scrollable fields section
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(18, 18, 18, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Contact Information',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Full Name
                    _buildTextField(
                      controller: _fullNameController,
                      hintText: 'Full Name',
                    ),
                    const SizedBox(height: 24),

                    // Gender Dropdown
                    _buildDropdownField(
                      value: _selectedGender,
                      items: ['Male', 'Female'],
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 24),

                    // Email
                    _buildTextField(
                      controller: _emailController,
                      hintText: 'Email',
                      suffixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 24),

                    // Phone
                    _buildPhoneField(),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),

            // Pinned bottom section (terms + button)
            Padding(
              padding: EdgeInsets.fromLTRB(18, 0, 18, isKeyboardOpen ? 12 : 40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Terms and Conditions
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: _acceptTerms,
                        onChanged: (value) {
                          setState(() {
                            _acceptTerms = value!;
                          });
                        },
                        activeColor: const Color(0xFF5B52D5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: RichText(
                            text: TextSpan(
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                fontSize: 13,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                const TextSpan(text: 'I accept the Eventie '),
                                TextSpan(
                                  text: 'Terms of Service',
                                  style: TextStyle(
                                    color:
                                    Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const TextSpan(text: ', '),
                                TextSpan(
                                  text: 'Community Guidelines',
                                  style: TextStyle(
                                    color:
                                    Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const TextSpan(text: ', and '),
                                TextSpan(
                                  text: 'Privacy Policy',
                                  style: TextStyle(
                                    color:
                                    Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(
                                  text: ' (Required)',
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Continue Button
                  Button(
                    onPressed: () {
                      // Validation
                      if (_fullNameController.text.isEmpty ||
                          _emailController.text.isEmpty ||
                          _phoneController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                              Text("Please fill all required fields")),
                        );
                        return;
                      }

                      if (!_acceptTerms) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Please accept terms")),
                        );
                        return;
                      }

                      // Create booking
                      final booking = BookingModel(
                        id: DateTime.now().toString(),
                        fullName: _fullNameController.text,
                        phone: _phoneController.text,
                        email: _emailController.text,
                        userId: "user123",
                        eventId: widget.event.id,
                        ticketId: widget.ticket.id,
                        quantity: widget.quantity,
                        totalPrice: widget.total,
                        bookedAt: DateTime.now(),
                        status: "pending",
                      );

                      // Save to provider
                      ref.read(bookingProvider.notifier).addBooking(booking);

                      // Go to payment
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentMethodScreen(
                            booking: booking,
                            amount: widget.total,
                            phone: _phoneController.text,
                          ),
                        ),
                      );
                    },
                    text: 'Continue',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    IconData? suffixIcon,
    bool readOnly = false,
    VoidCallback? onTap,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      keyboardType: keyboardType,
      onTapOutside: (_) => FocusScope.of(context).unfocus(), // added globally
      style: const TextStyle(fontSize: 15, color: Colors.black87),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 15, color: Colors.grey[600]),
        filled: true,
        fillColor: Theme.of(context).primaryColor.withOpacity(0.15),
        suffixIcon: suffixIcon != null
            ? Icon(suffixIcon, color: Colors.grey[600], size: 20)
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          borderRadius: BorderRadius.circular(14),
          dropdownColor: Theme.of(context).primaryColor,
          value: value,
          isExpanded: true,
          icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey[600]),
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontSize: 15,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          onChanged: onChanged,
          items: items.map<DropdownMenuItem<String>>((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color:
                  Theme.of(context).colorScheme.onPrimaryContainer,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildPhoneField() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.15),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Image.asset('assets/icons/kenya.png', width: 20, height: 20),
                  const SizedBox(width: 4),
                  Icon(Icons.arrow_drop_down, color: Colors.grey[600]),
                ],
              ),
            ),
            Expanded(
              child: TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                onTapOutside: (_) => FocusScope.of(context).unfocus(),
                style: const TextStyle(fontSize: 15, color: Colors.black87),
                decoration: InputDecoration(
                  hintText: 'Phone Number',
                  hintStyle: TextStyle(fontSize: 15, color: Colors.grey[600]),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 0,
                    vertical: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}