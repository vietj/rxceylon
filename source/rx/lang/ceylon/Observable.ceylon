import rx {
	Observable_=Observable {
		from_=from,
		range_=range
	},
	Subscriber_=Subscriber 
}
import rx.lang.ceylon.impl { ObservableImpl, Utils, SubscriberImpl }
import rx.functions { Action1_=Action1 }
import java.lang { Iterable_=Iterable, UnsupportedOperationException_=UnsupportedOperationException, Integer_=Integer }
import java.util { Iterator_=Iterator, NoSuchElementException_=NoSuchElementException }

shared interface Observable<out Element> {
	
	shared formal Observable<Result> map<Result>(Result func(Element element));
	
	shared formal Subscription subscribe(Observer<Element> observer);
	
	shared formal Observable<Element> filter(Boolean predicate(Element element));
	
}

shared object observable {
	
	// Shall consider make a native implementation of this :-)
	shared Observable<Integer> range(Range<Integer> range) {
		Observable_<Integer_> ranged = range_(range.first, range.last);
		return ObservableImpl<Integer_>(ranged).map((Integer_ element) => element.intValue());
	}
	

	shared Observable<Element> create<Element>(void onSubscribe(Subscriber<Element> subscriber)) {
		object action satisfies Action1_<Subscriber_<Element>> {
			shared actual void call(Subscriber_<Element>? t1) {
				assert(exists t1);
				SubscriberImpl<Element> subscriber = SubscriberImpl(t1);
				onSubscribe(subscriber);
			}
		}
		Observable_<Element> delegate = Utils.foo<Element>(action);
		return ObservableImpl<Element>(delegate);
	}
	
	shared Observable<Element> from<Element>(Iterable<Element> iterable) {
		object i satisfies Iterable_<Element> {
			shared actual Iterator_<Element> iterator() {
				value bilto = iterable.iterator();
				object it satisfies Iterator_<Element> {
					variable Element|Finished current = bilto.next();
					shared actual Boolean hasNext() => !(current is Finished);
					shared actual Element next() {
						if (is Element ret = current) {
							current = bilto.next();
							return ret;
						} else {
							throw NoSuchElementException_();
						}
					}
					shared actual void remove() {
						throw UnsupportedOperationException_();
					}
				}
				return it;
			}
		}
		Observable_<Element> e = from_<Element>(i);
		return ObservableImpl<Element>(e);
	}
	
}