import 'package:flutter/material.dart';

void main(){
  runApp(const PortfolioApp()); //앱 시작
}

class PortfolioApp extends StatelessWidget{
  //위젯 재사용 고유 키
  const PortfolioApp({super.key}); 

  @override
  Widget build(BuildContext context){
    return MaterialApp(
       //웹 브라우저 우측 상단 debug 띠 제거
      debugShowCheckedModeBanner: false,
       // 브라우저 탭의 제목
      title: 'Leo의 포트폴리오',
      theme: ThemeData(
        //최신 구글 디자인 사용
        useMaterial3: true 
        //전체 바탕 색
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey), 
      ),
      home: const MainPage(),
      );
  }
}
class MainPage extends StatefulWidget{
  const MainPage({super.key})

  @override
  //가변성 위젯 선언
  State<MainPage> createState() => _MainPageState();
}
class _MainPageState extends State<MainPage>{
  //현재 어떤 메뉴가 선택되어 있는지 기억하는 상태 변수
  int _selectedIndex = 0;
  //각 메뉴를 눌렀을 때 화면 중앙에 갈아 끼워질 페이지들 리스트
  //나중에 이 텍스트들을 별도의 파일(home.dart 등)로 분리됩니다.
  final List<Widget> _pages = [
    const Center(child: Text('Home: 안녕하세요. 개발자 Leo입니다.', style: TextStyle(fontSize: 24), key: ValueKey(0))),
    const Center(child: Text('Projects: 그동안 만든 앱들을 소개합니다.', style: TextStyle(fontSize: 24), key: ValueKey(1))),
    const Center(child: Text('contact: 이메일로 연락 부탁드립니다.', style: TextStyle(fontSize: 24), key: ValueKey(2)))
  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      //가로로 위젯 배치, [왼쪽 사이드바] + [오른쪽 본문]
      body: Row(
        children: [
          //웹에서 가장 선호되는 세로형 메뉴 바
          NavigationRail(
            //현재 활성화되어야 하는 유닛
            selectedIndex: _selectedIndex,
            //사용자가 메뉴 클릭시 활성화
            onDestinationSelected: (int index){
              setState(() {
                //클릭한 번호로 상태를 업데이트
                _selectedIndex = index;
              });
            },
            //아이콘 아래에 글자가 항상 오게 하기
            labelType: NavigationRailLabelType.all,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: Text('Home'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.folder_outlined),
                selectedIcon: Icon(Icons.folder),
                label:Text('Projects'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.contact_mail_outlined),
                selectedIcon: Icon(Icons.contact_mail),
                label:Text('Contact'),
              ),
            ]
          ),
        //수직 실선을 그어 메뉴와 본문 영역 구분
        const VerticalDivider(thickness: 1, width: 1),
        //남은 가로 공간을 본문이 차지하도록 함
        Expanded(
          child: AnimatedSwitcher(
            //페이지 변경 시 부드럽게 해주는 효과(0.3초 동안)
            duration: const Duration(milliseconds: 300),
            child: _pages[_selectedIndex],
          ),
        ),
        ],
      ),
    );
  }
}