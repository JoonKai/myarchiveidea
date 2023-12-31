class IdeaInfo {
  int? id; //데이터 컬럼 id
  String title; //제목
  String motive; //동기
  String content; //아이디어내용
  int priority; //아이디어 중요도 점수
  String feedback; //유저 피드백 사항
  int createdAt; //생성 일시

  //생성자
  IdeaInfo({
    this.id,
    required this.title,
    required this.motive,
    required this.content,
    required this.priority,
    required this.feedback,
    required this.createdAt,
  });

  // map => key, value로 이루어진 자료형

  //IdeaInfo 데이트 클래스를 map 객체로 변환
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'motive': motive,
      'content': content,
      'priority': priority,
      'feedback': feedback,
      'createdAt': createdAt,
    };
  }

  //맵 객체를 IdeaInfo 데이터 클래스로 변환
  factory IdeaInfo.fromMap(Map<String, dynamic> map) {
    return IdeaInfo(
      id: map['id'],
      title: map['title'],
      motive: map['motive'],
      content: map['content'],
      priority: map['priority'],
      feedback: map['feedback'],
      createdAt: map['createdAt'],
    );
  }
}
