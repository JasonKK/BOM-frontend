class Mock {
  int? grade;
  String? subject;
  String? questionImage;
  String? answer;
  String? explanation;
  bool? provisionCheck;
  int? totalNumSolved;
  int? correctNum;
  int? provider;

  Mock({
    this.grade,
    this.subject,
    this.questionImage,
    this.answer,
    this.explanation,
    this.provisionCheck,
    this.totalNumSolved,
    this.correctNum,
    this.provider,
  });

  Mock.fromJson(Map<String, dynamic> json) {
    grade = json['grade'];
    subject = json['subject'];
    questionImage = json['questionImage'];
    answer = json['answwer'];
    explanation = json['explanation'];
    provisionCheck = json['provisionCheck'];
    totalNumSolved = json['totalNumSolved'];
    correctNum = json['correctNum'];
    provider = json['provider'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['grade'] = this.grade;
    data['subject'] = this.subject;
    data['questionImage'] = this.questionImage;
    data['answer'] = this.answer;
    data['explanation'] = this.explanation;
    data['provisionCheck'] = this.provisionCheck;
    data['totalNumSolved'] = this.totalNumSolved;
    data['correctNum'] = this.correctNum;
    data['provider'] = this.provider;
    return data;
  }
}
