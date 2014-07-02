"Run the module `rx.lang.ceylon`."
shared void run() {
    
    value obs = observable.from([1,2,3]).filter((Integer element) => element > 1);
    object o satisfies Observer<Integer> {
        shared actual void onNext(Integer s) {
            print("Got integer ``s``");
        }
        shared actual void onCompleted() {
            print("done");
        }
    }
    object o2 satisfies Observer<Object> {
        shared actual void onNext(Object s) {
            print("Got object ``s``");
        }
        shared actual void onCompleted() {
            print("done");
        }
    }
    object o3 satisfies Observer<String> {
        shared actual void onNext(String s) {
            print("Got string ``s``");
        }
        shared actual void onCompleted() {
            print("done");
        }
    }
    obs.subscribe(o);
    obs.subscribe(o2);
    Observable<Object> obs2 = obs;
    obs2.subscribe(o2);
    
    Observable<String> obs3 = obs.map((Integer element) => element.string);
    obs3.subscribe(o3);
    
    //
    Observable<String> neow = observable.create<String>(void (Subscriber<String> subscriber) {
        subscriber.onNext("foo");
        subscriber.onNext("bar");
        subscriber.onNext("juu");
        subscriber.onCompleted();
    });
    neow.subscribe(o3);
    
    
}