class Category {
  final String label;

  Category({required this.label});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      label: json['label'],
    );
  }

  Map<String, dynamic> toJson() => {
        'label': label,
      };
}
