enum TextSizes { small, medium, large }

enum OrderStatus { processing, shipped, delivered }

enum PaymentMethods {
  paypal,
  googlePay,
  applePay,
  visa,
  masterCard,
  creditCard,
  paystack,
  razorPay,
  paytm,
}

enum AppDeviceType { small, medium, large, tablet }

enum PickerType { photo, video, both }

enum FriendCardType {
  friend,       // Message + Unfriend
  request,      // Accept + Reject
  sentRequest,  // Requested (disabled) + Cancel
}

enum BookingStatus { pending, confirmed, ongoing, completed, cancelled, disputed }

enum HealthRecordType { vaccination, prescription, surgery, checkup, dental, diagnosis, other }

enum NotificationType { booking, message, like, comment, follow, community, system }

enum PetSpecies { dog, cat, bird, rabbit, hamster, reptile, other }

enum ServiceCategory { hotel, market, care, school, grooming, training }

enum PostType { photo, video, story, reel, poll }

enum MediaType { image, video, document, audio }

enum UserRole { user, serviceProvider, admin, guest }

enum MessageType { text, image, video, document }
