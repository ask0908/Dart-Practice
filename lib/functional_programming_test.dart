void main() {
  List<String> people = ["A", "B", "C", "D"];

  // Dart도 코틀린처럼 stream()을 쓸 필요 없이 바로 스트림 계열 함수를 호출할 수 있다
  final newPeople = people.map((value) {
    return '수정된 $value';
  });

  print(people); // [A, B, C, D]
  print(
      newPeople); // (수정된 A, 수정된 B, 수정된 C, 수정된 D) <- Iterable 타입으로 만들어짐. toList() 붙이면 리스트 형태로 바뀜

  final newPeople2 = people.map((e) => '다시 수정된 $e');
  print(newPeople2);

  final newPeople3 = people.map((e) => '다시다시 수정된 $e');

  // split
  String number = "13579";
  final parsed = number.split('').map((x) => "$x.jpg").toList();
  print(parsed);

  // Map을 매핑할 때 자주 쓰는 패턴. 맵 안의 키밸류들을 바꾼다
  Map<String, String> harryPotter = {
    "Harry Potter": "해리포터",
    "Ron Weasley": "론 위즐리",
    "Hermione Granger": "헤르미온느 그레인저"
  };
  // 새 값이 만들어지기 때문에 다른 변수에 할당
  final result = harryPotter.map((key, value) =>
      MapEntry("Harry Potter Character $key", "해리포터 캐릭터 $value"));
  print(harryPotter);
  print(result);

  // Map -> Map 변경은 잘 없지만 아래 경우는 많음
  // final keys = harryPotter.keys.map((x) => 'HPC $x');
  final keys = harryPotter.keys.map((x) => 'HPC $x').toList();
  final values = harryPotter.values.map((e) => "해리포터 $e").toList();
  print(values);

  // Set에서 매핑할 때
  Set set = {'에이', '비', '씨', '디'};
  final newSet = set.map((e) => "알파벳 한글 : $e").toList();
  print(newSet);

  // where()
  List<Map<String, String>> otherList = [
    {'name': '철수', 'group': '사람'},
    {'name': '영희', 'group': '사람'},
    {'name': '롤', 'group': '게임'},
    {'name': '디아블로', 'group': '게임'},
  ];
  print(otherList);

  // List 안의 Map들을 반복하면서 T/F 값을 돌려준다. true를 받으면 값을 유지하고 false를 받으면 해당 값을 삭제한다
  // 사람 group만 유지하려는 경우
  // final result2 = otherList.where((x) => x["group"] == "사람");
  // final result3 = otherList.where((x) => x["group"] == "게임");
  final result2 = otherList.where((x) => x["group"] == "사람").toList();
  final result3 = otherList.where((x) => x["group"] == "게임").toList();
  print(result2);
  print(result3);

  // reduce. 이걸 쓸 때는 사용한 컬렉션의 타입에 주의해야 한다
  List<int> numberList = [1, 3, 5, 7, 9];
  numberList.reduce((prev, next) {
    // print("==============");
    // print("prev : $prev");
    // print("next : $next");
    // print("총합 : ${prev + next}");

    return prev + next;
  });
  final numberResult = numberList.reduce((prev, next) => prev + next);
  print(numberResult); // 25

  // string reduce
  List<String> wordsList = ["하이", "헬로우", "안녕"];
  final sentence = wordsList.reduce((prev, next) => prev + next);
  print(sentence);

  // fold : reduce는 같은 타입을 리턴해야만 했는데 이 단점을 보완함
  // fold 옆에 제네릭으로 어떤 값이 리턴될지 명시해야 한다
  // final sum = numberList.fold<int>(0, (prev, next) => prev + next);
  final sum = numberList.fold<int>(0, (prev, next) {
    print("==============");
    print("prev : $prev");
    print("next : $next");
    print("총합 : ${prev + next}");

    return prev + next;
  });
  print(sum);

  // cascading operator : 여러 리스트를 하나로 합칠 때 사용
  List<int> even = [2, 4, 6, 8];
  List<int> odd = [1, 3, 5, 7];
  print([even, odd]); // [[2, 4, 6, 8], [1, 3, 5, 7]]
  print([...even, ...odd]); // [2, 4, 6, 8, 1, 3, 5, 7]
  print([...even] ==
      even); // false. cascading operator를 사용하면 완전히 새로운 리스트에 값을 넣기 때문에 false가 나온다

  final parsedOtherList = otherList
      .map((x) => Person(
          name: x['name']!, // !를 넣어서 이 키값의 데이터가 존재한다고 알려줌
          group: x['group']!))
      .toList();
  print(parsedOtherList);
  // [Person(name : 철수, group : 사람), Person(name : 영희, group : 사람), Person(name : 롤, group : 게임), Person(name : 디아블로, group : 게임)]

  // for (Person person in parsedOtherList) {
  //   print(person.name);
  //   print(person.group);
  // }
  final parsedResult = parsedOtherList.where((x) => x.group == "게임");
  print(parsedResult); // (Person(name : 롤, group : 게임), Person(name : 디아블로, group : 게임))

  final result4 = otherList
      .map((x) => Person(name: x["name"]!, group: x["group"]!))
      .where((x) => x.group == "게임");
  print(result4); // (Person(name : 롤, group : 게임), Person(name : 디아블로, group : 게임))
  final result5 = otherList
      .map((x) => Person(name: x["name"]!, group: x["group"]!))
      .where((x) => x.group == "게임")
      .fold<int>(0, (prev, next) => prev + next.name.length);
  print(result5); // 롤 + 디아블로 = 5글자기 때문에 5 출력
}

class Person {
  final String name;
  final String group;

  Person({required this.name, required this.group});

  @override
  String toString() {
    return 'Person(name : $name, group : $group)';
  }
}
