using System;

namespace BeefLibrary;

class TestClass
{
	public int32 testVal;

	public int32 InstanceTestFunc()
	{
		return testVal;
	}

	[Export, LinkName("LinkTestFunc")]
	public static int32 LinkTestFunc()
	{
		var test = scope TestClass();
		test.testVal = 4201337;
		return test.InstanceTestFunc();
	}
}