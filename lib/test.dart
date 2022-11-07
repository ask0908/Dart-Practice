void main() {
  // 변수 (타입 추론 가능)
  var name = '하이';
  print(name);
  name = "테스트";
  print(name);

  // Error: 'name' is already declared in this scope.
  // var name = "변수 재선언 안됨";

  /* 타입 */
  int number = 1;
  int number2 = -10;
  print("number $number, number2 : $number2"); // 달러 표시로 문자열 안에 변수 사용 가능

  double numbers = 2.4;
  // float는 없음

  // 자바는 boolean, 코틀린은 Boolean, Dart는 bool
  bool isFirst = true;
  bool isSecond = false;

  String age = "나이";
  String dagger = "단검";
  print("age : $age, dagger : $dagger");
  print(age.runtimeType); // runtimeType : 타입 체크

  // dynamic?
  dynamic any = "아무거나 다 들어가는 타입";
  dynamic any2 = 1;
  dynamic any3 = 1.52;
  print("${any.runtimeType}, ${any2.runtimeType}, ${any3.runtimeType}");
  any = 1;
  print("${any.runtimeType}");

  // nullable, non-nullable
  String? nulls = 'other';
  print(nulls);

  // final, const
  // final : 변수값을 한번 선언하면 바꿀 수 없음
  final String bbb = "네임";
  // const : final과 마찬가지
  const String ccc = "const인데요";
  // final, const를 쓰면 타입 생략 가능
  const ddd = "타입 없어도 됨";
  final eee = "타입 없어도 됨 22";
  print("$ddd $eee");

  // const : 런타임에 값을 알고 있어야 함
  // final : 런타임에 값 몰라도 됨
  // final DateTime now = DateTime.now();
  // const DateTime now2 = DateTime.now();

  // operator
  int two = 2;
  print(two % 2); // 0
  print(two % 3); // 2
  two++;
  print(two); // 3

  // List
  List<String> nameList = ["1", "2", "3", "4"];
  List<int> intList = [1, 2, 3, 4];
  print(nameList);
  print(intList);

  // index
  print(nameList[0]);
  print(intList[1]);

  // Map
  Map<String, String> nameMaps = {"a": "에이", "b": "비"};
  print(nameMaps); // {a: 에이, b: 비}
  print(nameMaps["a"]); // 에이
  print(nameMaps["에이"]); // null
  nameMaps["C"] = "씨"; // Map에 데이터 추가
  print(nameMaps);
  print(nameMaps["C"]);
  print(nameMaps.keys); // (a, b, C)
  print(nameMaps.values);

  // Set
  final Set<String> nameSet = {"a", "b", "a"};
  print(nameSet);
  print(nameSet.contains("c"));

  // switch는 자바랑 같음
  int testNum = 2;
  switch (testNum % 2) {
    case 0:
      print("나머지가 0");
      break;
    case 1:
      print("나머지가 1");
      break;
    default:
      print("나머지가 2");
  }

  // for는 자바랑 같음
  List<int> forNumbers = [1, 2, 3, 4, 5, 6];
  int total = 0;
  for (int i = 0; i < forNumbers.length; i++) {
    print("list 안에 들어있는 값들 : $i");
    total += forNumbers[i];
  }
  print("반복문 안에서 모든 숫자 더하면 : $total");

  // 이 방식은 코틀린 for문과 비슷하지만 in 좌항에 타입이 들어가는 게 다르다
  for (int number in forNumbers) {
    print(number);
  }

  Status status = Status.pending;
  switch (status) {
    case Status.pending :
      print("pending");
      break;

    case Status.approved :
      print("approved");
      break;

    case Status.REJECTED :
      print("rejected");
      break;

    default :
      break;
  }

  addNumbers();
  print(test2());

  // 함수 선언 단계에서 초기값을 설정했으면 사용할 때는 당연히 초기값을 설정한 변수값을 따로 지정할 필요는 없음
  arrowFuncTest(y: 20, z: 30);

  // typedef call
  int addResult = addOperation(10, 10, 10);
  int minusResult = minusOperation(30, 20, 10);
  print(addResult);
  print(minusResult);

  int addResult2 = calculate(10, 10, 10, addOperation); // 'Operation operation'에 더하기 연산(addOperation)을 넣으면 x, y, z를 더해서 리턴한다
  print(addResult2);
}

// enum (예제에선 소문자 썼는데 enum은 대문자가 국룰 아닌가?)
enum Status {
  approved,
  pending,
  REJECTED
}

// Dart는 함수 선언할 때 fun, void를 쓰지 않음. void는 생략해도 됨
addNumbers() {
  print('addNumbers() 실행');
}

int addNumbers2() {
  print("print");
  return 0;
}

// 그냥 자바 생각하면 됨. 함수명 앞에 타입 쓰면 그 타입을 함수에서 리턴시킴
int test(int a, int b) {
  return a + b;
}

List<int> test2() {
  return [1, 2, 3, 4];
}

// optional parameter
// [] 안의 타입에 ?를 넣지 않으면 에러 발생함. null이 들어갈 수 있기 때문에 개발자가 nullable임을 명시해야 함
// optional params를 연산하려는 경우, ?를 지우고 optional parameter 들을 기본값으로 초기화한다
int optionalParamsTest(int x, [int y = 0, int z = 0]) {
  int sum = x + y + z;
  return 0;
}

// named parameter : 이름 있는 아규먼트와 비슷함. 순서가 중요하지 않음
// required : named parameter 설정 시 사용. 이걸 쓰면 "x: 10" 형태로 이름을 써줘야 함ㅋㅋ이건 코틀린이 더 낫네
// 화살표(=>)를 쓰면 우항이 리턴값
int arrowFuncTest({
  int x = 10,
  required int y,
  int z = 30
}) => x + y + z;

// typedef : 함수를 편하게 쓸 수 있는 기능
typedef Operation = int Function(int x, int y, int z); // 이 함수 형태에 해당하는 함수들을 같은 typedef를 써서 선언할 수 있음

// typedef 사용 시 typedef의 리턴값, 파라미터가 완전히 일치해야 함
int addOperation(int x, int y, int z) => x + y + z;
int minusOperation(int x, int y, int z) => x - y - z;

// operation에 따라 x, y, z의 연산이 바뀐다
int calculate(int x, int y, int z, Operation operation) {
  return operation(x, y, z);
}