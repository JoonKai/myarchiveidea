import 'package:flutter/material.dart';
import 'package:myarchiveidea/data/idea_info.dart';
import 'package:myarchiveidea/database/database_helper.dart';

class EditScreen extends StatefulWidget {
  IdeaInfo? ideaInfo;
  EditScreen({super.key, this.ideaInfo});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  //아이디어 제목
  final TextEditingController _titleController = TextEditingController();
  //아이디어 계기
  final TextEditingController _motiveController = TextEditingController();
  //아이디어 내용
  final TextEditingController _contentController = TextEditingController();
  //피드팩 사항
  final TextEditingController _feedbackController = TextEditingController();

  //아이디어 중요도 점수 container 클릭 상태 관리 변수
  bool isClickPoint1 = false;
  bool isClickPoint2 = false;
  bool isClickPoint3 = true;
  bool isClickPoint4 = false;
  bool isClickPoint5 = false;

  //아이디어 선택된 현재 중요도 점수(default value =3)
  int priorityPoint = 3;

  final dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back_ios,
            size: 24,
            color: Colors.black,
          ),
          onTap: () {
            //back button 처리
            Navigator.pop(context);
          },
        ),
        title: const Text(
          '새 아이디어 작성',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('제목'),
              Container(
                margin: const EdgeInsets.only(top: 8),
                height: 41,
                child: TextField(
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xffd9d9d9),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: '아이디어 제목',
                    hintStyle: const TextStyle(
                      color: Color(0xffb4b4b4),
                    ),
                  ),
                  style: const TextStyle(fontSize: 12, color: Colors.black),
                  controller: _titleController,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text('아이디어를 작성한 계기'),
              Container(
                margin: const EdgeInsets.only(top: 8),
                height: 41,
                child: TextField(
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xffd9d9d9),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: '아이디어 떠올린 계기',
                    hintStyle: const TextStyle(
                      color: Color(0xffb4b4b4),
                    ),
                  ),
                  style: const TextStyle(fontSize: 12, color: Colors.black),
                  controller: _motiveController,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text('아이디어 내용'),
              Container(
                margin: const EdgeInsets.only(top: 8),
                child: TextField(
                  maxLength: 500,
                  maxLines: 5,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xffd9d9d9),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: '떠오르신 아이디어를 자세하게 작성해주세요.',
                    hintStyle: const TextStyle(
                      color: Color(0xffb4b4b4),
                    ),
                  ),
                  style: const TextStyle(fontSize: 12, color: Colors.black),
                  controller: _contentController,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text('아이디어 중요도 점수'),
              Container(
                margin: const EdgeInsets.only(top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        width: 50,
                        height: 40,
                        decoration: ShapeDecoration(
                          color: isClickPoint1
                              ? const Color(0xffd6d6d6)
                              : Colors.white,
                          shape: RoundedRectangleBorder(
                            side:
                                const BorderSide(width: 1, color: Colors.black),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          '1',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      onTap: () {
                        //1.모든 버튼 값 초기화
                        initClickStatus();
                        //2.선택된 버튼에 대한 변수 값 및 위젯 update
                        setState(() {
                          priorityPoint = 1;
                          isClickPoint1 = true;
                        });
                      },
                    ),
                    GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        width: 50,
                        height: 40,
                        decoration: ShapeDecoration(
                          color: isClickPoint2
                              ? const Color(0xffd6d6d6)
                              : Colors.white,
                          shape: RoundedRectangleBorder(
                            side:
                                const BorderSide(width: 1, color: Colors.black),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          '2',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      onTap: () {
                        initClickStatus();
                        setState(() {
                          priorityPoint = 2;
                          isClickPoint2 = true;
                        });
                      },
                    ),
                    GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        width: 50,
                        height: 40,
                        decoration: ShapeDecoration(
                          color: isClickPoint3
                              ? const Color(0xffd6d6d6)
                              : Colors.white,
                          shape: RoundedRectangleBorder(
                            side:
                                const BorderSide(width: 1, color: Colors.black),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          '3',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      onTap: () {
                        initClickStatus();
                        setState(() {
                          priorityPoint = 3;
                          isClickPoint3 = true;
                        });
                      },
                    ),
                    GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        width: 50,
                        height: 40,
                        decoration: ShapeDecoration(
                          color: isClickPoint4
                              ? const Color(0xffd6d6d6)
                              : Colors.white,
                          shape: RoundedRectangleBorder(
                            side:
                                const BorderSide(width: 1, color: Colors.black),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          '4',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      onTap: () {
                        initClickStatus();
                        setState(() {
                          priorityPoint = 4;
                          isClickPoint4 = true;
                        });
                      },
                    ),
                    GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        width: 50,
                        height: 40,
                        decoration: ShapeDecoration(
                          color: isClickPoint5
                              ? const Color(0xffd6d6d6)
                              : Colors.white,
                          shape: RoundedRectangleBorder(
                            side:
                                const BorderSide(width: 1, color: Colors.black),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          '5',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      onTap: () {
                        initClickStatus();
                        setState(() {
                          priorityPoint = 5;
                          isClickPoint5 = true;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text('유저 피드백 사항 (선택)'),
              Container(
                margin: const EdgeInsets.only(top: 8),
                child: TextField(
                  maxLength: 500,
                  maxLines: 5,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xffd9d9d9),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: '떠오르신 아이디어 기반으로\n전달받은 피드백들을 정리해주세요',
                    hintStyle: const TextStyle(
                      color: Color(0xffb4b4b4),
                    ),
                  ),
                  style: const TextStyle(fontSize: 12, color: Colors.black),
                  controller: _feedbackController,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              //아이디어 작성완료 버튼
              GestureDetector(
                child: Container(
                  height: 65,
                  alignment: Alignment.center,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        width: 1,
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('아이디어 작성 완료'),
                ),
                onTap: () async {
                  //아이디어 작성 (database insert) 처리
                  String titleValue = _titleController.text.toString();
                  String motiveValue = _motiveController.text.toString();
                  String contentValue = _contentController.text.toString();
                  String feedbackValue = _feedbackController.text.toString();

                  //유효성 검사(비어 있는 필수 입력 값에 대한 체크)
                  if (titleValue.isEmpty ||
                      motiveValue.isEmpty ||
                      contentValue.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('비어있는 입력 값이 존재합니다.'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    return;
                  }

                  if (widget.ideaInfo == null) {
                    //아이디어 정보 클래스 인스턴스 생성 후 db 삽입
                    var ideaInfo = IdeaInfo(
                      title: titleValue,
                      motive: motiveValue,
                      content: contentValue,
                      priority: priorityPoint,
                      feedback: feedbackValue.isNotEmpty ? feedbackValue : '',
                      createdAt: DateTime.now().millisecondsSinceEpoch,
                    );

                    await setInsertIdeaInfo(ideaInfo);
                    if (mounted) {
                      //모든시나리오가 완료 되었으니 이전화면으로 이동
                      Navigator.pop(context);
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future setInsertIdeaInfo(IdeaInfo ideaInfo) async {
    await dbHelper.initDatabase();
    await dbHelper.insertIdeaInfo(ideaInfo);
  }

  void initClickStatus() {
    //클릭 상태를 초기화 해주는 함수
    isClickPoint1 = false;
    isClickPoint2 = false;
    isClickPoint3 = false;
    isClickPoint4 = false;
    isClickPoint5 = false;
  }
}
