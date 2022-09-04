
class CustomerReview {
  final String name;
  final String date;
  final String review;

  CustomerReview(
      {required this.name, required this.date, required this.review});

  factory CustomerReview.fromJson(Map<String, dynamic> json) => CustomerReview(
      name: json['name'], date: json['date'], review: json['review']);
}
