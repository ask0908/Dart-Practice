import 'dart:async'; // stream 컨트롤러를 쓰기 위해 필요한 임포트문. 보통은 라이브러리들을 써서 스트림을 쓰고 이 패키지는 잘 쓰지 않는다. 기본을 위해서 사용

void main() async {
  // Future - 미래에 받아올 값을 저장함. 비동기 프로그래밍 시 사용. 자바에서 가져온 듯
  Future<String> name = Future.value("미래에 받아올 string 값");
  Future<int> number = Future.value(1);
  Future<bool> isTrue = Future.value(true);

  /**
   * delayed()
   * 1번 파라미터 : 얼마나 지연시킬 것인가?
   * 2번 파라미터 : 지연시간 이후 실행할 함수
   */
  // Future.delayed(Duration(seconds: 1), () {
  //   print("Delay 끝!!");
  // });

  // main()에 async를 붙이고 addNumbers()의 void를 Future로 감싸면 addNumbers(1, 1)이 완전히 끝나야 addNumbers(2, 2)가 호출된다
  // final result = await addNumbers(1, 1);
  // final result2 = await addNumbers(2, 2);
  // print("result1 : $result");
  // print("result2 : $result2");
  // print("result1 + result2 : ${result + result2}");

  final controller = StreamController();
  // final stream = controller.stream;
  // stream을 여러 번 계속 listen하려면 asBroadcastStream()을 stream 뒤에 붙여 변환함
  final stream = controller.stream.asBroadcastStream();
  // 함수가 값을 듣고 있다가 값이 들어오면 바로 함수 실행
  final streamListener1 = stream.where((val) => val % 2 == 0).listen((val) {
    // 짝수만 출력
    print("listener1 : $val");
  });
  final streamListener2 = stream.where((val) => val % 2 == 1).listen((val) {
    // 홀수만 출력
    print("listener2 : $val");
  });

  // 컨트롤러에 값을 넣음. 가장 기본적인 방법
  // controller.sink.add(1);
  // controller.sink.add(2);
  // controller.sink.add(3);
  // controller.sink.add(4);
  // controller.sink.add(5);

  // calculate2(2).listen((val) {
  //   print("calculate(2) : $val");
  // });
  // calculate2(4).listen((val) {
  //   print("calculate(4) : $val");
  // });

  // 1번째 stream 함수가 끝나고 2번째 stream 함수를 실행하는 법
  playAllStream().listen((val) {
    print(val);
  });
}

// await를 쓸 거면 async를 시그니처와 본문 블록 사이에 무조건 넣어줘야 함
// Future<void> addNumbers(int num1, int num2) async {
//   print("계산 시작 : $num1 + $num2");
//
//   // 서버 시뮬레이션. 2초간 1+1을 서버에 계산 요청해서 값을 받아오는 시뮬레이션
//   // 2초 후에 2번 파라미터 함수의 본문 실행
//   // await는 Future 내장 함수 앞에 써야 함. 이걸 쓰면 async 코드를 기다린다. 기다리는 동안 CPU는 다른 작업을 할 수 있다
//   await Future.delayed(Duration(seconds: 2), () {
//     print("계산 완료 : $num1 + $num2 = ${num1 + num2}");
//   });
//   print("함수 완료");
// }

// 리턴값이 있는 Future 함수를 사용할 경우
Future<int> addNumbers(int num1, int num2) async {
  print("계산 시작 : $num1 + $num2");

  // 서버 시뮬레이션. 2초간 1+1을 서버에 계산 요청해서 값을 받아오는 시뮬레이션
  // 2초 후에 2번 파라미터 함수의 본문 실행
  // await는 Future 내장 함수 앞에 써야 함. 이걸 쓰면 async 코드를 기다린다. 기다리는 동안 CPU는 다른 작업을 할 수 있다
  await Future.delayed(Duration(seconds: 1), () {
    print("계산 완료 : $num1 + $num2 = ${num1 + num2}");
  });
  print("함수 완료");

  return num1 + num2;
}

// 함수로 stream 사용하기
Stream<int> calculate(int num) async* {
  for (int i = 0; i < 5; i++) {
    // 매개변수와 i를 곱한 값을 반복할 때마다 돌려준다
    yield i * num;
  }
}

// async 함수를 async*에서 쓰는 법
Stream<int> calculate2(int num) async* {
  for (int i = 0; i < 5; i++) {
    // 매개변수와 i를 곱한 값을 반복할 때마다 돌려준다
    yield i * num;

    // 1초 뒤 다음 값 출력
    await Future.delayed(Duration(seconds: 1));
  }
}

// 1번째 stream 함수가 끝나고 2번째 stream 함수를 실행하는 법
Stream<int> playAllStream() async* {
  // yield*을 쓰면 1을 넣은 함수가 먼저 실행되고 이게 끝나야 1000을 넣은 함수가 실행된다
  yield* calculate2(1);
  yield* calculate2(1000);
}