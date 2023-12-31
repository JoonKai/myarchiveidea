import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

import '../data/idea_info.dart';
import '../database/database_helper.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var dbHelper = DatabaseHelper(); //데이터베이스 접근을 용이하게 해주는 유틸 객체
  List<IdeaInfo> lstIdeaInfo = []; //아이디어 목록 데이터들이 담길 배열

  @override
  void initState() {
    super.initState();

    //아이디어 목록들 가져오기
    getIdeaInfo();

    //임시용으로 insert data
    //setInsertIdeaInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Archive Idea',
          style: TextStyle(
            color: Colors.black,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: lstIdeaInfo.length,
          itemBuilder: (context, index) {
            return listItem(index);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //새 아이디어 작성 화면으로 이동
        },
        backgroundColor: const Color(0xff7f42fd).withOpacity(0.7),
        child: Image.asset(
          'assets/idea.png',
          width: 48,
          height: 48,
        ),
      ),
    );
  }

  Widget listItem(int index) {
    return Container(
      height: 82,
      margin: const EdgeInsets.only(top: 16),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Color(0xffd9d9d9), width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Stack(
        //스택패널과 같은 위젯
        alignment: Alignment.centerLeft,
        children: [
          ///아이디어 제목
          Container(
            margin: const EdgeInsets.only(left: 16, bottom: 16),
            child: Text(
              lstIdeaInfo[index].title,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),

          ///일시
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: const EdgeInsets.only(right: 16, bottom: 8),
              child: Text(
                DateFormat("yyyy.MM.dd HH:mm").format(
                  DateTime.fromMillisecondsSinceEpoch(
                      lstIdeaInfo[index].createdAt),
                ),
                style: const TextStyle(
                  color: Color(0xffaeaeae),
                  fontSize: 10,
                ),
              ),
            ),
          ),

          ///아이디어 중요도 점수( 별 형태로)
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              margin: const EdgeInsets.only(left: 16, bottom: 8),
              child: RatingBar.builder(
                initialRating: lstIdeaInfo[index].priority.toDouble(),
                minRating: 1,
                direction: Axis.horizontal,
                itemCount: 5,
                itemSize: 16,
                itemPadding: const EdgeInsets.symmetric(horizontal: 0),
                itemBuilder: (context, index) {
                  return const Icon(
                    Icons.star,
                    color: Colors.amber,
                  );
                },
                ignoreGestures: true,
                updateOnDrag: false,
                onRatingUpdate: (value) {},
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future getIdeaInfo() async {
    //아이디어 목록 조회(select)
    await dbHelper.initDatabase();
    //idea 정보들을 가지고 와서 멤버 (전역) 변수 리스트 객체에 담기
    lstIdeaInfo = await dbHelper.getAllIdeaInfo();
    // 리스트 객체 역순으로 정렬
    lstIdeaInfo.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    setState(() {}); //리스트 갱신
  }

  Future setInsertIdeaInfo() async {
    await dbHelper.initDatabase();
    await dbHelper.insertIdeaInfo(
      IdeaInfo(
        title: '#환경 보존 문제 해결 앱 아이디어',
        motive: '길가다가 쓰레기 주우면서 알게됨',
        content: '자세한 내용입니다....',
        priority: 5,
        feedback: '피드백 사항입니다.',
        createdAt: DateTime.now().millisecondsSinceEpoch,
      ),
    );
  }
}
