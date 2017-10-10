//: [Previous](@previous) [Table of Contents](Table_of_Contents)
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
/*:
 ## Observables
 `Observable<T>` 是 `Rx` 的基础: 能够异步的产生装载着不可变的类型 T 的事件队列, 简言而之, 一个类可以发射值并且能被其它类订阅
 
 `ObservableType` protocol: 一个 `Observable` 可以发出三种事件, observers 接收的也是三种事件
 
 - **A `next` event**: An event which “carries” the latest (or "next") data value. This is the way observers “receive” values.
 - **A `completed` event**: This event terminates the event sequence with success. It means the Observable completed its life-cycle successfully and won’t emit any other events.
 - **A `error` event**: The Observable terminates with an error and it will not emit other events.
 
 */
import RxSwift
/*:
 ### Create observables
 */

example(of: "never") {
    let disposeBag = DisposeBag()
    let neverSequence = Observable<String>.never()
    
    let neverSequenceSubscription = neverSequence
        .subscribe { _ in
            print("This will never be printed")
    }
    
    neverSequenceSubscription.disposed(by: disposeBag)
}

example(of: "empty") {
    let disposeBag = DisposeBag()
    
    Observable<Int>.empty()
        .subscribe { event in
            print(event)
        }
        .disposed(by: disposeBag)
}

example(of: "just") {
    let disposeBag = DisposeBag()
    
    Observable.just("🔴")
        .subscribe { event in
            print(event)
        }
        .disposed(by: disposeBag)
    
    Observable.just(["🔴", "🔴"])
        .subscribe { event in
            print(event)
        }
        .disposed(by: disposeBag)
}

example(of: "of") {
    let disposeBag = DisposeBag()
    
    Observable.of("🐶", "🐱", "🐭", "🐹")
        .subscribe(onNext: { element in
            print(element)
        })
        .disposed(by: disposeBag)
    
    print("------------------------")
    Observable.of("🐶", "🐱", "🐭", "🐹")
        .subscribe(
           onNext: {
                print($0)
        }, onError: {
            print("error: \($0)")
        }, onCompleted: {
            print("Completed")
        })
        .addDisposableTo(disposeBag)
    
    print("------------------------")
    Observable.of(["🐶", "🐱", "🐭", "🐹"])
        .subscribe(onNext: { element in
            print(element)
        })
        .disposed(by: disposeBag)
}

example(of: "from") {
    let disposeBag = DisposeBag()
    
    Observable.from(["🐶", "🐱", "🐭", "🐹"])
        .subscribe(onNext: { print($0) })
        .disposed(by: disposeBag)
    
}


example(of: "create") {
    let disposeBag = DisposeBag()
    let observable = Observable<String>.create({ observer in
        observer.onNext("kimi")
        observer.onCompleted()
        observer.onNext("?") // this will never be emitted
        return Disposables.create()
    })
    
    observable.subscribe(onNext: {
        print($0)
    }, onCompleted: {
        print("completed")
    }, onDisposed: {
        print("disposed")
    }).disposed(by: disposeBag)
    
}





