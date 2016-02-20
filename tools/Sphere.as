package  tools{
	
	public class Sphere {
		
			public var loc:Vector.<Number> = new Vector.<Number>(3, true);
			public var radius:Number = 100;
			
		public function Sphere() {
			loc[2] = -50;
			trace ("Sphere: "+ loc + " r=" + radius);
		}

	}
	
}
