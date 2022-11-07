import 'package:fluttertest/class_test.dart';

void main() {
  _Person person = _Person("철수", 10);
  print(person.name);
  person.name = "after";
  print(person.name);
  print(person.age);

  person.greeting();

  _Person test = _Person.fromList(["철수2", 12]);
  print(test.name);
  print(test.age);
  // test.aaa = "bbb"; // 'aaa' can't be used as a setter because it's final

  print("게터 : ${person.firstMember}");
  person.firstMember =
      "setter로 수정"; // setter 사용은 함수 형태로 쓰는 게 아니라 객체의 프로퍼티에 값을 대입하는 방식으로 쓴다
  print("세터 수정 후 : ${person.firstMember}");

  print("============================================================");
  InheritancePractice inheri =
      InheritancePractice(name: "테스트", membersCount: 5);
  inheri.sayName();
  inheri.sayMembersCount();

  AClass a = AClass('상속테스트', 10);
  a.sayMembersCount();
  a.sayName();
  a.sayMale();

  BClass b = BClass('상속테스트B', 12);
  b.sayName();
  b.sayMembersCount();
  b.sayFemale();

  TimesTwo tt = TimesTwo(2);
  print(tt.calculate());

  TimesFour tf = TimesFour(2);
  print(tf.calculate());

  StaticPractice st1 = StaticPractice("A");
  StaticPractice st2 = StaticPractice("B");

  st1.printNameAndBuilding();
  st2.printNameAndBuilding();

  StaticPractice.building = "남산타워";
  st1.printNameAndBuilding();
  st2.printNameAndBuilding();
  StaticPractice.printBuilding();

  print("============================================================");

  InterfaceImpl impl = InterfaceImpl("1번");
  InterfaceImpl2 impl2 = InterfaceImpl2("2번");
  impl.sayName();
  impl2.sayName();

  Lecture<String, String> lecture = Lecture('123', 'lecture1');
  lecture.printIdType();
  Lecture<int, bool> lecture2 = Lecture(123, true);
  lecture2.printIdType();
}

/* 클래스를 private하게 만들려면 클래스명 앞에 언더바를 추가한다. 걍 private 키워드 만들어주지.. */
class _Person {
  // Immutable programming : 값을 선언하면 바꿀 수 없게 만드는 방식을 많이 씀
  // 고상하게 썼는데 그냥 final 붙이는 걸 말함. 코틀린의 val 선언하는 거랑 같음
  final String aaa = "aaa";
  String name = "before"; // 생성자가 없다면 person.name은 당연히 이 변수를 바라본다
  int age = 0;

  // Dart에서 생성자 쓰는 법인데 어지럽네
  // Person(String name, int age): this.name = name, this.age = age;
  // Dart Lint 적용 시 아래처럼 바뀜. 들여쓰기에서 파이썬 냄새가 난다
  // Person(String name, int age)
  //     : this.name = name,
  //       this.age = age;

  // 위의 생성자 코드는 아래처럼 줄여쓸 수 있는데 이것도 어지럽네
  _Person(this.name, this.age);

  // "const 생성자" 형태로 써도 된다고 하는데 여기서 쓰면 에러 발생함

  // named constructor. 다른 생성자 사용법
  _Person.fromList(List values)
      : name = values[0],
        age = values[1];

  void greeting() {
    print("ㅎㅇ");
  }

  // getter, setter
  // getter에 타입을 명시하지 않으면 The return type of getter 'firstMember' is 'dynamic' which isn't a subtype of the type 'String' of its setter 'firstMember'. 에러가 발생한다
  // 공식문서에선 getter의 리턴형이 같은 이름의 setter 매개변수 타입의 하위 타입이 아닐 때 이 에러를 명시한다고 함
  String get firstMember {
    return name;
  }

  set firstMember(String name) {
    this.name = name;
  }
}

class InheritancePractice {
  String name;
  int membersCount;

  InheritancePractice({required this.name, required this.membersCount});

  void sayName() {
    print("나는 ${name}이다");
  }

  void sayMembersCount() {
    print("$name은 $membersCount 명의 멤버가 있다");
  }
}

class AClass extends InheritancePractice {
  // AClass({
  //   required super.name,
  //   required super.membersCount
  // });
  AClass(String name, int membersCount)
      : super(name: name, membersCount: membersCount);

  void sayMale() {
    print("나는 남자다");
  }
}

class BClass extends InheritancePractice {
  BClass(String name, int memberCount)
      : super(name: name, membersCount: memberCount);

  void sayFemale() {
    print("나는 여자다");
  }
}

class TimesTwo {
  final int number;

  TimesTwo(this.number);

  int calculate() {
    return number * 2;
  }
}

class TimesFour extends TimesTwo {
  TimesFour(int number) : super(number);

  // Dart에서 오버라이드 어노테이션은 @override 형태로 직접 쓰는 것에 주의
  @override
  int calculate() {
    return super.calculate() * 2;
    // return number * 4;
  }
}

// static
class StaticPractice {
  static String? building;
  final String name;

  StaticPractice(this.name);

  void printNameAndBuilding() {
    print("내 이름은 $name다. $building 건물에서 근무중이다");
  }

  static void printBuilding() {
    print("나는 $building 건물에서 근무한다");
  }
}

// 인터페이스. Dart는 interface 키워드가 없고 class 키워드로 인터페이스를 만든다
// 그냥 class만 있으면 오해할 수 있어서 앞에 abstract 키워드를 붙인다
abstract class InterfaceTest {
  String name;

  InterfaceTest(this.name);

  void sayName(); // abstract class인 경우 함수 본문을 지워도 된다
}

class InterfaceImpl implements InterfaceTest {
  String name;

  InterfaceImpl(this.name);

  void sayName() {
    print("내 이름은 $name이다");
  }

}

class InterfaceImpl2 implements InterfaceTest {
  String name;

  InterfaceImpl2(this.name);

  void sayName() {
    print("난 2번째로 만든 클래스고 이름은 $name이다");
  }
}

// 제네릭
class Lecture<T, R> {
  final T id;
  final R name;

  Lecture(this.id, this.name);

  void printIdType() {
    print(id.runtimeType);
  }
}