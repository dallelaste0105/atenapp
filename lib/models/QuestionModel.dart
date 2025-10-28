class QuestionModel {
  final int id;
  final String subject;
  final String text;
  final List<String> options;
  final String? correctAnswer;
  final String? imageUrl;

  QuestionModel({
    required this.id,
    required this.subject,
    required this.text,
    required this.options,
    this.correctAnswer,
    this.imageUrl,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'],
      subject: json['subject'],
      text: json['text'],
      options: List<String>.from(json['options']),
      correctAnswer: json['correct_answer'],
      imageUrl: json['image_url'],
    );
  }
}
