package
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
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
		}
		/**
		 *测试visible不可见是否有进行渲染 
		 */
		private function renderVisible():void
		{
			_bm.visible = false;
			_bm.x = 150;
			_bm.y = 150;
			
			setInterval(showImage,time);
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