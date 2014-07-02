import java.lang { Boolean_=Boolean }
import rx.functions { Func1_=Func1 }
import rx { Observer_=Observer, Observable_=Observable }
import rx.lang.ceylon { Observer, Observable, Subscription }
shared class ObservableImpl<Element>(Observable_<Element> delegate) satisfies Observable<Element> {
	
	shared actual Observable<Result> map<Result>(Result func(Element element)) {
		
		object f satisfies Func1_<Element, Result> {
			shared actual Result call(Element? t1) {
				assert(exists t1);
				return func(t1);
			}
		}
		
		Observable_<Result> b = delegate.map(f);
		
		return ObservableImpl<Result>(b);
	}
	
	shared actual Subscription subscribe(Observer<Element> observer) {
		
		object impl satisfies Observer_<Element> {
			shared actual void onCompleted() {
				observer.onCompleted();
			}
			shared actual void onError(Throwable? throwable) {
				assert(exists throwable);
				observer.onError(throwable);
			}
			
			shared actual void onNext(Element? t) {
				assert(exists t);
				observer.onNext(t);
			}
		}
		
		value a = delegate.subscribe(impl);
		
		object sub satisfies Subscription {
			shared actual void unsubscribe() {
				a.unsubscribe();
			}
			
			shared actual Boolean unsubscribed => a.unsubscribed;
		}
		
		return sub;
	}
	
	shared actual Observable<Element> filter(Boolean predicate(Element element)) {
		object wrapper satisfies Func1_<Element, Boolean_> {
			shared actual Boolean_ call(Element? t1) {
				assert(exists t1);
				if (predicate(t1)) {
					return Boolean_.\iTRUE;
				} else {
					return Boolean_.\iFALSE;
				}
			}
		}
		Observable_<Element> filtered = delegate.filter(wrapper);
		return ObservableImpl(filtered);
	}
}
