enum IrohaOrderKind {
	EAT_IN,
	TAKE_OUT
}

extension IrohaOrderKindEx on IrohaOrderKind {
	String get() {
		switch (this) {
			case IrohaOrderKind.EAT_IN:
				return "eat-in";
			case IrohaOrderKind.TAKE_OUT:
				return "take-out";
		}
	}
}
