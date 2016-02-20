package  tools{
	
	public class Light {
			public var loc:Vector.<Number> = new Vector.<Number>(3, true);
			
		public function Light() {
			loc[0] = 100;
			loc[1] = 100;
			loc[2] = 0;
			trace("Light: "+loc);
		}

	}
	
}
