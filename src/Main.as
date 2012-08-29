package 
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import LSys;
	
	/**
	 * ...
	 * @author tf
	 */
	public class Main extends Sprite 
	{
		
		protected var bg:Sprite;
		protected var l:LSys2;
		protected var trees:Sprite;
		
		public function Main():void 
		{
			
			bg = new Sprite();
			bg.graphics.beginFill(0x000022);
			bg.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			addChild(bg);
			
			trees = new Sprite();
			addChild(trees);
			
			l = new LSys2()
			l.x = 300
			l.y = 350
			trees.addChild(l)
		
			
			stage.addEventListener(MouseEvent.CLICK, onClick)
		}
		
		protected function onClick(e:MouseEvent):void {
			
			//scale down tre
			l.scaleX = l.scaleY = .5;
			l.alpha = .4;
			l.y -= Math.random() * 50;
			l.x = Math.random() * stage.stageWidth;
			
			//new tree
			l = new LSys2()
			l.x = 300
			l.y = 350
			trees.addChild(l)
		}
		
	}
	
}