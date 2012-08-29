package  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.filters.BlurFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Point;
	import com.gskinner.geom.ColorMatrix;
	/**
	 * ...
	 * @author tf
	 */
	public class LSys2 extends Sprite
	{
		
		protected var bitmap:Bitmap;
		protected var bdat:BitmapData;
		
		protected var famount:Number = 14;
		protected var samount:Number = .34906585;
		protected var vamount:Number = 0;
		
		protected var cx:Number = 0;
		protected var cy:Number = 0;
		protected var sy:Array;
		protected var sx:Array;
		protected var sv:Array;
		
		protected var instructions:String = "FFX";
		protected var rules:Object = { 
						F: ["F", "FB"],
						B: ["B", ""],
						X: ["[+X][-X]+FB", "B[+X]F[-X]+FB", "FB[+X]X[-X]+F"]
		};
		
		public function LSys2() 
		{
			sx = new Array()
			sy = new Array()
			sv = new Array();
			sv.push(0);
			grow(6)
		}
		
		protected function grow(amt:Number):void {
			
			var nifty:String = String((12 - amt) * 5) + String((12 - amt) * 5)
			var nifty2:String = String((12-amt)*3) + String((12-amt)*3)
			var colo:uint = uint( "0x" + nifty + nifty2 + "00" )
			graphics.lineStyle(amt, colo)
			vamount = 0
			cx = 0;
			cy = 0;
			
			var strlen:Number = instructions.length
			var newinst:String = "";
			var forwardPercentage:Number = famount;
			
			for (var i:Number = 0; i < strlen; i ++) {
				
				//if (instructions.charAt(i - 1) != "-" && instructions.charAt(i - 1) != "+")  vamount = 0;
				var perc:Number = i / strlen;
				
				switch(instructions.charAt(i)) {
					case "F":
						graphics.moveTo(cx, cy)
						cx = cx + (famount * Math.sin(vamount))
						cy = cy - (famount * Math.cos(vamount))
						graphics.lineTo(cx, cy)
						break;
					case "B":
						if(perc > .3 && amt < 3) {
							graphics.beginFill(0x00FF00, .6)
							graphics.drawCircle(cx, cy, (3-amt)*1.2)
						}
						break;
					case "-":
						vamount += samount;
						if (instructions.charAt(i - 1) == "[") sv.push(vamount);
						break;
					case "+":
						vamount += -samount;
						if (instructions.charAt(i - 1) == "[")	sv.push(vamount);
						break;
					case "[":
						sx.push(cx);
						sy.push(cy);
						break;
					case "]":
						cx = sx.pop();
						cy = sy.pop();
						
						if(sv.length > 1) {
							vamount = sv.pop();
							vamount = sv[sv.length - 1];
						} else {
							vamount = 0
						}
						break;
					default:
						break;
				}
				
				//make new instructions
				if (rules[instructions.charAt(i)]) {
					var rnd:Number = Math.floor(Math.random() * (rules[instructions.charAt(i)].length ))
					var addrule:String = rules[instructions.charAt(i)][rnd]
					
					if (addrule) newinst += addrule;
					else newinst += instructions.charAt(i);
				} else {
					newinst += instructions.charAt(i);
				}
			}
			
				if (bitmap) removeChild(bitmap)
				bdat = new BitmapData(this.width + 1, this.height + 1, true, 0x00000000)
				var blur:BlurFilter = new BlurFilter(amt * 2, amt * 2)
				//this.filters = [blur];
				bdat.draw(this)
				bitmap = new Bitmap(bdat)
				addChild(bitmap)
				
			if (amt <= 0) return;
			else {
				/*
				for (var m:String in rules) {
					var reg:RegExp = new RegExp(m, "g")
					instructions = instructions.replace(reg, rules[m])
				}
				*/
				instructions = newinst
				//trace(instructions)
				
				grow(amt - 1)
			}
		}
		
	}

}