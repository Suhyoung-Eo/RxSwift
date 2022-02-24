import UIKit
import RxSwift
import RxCocoa


//MARK: - Part 1. Subscribe

//let observable = Observable.just(1) // type: Observable<Int>
//let observable2 = Observable.of(1,2,3)  // type: Observable<Int>
//let observable3 = Observable.of([1,2,3])  // type: Observable<[Int]>
//let observable4 = Observable.from([1,2,3,4,5])  // type: Observable<Int>
//
//observable4.subscribe { event in
//    print(event)
//}
//
//observable4.subscribe { event in
//    if let element = event.element {
//        print(element)
//    }
//}
//
//observable4.subscribe(onNext: { event in
//    print(event)
//})
//
//observable3.subscribe { event in
//    print(event)
//}
//
//observable3.subscribe { event in
//    if let element = event.element {
//        print(element)
//    }
//}
// 출력: next(1), next(2), next(3), next(4), next(5), completed
// 1, 2, 3, 4, 5
// 1, 2, 3, 4, 5
// next([1, 2, 3]), completed
// [1, 2, 3]


//MARK: - Part 2. DisposeBag

//let disposeBag = DisposeBag()
//
//Observable.of("A", "B", "C")
//    .subscribe {
//        print($0)
//    }.disposed(by: disposeBag)
//
//Observable<String>.create { observer in
//    observer.onNext("A")
//    observer.onCompleted()
//    observer.onNext("?")
//    return Disposables.create()
//}.subscribe(onNext: { print($0) },
//            onError: { print($0) },
//            onCompleted: { print("Completed") },
//            onDisposed: { print("Disposed") }
//).disposed(by: disposeBag)
// 출력: next(A), next(B), next(C), completed
// A, Completed, Disposed


//MARK: - Part 3. Publish subject

//let disposeBag = DisposeBag()
//let subject = PublishSubject<String>()
//
//subject.onNext("Issue 1")
//
//subject.subscribe { event in
//    print(event)
//}
//
//subject.onNext("Issue 2")
//subject.onNext("Issue 3")
//
//subject.onCompleted()   // subject 완료 이벤트 개념 - completed 이벤트 날림
//subject.dispose() // subject 해제 개념
//
//subject.onNext("Issue 4")   // 해당 이벤트는 해제/완료 후 - 관찰 되지 않는다.
// 출력: (onCompleted()) next(Issue 2), next(Issue 3), completed
//      (dispose()) next(Issue 2), next(Issue 3)
// 동시: onCompleted() -> dispose(): next(Issue 2), next(Issue 3), completed
// 동시: dispose() -> onCompleted(): next(Issue 2), next(Issue 3)

//MARK: - Part 4. Behavior subject

//let disposeBag = DisposeBag()
//let subject = BehaviorSubject(value: "Initial Value")
//
////subject.onNext("Repace with initail value")
//
//subject.subscribe { event in
//    print(event)
//}
//
//subject.onNext("Issue 1")
// 출력: next(Initial Value), next(Issue 1)


//MARK: - Part 5. Replay subject

//let dispoesBag = DisposeBag()
//let subject = ReplaySubject<String>.create(bufferSize: 2)
//
//subject.onNext("Issue 1")
//subject.onNext("Issue 2")
//subject.onNext("Issue 3")
//subject.onNext("Issue 4")
//
//subject.subscribe {
//    print($0)
//}
//
//subject.onNext("Issue 5")
//subject.onNext("Issue 6")
//subject.onNext("Issue 7")
//
//print("[Subscription 2]")
//
//subject.subscribe { event in
//    print(event)
//}
// 출력: next(Issue 3), next(Issue 4), next(Issue 5), next(Issue 6), next(Issue 7)
// [Subscription 2]
// next(Issue 6), next(Issue 7)

//MARK: - Part 6. Variable  (deprecation)

//let disposeBag = DisposeBag()
//let variable = Variable([String]())
//
//variable.value.append("Item 1")
//
//variable.asObservable()
//    .subscribe { event in
//        print(event)
//    }
//
//variable.value.append("Item 2")
// 출력: next(["Item 1"]), next(["Item 1", "Item 2"])

//MARK: - Part 7. BehaviorRelay

//let disposeBag = DisposeBag()
//let relay = BehaviorRelay(value: [String]())
//
//relay.accept(["Item 1"])
//
//relay.asObservable()
//    .subscribe{
//        print($0)
//    }
//
//relay.accept(relay.value + ["Item 2"])
//
//let relay2 = BehaviorRelay(value: ["Item 1"])
//
//var value = relay2.value
//value.append("Item 2")
//value.append("Item 3")
//
//relay2.accept(value)
//
//relay2.asObservable()
//    .subscribe{
//        print($0)
//    }
// 출력: next(["Item 1"]), next(["Item 1", "Item 2"]), next(["Item 1", "Item 2", "Item 3"])

/* Filtering Operator */

//MARK: - Part 8. Ignore

//let strikes = PublishSubject<String>()
//let disposeBag = DisposeBag()
//
//strikes.ignoreElements().subscribe { _ in
//    print("[subscribe is called]")
//}.disposed(by: disposeBag)
//
//strikes.onNext("A")
//strikes.onNext("B")
//strikes.onNext("C")
//
//strikes.onCompleted()
// 출력: [subscribe is called]

//MARK: - Part 9. Element At

//let strikes = PublishSubject<String>()
//let disposeBag = DisposeBag()
//
//// completed 이벤트도 호출 -> 프린트 두번 찍힘
//// onNext사용시 value만 호출 -> 프린트 한번 찍힘
//strikes.elementAt(2).subscribe {
//    print($0)
//}.disposed(by: disposeBag)
//
//strikes.onNext("A")
//strikes.onNext("B")
//strikes.onNext("C")
// 출력: next(C), completed

//MARK: - Part 10. Filter

//let disposeBag = DisposeBag()
//
//Observable.of(1,2,3,4,5,6,7,8)
//    .filter{ $0 % 2 == 0 }
//    .subscribe(onNext: {
//        print($0)
//    }).disposed(by: disposeBag)
// 출력: 2, 4, 6, 8

//MARK: - Part 11. Skip

//let disposeBag = DisposeBag()
//
//Observable.of("A", "B", "C", "D", "E", "F")
//    .skip(3)
//    .subscribe(onNext: {
//        print($0)
//    }).disposed(by: disposeBag)
// 출력: D, E, F

//MARK: - Part 12. Skip while

//let disposeBag = DisposeBag()
//
//Observable.of(2,2,2,3,2,4,4)
//    .skipWhile { $0 % 2 == 0 }
//    .subscribe(onNext: {
//        print($0)
//    }).disposed(by: disposeBag)
// 출럭: 3, 2, 4, 4

//MARK: - Part 13. Skip until

//let disposeBag = DisposeBag()
//let subject = PublishSubject<String>()
//let trigger = PublishSubject<String>()
//
//subject.skipUntil(trigger)
//    .subscribe(onNext: {
//        print($0)
//    }).disposed(by: disposeBag)
//
//subject.onNext("A")
//subject.onNext("B")
//subject.onNext("C")
//
//trigger.onNext("X")
//
//subject.onNext("D")
// 출력: D

//MARK: - Part 14. Take

//let disposeBag = DisposeBag()
//let subject = PublishSubject<Int>()
//
//Observable.of(1,2,3,4,5,6)
//    .take(3)
//    .subscribe(onNext: {
//        print($0)
//    }).disposed(by: disposeBag)
//
//subject.take(3)
//    .subscribe(onNext: {
//        print($0)
//    }).disposed(by: disposeBag)
//
//subject.onNext(1)
//subject.onNext(2)
//subject.onNext(3)
//subject.onNext(4)
//subject.onNext(5)
//subject.onNext(6)
// 출력: 1,2,3
// 1,2,3

//MARK: - Part 15. Take while
//
//let disposeBag = DisposeBag()
//
//Observable.of(2,4,6,7,8,10)
//    .takeWhile {
//        return $0 % 2 == 0
//    }.subscribe(onNext: {
//        print($0)
//    }).disposed(by: disposeBag)
// 출력: 2, 4, 6

//MARK: - Part 16. Take until

//let disposeBag = DisposeBag()
//let subject = PublishSubject<Int>()
//let trigger = PublishSubject<Int>()
//
//subject.takeUntil(trigger)
//    .subscribe(onNext: {
//        print($0)
//    }).disposed(by: disposeBag)
//
//subject.onNext(1)
//subject.onNext(2)
//
//trigger.onNext(1)
//
//subject.onNext(3)
//subject.onNext(4)
//출력: 1, 2

/* Transforming Operators */

//MARK: - Part 17. ToArray

//let disposeBag = DisposeBag()
//
//Observable.of(1, 2, 3, 4, 5, 6)
//    .toArray()
//    .subscribe(onSuccess: {
//        print($0)
//    }).disposed(by: disposeBag)
// 출력: [1, 2, 3, 4, 5, 6]

//MARK: - Part 18. Map

//let disposeBag = DisposeBag()
//
//Observable.of(1, 2, 3, 4, 5, 6)
//    .map{ return $0 * 2 }
//    .subscribe(onNext: {
//       print($0)
//    }).disposed(by: disposeBag)
// 출력: 2, 4, 6, 8, 10, 12

//MARK: - Part 19. Flat map

//let disposeBag = DisposeBag()
//
//struct Student {
//    var score: BehaviorRelay<Int>
//}
//
//let john = Student(score: BehaviorRelay(value: 75))
//let mary = Student(score: BehaviorRelay(value: 95))
//
//let student = PublishSubject<Student>()
//
//student.asObservable()
//    .flatMap { $0.score.asObservable() }
//    .subscribe(onNext: {
//        print($0)
//    }).disposed(by: disposeBag)
//
//student.onNext(john)
//john.score.accept(100)
//
//student.onNext(mary)
//mary.score.accept(80)
//
//john.score.accept(43)
// 출력: 75, 100, 95, 80, 43

//MARK: - Part 20. Flat map latest

//let disposeBag = DisposeBag()
//
//struct Student {
//    var score: BehaviorRelay<Int>
//}
//
//let john = Student(score: BehaviorRelay(value: 75))
//let mary = Student(score: BehaviorRelay(value: 95))
//
//let student = PublishSubject<Student>()
//
//student.asObservable()
//    .flatMapLatest { $0.score.asObservable() }
//    .subscribe(onNext: {
//        print($0)
//    }).disposed(by: disposeBag)
//
//student.onNext(john)
//john.score.accept(100)
//
//student.onNext(mary)
//john.score.accept(45)
//mary.score.accept(80)
// 출력: 75, 100, 95, 80

/* Combining Operators */

//MARK: - Part 21. Starts with

//let disposeBag = DisposeBag()
//
//let numbers = Observable.of(2, 4, 3)
//let observable = numbers.startWith(1)
//
//observable.subscribe(onNext: {
//    print($0)
//}).disposed(by: disposeBag)
// 출력: 1, 2, 4, 3

//MARK: - Part 22. Concat

//let disposeBag = DisposeBag()
//
//let first = Observable.of(2, 1, 3)
//let second = Observable.of(4, 5, 6)
//
//let observable = Observable.concat([second, first])
//
//observable.subscribe(onNext: {
//    print($0)
//}).disposed(by: disposeBag)
// 출력: 4, 5, 6, 2, 1, 3

//MARK: - Part 23. Merge

//let disposeBag = DisposeBag()
//
//let left = PublishSubject<Int>()
//let right = PublishSubject<Int>()
//
//let source = Observable.of(left.asObserver(), right.asObserver())
//
//let observable = source.merge()
//
//observable.subscribe(onNext: {
//    print($0)
//}).disposed(by: disposeBag)
//
//left.onNext(5)
//left.onNext(3)
//right.onNext(2)
//right.onNext(1)
//left.onNext(99)
// 출력: 5, 3, 2, 1, 99

//MARK: - Combine latest

//let disposeBag = DisposeBag()
//
//let left = PublishSubject<Int>()
//let right = PublishSubject<Int>()
//
//let observable = Observable.combineLatest(left, right) { lastLeft, lastRight in
//    "\(lastLeft) \(lastRight)"
//}
//
//let disposable = observable.subscribe(onNext: {
//    print($0)
//})
//
////observable.subscribe(onNext: {
////    print($0)
////}).disposed(by: disposeBag)
//
//left.onNext(45)
//right.onNext(1)
//left.onNext(30)
//right.onNext(99)
//right.onNext(2)
// 출력: 45 1, 30 1, 30 99, 30 2

//MARK: - With latest From

//let disposeBag = DisposeBag()
//
//let button = PublishSubject<Void>()
//let textField = PublishSubject<String>()
//
//let observable = button.withLatestFrom(textField)
//let disposable = observable.subscribe(onNext: {
//    print($0)
//})
//
//textField.onNext("Sw")
//textField.onNext("Swif")
//textField.onNext("Swift")
//textField.onNext("Swift Rocks!")
//
//button.onNext(())
//button.onNext(())
// 출력: Swift Rocks!, Swift Rocks!

//MARK: - Reduce

//let disposeBag = DisposeBag()
//
//let source = Observable.of(1, 2, 3)
//
//source.reduce(0, accumulator: + )
//    .subscribe(onNext: {
//        print($0)
//    }).disposed(by: disposeBag)
//
//source.reduce(0) { summary, newValue in
//    return summary + newValue
//}.subscribe(onNext: {
//    print($0)
//}).disposed(by: disposeBag)
// 출력: 6, 6

//MARK: - Scan

//let disposeBag = DisposeBag()
//
//let source = Observable.of(1, 2, 3, 4, 5, 6)
//
//source.scan(0, accumulator: + )
//    .subscribe(onNext: {
//        print($0)
//    }).disposed(by: disposeBag)
//
//source.scan(0) { summary, newValue in
//    return summary + newValue
//}.subscribe(onNext: {
//    print($0)
//}).disposed(by: disposeBag)
// 출력: 1, 3, 6, 10, 15, 21
// 1, 3, 6, 10, 15, 21

