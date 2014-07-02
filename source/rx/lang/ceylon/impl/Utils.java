package rx.lang.ceylon.impl;

public class Utils {

	@SuppressWarnings("unchecked")
	public static final <Element> rx.Observable<Element> foo(
			final rx.functions.Action1<rx.Subscriber<Element>> f) {
		rx.Observable observable = rx.Observable.create(new rx.Observable.OnSubscribe() {
			@Override
			public void call(Object arg0) {
				rx.Subscriber<Element> delegate = (rx.Subscriber<Element>) arg0;
				f.call(delegate);;
			}
		});
		return observable;
	}
	
}
