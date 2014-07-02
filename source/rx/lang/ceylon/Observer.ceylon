shared interface Observer<in Element> {
	
	shared default void onCompleted() {}
	
	shared default void onError(Throwable error) {}
	
	shared default void onNext(Element element) {}
	
}