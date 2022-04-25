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