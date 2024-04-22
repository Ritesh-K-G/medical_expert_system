class Disease{
  final String name, hindiName, description, hindiDescription;
  Disease({
    required this.name,
    required this.description,
    required this.hindiDescription,
    required this.hindiName
  });

  factory Disease.fromJson(Map<String, dynamic> json) {
    return Disease(
      name: json['english_name'],
      description: json['english_description'],
        hindiDescription: json['hindi_description'],
        hindiName: json['hindi_name']
    );
  }
}