import 'package:flutter_riverpod/legacy.dart';
import '../../data/models/booking_model.dart';

class BookingNotifier extends StateNotifier<List<BookingModel>> {
  BookingNotifier() : super([]);

  // Add booking
  void addBooking(BookingModel booking) {
    state = [...state, booking];
  }

  // Update booking (for payment success/failure)
  void updateBooking(String bookingId, BookingModel updatedBooking) {
    state = state.map((booking) {
      return booking.id == bookingId ? updatedBooking : booking;
    }).toList();
  }

  // Get booking by ID
  BookingModel? getBookingById(String id) {
    try {
      return state.firstWhere((booking) => booking.id == id);
    } catch (e) {
      return null;
    }
  }

  //cancel booking
  void cancelBooking(String bookingId, String reason) {
    state = state.map((booking) {
      if (booking.id == bookingId) {

        // prevent double cancel
        if (booking.status == 'cancelled') return booking;

        return booking.copyWith(
          status: 'cancelled',
          cancellationReason: reason,
          cancelledAt: DateTime.now(),
        );
      }
      return booking;
    }).toList();
  }

  // Get all bookings for a user (optional for later)
  List<BookingModel> getUserBookings(String userId) {
    return state.where((b) => b.userId == userId).toList();
  }
}


// provider
final bookingProvider =
StateNotifierProvider<BookingNotifier, List<BookingModel>>(
      (ref) => BookingNotifier(),
);