package  
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author tf
	 */
	public class LSys extends Sprite
	{
		
		protected var famount:Number = 1;
		protected var samount:Number = .34906585;
		protected var vamount:Number = 0;
		
		protected var cx:Number = 0;
		protected var cy:Number = 0;
		protected var sy:Array;
		protected var sx:Array;
		protected var sv:Array;
		
		protected var instructions:String = "X";
		protected var rules:Object = { 
						F: ["FF"],
						B: ["", "BB"],
						X: ["F[+X][-X]+FB", "F[+X]F[-X]+FB", "F[+X]X[-X]+F"]
		};
		
		public function LSys() 
		{
			sx = new Array()
			sy = new Array()
			sv = new Array();
			sv.push(0);
			grow(7)
		}
		
		protected function grow(amt:Number):void {
			
			graphics.lineStyle(amt + 1)
			vamount = 0
			cx = 0;
			cy = 0;
			
			var strlen:Number = instructions.length
			var newinst:String = "";
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
						if(perc > .5 && amt < 2) {
							graphics.beginFill(0x00FF00)
							graphics.drawCircle(cx, cy, 2)
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