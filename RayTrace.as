package  {
	
	import flash.display.MovieClip;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.events.Event;
	
	import tools.Cam;
	import tools.Sphere;
	import tools.Light;
	
	
	
	public class RayTrace extends MovieClip {
		
		const HEIGHT:int = 400;
		const WIDTH:int = 550;
		
		public function RayTrace() {
			var MyCam:Cam = new Cam();
			var MySphere:Sphere = new Sphere();
			var MyLight:Light = new Light();
			
			stage.quality = "low";
			
			render();
			
				function render(){
					
					var view:BitmapData = new BitmapData(WIDTH, HEIGHT, false, 0xFF000000);
				
					for(var i:int=0;i<WIDTH;i++){
						for(var j:int=0;j<HEIGHT;j++){
							var r:Vector.<Number> = new Vector.<Number>();
							r[0] = 200-j;
							r[1] = 275-i;
							r[2] = -MyCam.loc[2];
							
							if(intersect() == "high"){
								view.setPixel(i, j, 0xFF0000);
							}else if (intersect() == "low"){
								view.setPixel(i,j, 0xBB0000);
							}else {
								//Colour in backdrop
							}
				
						}
					}
			
					var bmp:Bitmap = new Bitmap(view);
					addChild(bmp);
					
				
				
				function intersect() {
				
				//Get length of vector from cam to sphere
				var c:Vector.<Number> = createVector(MyCam.loc, MySphere.loc);
				
				//trace(c);
				//trace(r);
				
				//Find the scalar of the projection of c on r
				//Apply scalar on r
				//Calculate length of the projection on r
				
				var scalarV:Number = dotProduct(c, r) / dotProduct(r, r);
				var projConR:Vector.<Number> = scalarProduct(r, scalarV);
				
				var rLength:int = lengthOf(projConR);
				
				var disc = Math.pow(MySphere.radius,2) - (dotProduct(c, c) - Math.pow(rLength,2));
				
				
				if(disc < 0){
					//No intersection
					return false;
					
				}else{
					var d:Number = Math.sqrt(disc);
					var unitV = unitVector(r);
					
					//if(Math.random() <.1)trace(d);
					
					var p:Vector.<Number> = copyVector(MyCam.loc);
					for(var i:int=0;i<3;i++){
						p[i] += (rLength-d)* unitV[i];
					}
					var sphereNormal:Vector.<Number> = createVector(MySphere.loc, p);
					var lightVector:Vector.<Number> = createVector(MyLight.loc, p);
					var angle:Number = dotProduct(unitVector(sphereNormal), unitVector(lightVector));
					
					if(angle < .5)return "high";
					else return "low";
					
				}
				
				}
				
			}
		
		}
		
		public function dotProduct(v1:Vector.<Number>, v2:Vector.<Number>) {
			var product:Number = 0;
			for(var i:int=0;i<3;i++) {
				product += v1[i] * v2[i];
			}
			return product;
		}
		public function scalarProduct(v1:Vector.<Number>, scalar:Number) {
			var vector:Vector.<Number> = new Vector.<Number>(3,true);
			for(var i:int=0;i<3;i++) {
				vector[i] = v1[i] * scalar;
			}
			return vector;
		}
		public function lengthFrom(v1:Vector.<Number>, v2:Vector.<Number>) {
			var sum:int;
			var vector:Vector.<Number> = new Vector.<Number>(3,true);
			for(var i:int=0;i<3;i++) {
				vector[i] = v2[i] - v1[i];
			}
			sum = Math.sqrt(Math.pow(vector[0],2) + Math.pow(vector[1],2) + Math.pow(vector[2],2));
			return sum;
		}
		public function lengthOf(vector:Vector.<Number>) {
			var sum:int;
			sum = Math.sqrt(Math.pow(vector[0],2) + Math.pow(vector[1],2) + Math.pow(vector[2],2));
			return sum;
		}
		public function createVector(v1:Vector.<Number>, v2:Vector.<Number>) {
			var vector:Vector.<Number> = new Vector.<Number>(3,true);
			for(var i:int=0;i<3;i++) {
				vector[i] = v2[i] - v1[i];
			}
			return vector;
		}
		public function copyVector(v1:Vector.<Number>) {
			var v:Vector.<Number> = new Vector.<Number>(3,true);
			for(var i:int=0;i<3;i++) {
				v[i] = v1[i];
			}
			return v;
		}
		public function unitVector(v1:Vector.<Number>){
			var uV:Vector.<Number> = new Vector.<Number>(3,true);
			var u:Number = lengthOf(v1);
			for(var i:int=0;i<3;i++){
				uV[i] = v1[i] / u;
			}
			return uV;
		}
			
	}
}
