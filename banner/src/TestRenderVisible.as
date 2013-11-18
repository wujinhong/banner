package
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.utils.getTimer;
	import flash.utils.setInterval;
	
	/**
	 * 繁体版 
	 * @author Gordon
	 */
	[SWF(width="300", height="200", backgroundColor="#000000", frameRate="30")]
	public class TestRenderVisible extends Sprite
	{
		[Embed(source="img/2.png")]
		private var img1:Class;
		
		private var _bm:Bitmap;
		private var mainLen:int;
		private var time:Number;
		
		public function TestRenderVisible()
		{
			mainLen = 4;
			time = 200;
			_bm = new img1();
			addChild(_bm );
			_bm.width = 100;
			_bm.height = 100;
			renderVisible();
			
			testIntUintNumber();
		}
		
		private function testIntUintNumber():void
		{
			var begin:int = getTimer();
			var end:int;
			
			var int1:int = 9;
			var int2:int = 9;
			var l:uint = 1500000;
			begin = getTimer();
			while( --l > 0 )
			{
				int1 += int2 - int1 / 2;
			}
			end = getTimer();
			trace( "int......耗时：",  end - begin );
			
			var uint1:uint = 9;
			var uint2:uint = 9;
			l = 1500000;
			begin = getTimer();
			while( --l > 0 )
			{
				uint1 += uint2 - uint1 / 2;
			}
			end = getTimer();
			trace( "uint......耗时：",  end - begin );
			
			var num1:Number = 9;
			var num2:Number = 9;
			l = 1500000;
			begin = getTimer();
			while( --l > 0 )
			{
				num1 += num2 - num1 / 2;
			}
			end = getTimer();
			trace( "Number......耗时：",  end - begin );
		}
		/**
		 *测试visible不可见是否有进行渲染 
		 */
		private function renderVisible():void
		{
			_bm.visible = false;
			_bm.x = 150;
			_bm.y = 150;
			
			setInterval( showImage, time );
		}
		/**
		 *图片切换函数
		 */
		private function showImage():void
		{
			if ( _bm.x >= 200 )
			{
				_bm.x = 0;
			}
			else
			{
				_bm.x += 10;
			}
		}
	}
}