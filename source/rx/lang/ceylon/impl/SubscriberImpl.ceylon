import rx { Subscriber_=Subscriber }
import rx.lang.ceylon { Subscriber }

shared class SubscriberImpl<Element>(Subscriber_<Element> delegate) satisfies Subscriber<Element> {
	
	shared actual void onCompleted() {
		delegate.onCompleted();
	}
	
	shared actual void onError(Throwable error) {
		delegate.onError(error);
	}
	
	shared actual void onNext(Element element) {
		delegate.onNext(element);
	}
}