# bom_front

공부에 지친 학생들을 위해 성취감과 동기부여를 느끼게 해주는 앱을 만들고자 한다.

# 팀원

- 김정현 (프론트엔드)
- 신현석 (프론트엔드)
- 박현호 (백엔드)
- 임채진 (백엔드)
- 정가희 (백엔드)

# 과정

1. 기획 2. DB설계 3. UI 디자인설계 4. 구현

# 수정사항

1. 임시방편으로 수정은 각 plan을 길게 눌렀을 때 적용
    - 타이머는 짧게 한번 누르면 시작하는 로직 구상

2. dispose를 적용해야할 것 같다. redering이 너무 잦다
    - autodispose적용할 시 FutureProvider 도입 고려

# 해야할 것

1. mothly와 daily plan 디자인 구별

## 도입해야할 것

1. json_serializable
    - build_runner
    - annotation
2. freezed
3. dio

## backend API 고민한 것

1. check path 부분을 보니 check은 false인 것을 true로 바꾸는 것으로 되어있음. toggle방법으로는 안되나?
    - 서버에서 로직을 구성 or 프론트에서 true/false를 정해서 patch해주는 방식
2. dailyId의 time은 언제 update되는 것인가?
    - 항상 수동으로 해왔다.
   


# Data fetching stateful widget code without riverpod
```
class hi extends StatefulWidget {
  // 나중에 stateful 로 빠궈서 initState 활용
  const hi({Key? key}) : super(key: key);

  @override
  State<hi> createState() => _hiState();
}

class _hiState extends State<hi> {
  TodoRepository _todoRepository = TodoRepository();
  List<Todo> dataTodo = [];

  @override
  void initState() {
    _todoRepository.loadTodos().then((value) {
      setState(() => dataTodo = value);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```