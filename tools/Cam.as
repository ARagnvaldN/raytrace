package tools{
	
	public class Cam {
		
		public var loc:Vector.<Number> = new Vector.<Number>(3, true);
		public var dir:Vector.<Number> = new Vector.<Number>(3, true);
		
		public function Cam() {
			
			loc[2] = 100;
			dir[2] = 1;
			trace ("Camera: "+dir +" "+ loc);
		}

	}
	
}
