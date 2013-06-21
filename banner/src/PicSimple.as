package
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import fl.transitions.Blinds;
	import fl.transitions.Fade;
	import fl.transitions.Fly;
	import fl.transitions.Iris;
	import fl.transitions.Photo;
	import fl.transitions.PixelDissolve;
	import fl.transitions.Rotate;
	import fl.transitions.Squeeze;
	import fl.transitions.Transition;
	import fl.transitions.TransitionManager;
	import fl.transitions.Wipe;
	import fl.transitions.Zoom;
	import fl.transitions.easing.Elastic;
	import fl.transitions.easing.None;
	import fl.transitions.easing.Strong;

	/**
	 * 简体中文版 
	 * @author Gordon
	 */	
	[SWF(width="592", height="242", backgroundColor="#FFFFFF", frameRate="30")]
	public class PicSimple extends Sprite
	{
		[Embed(source="img/img0.jpg")]
		private var img1:Class;
		
		[Embed(source="img/img1.jpg")]
		private var img2:Class;
		
		[Embed(source="img/img2.jpg")]
		private var img3:Class;
		
		[Embed(source="img/img3.jpg")]
		private var img4:Class;
		
		/**定义数组存储27种图片切换参数,其中各特效具体参数还可直接在其中更改*/
		private var effect:Vector.<Object>;
		private var showID:uint;//特效类型代码
		private var _mc:Vector.<MovieClip>;
		private var mainLen:int;
		private var time:Number;
		private var identifier:uint;
		private var transition:Transition;
		
		public function PicSimple()
		{
			mainLen = 4;
			time = 2000;
			_mc = new Vector.<MovieClip>(mainLen);
			init();
			var numContainer:Sprite = new Sprite();
			//采用数组载入全部图片，注：直接全部载入比较耗内存，如要节约内存的话，可定义两个mc采用类似双缓冲法进行改写,不过在这里重点是写出flash中内置的全部图片切换特效，以后有时间再改进
			for (var i:uint = 0; i < mainLen; i++)
			{
				_mc[i] = new MovieClip();
				_mc[i].stop();
				_mc[i].buttonMode = true;
				addChild(_mc[i]);
				_mc[i].addEventListener(MouseEvent.CLICK,getURL);
				_mc[i].addChild(new this["img"+(i+1)]());
				_mc[i].cacheAsBitmap = true;
				
				var numMC:num = new num();
				numMC.gotoAndStop( i + 1 );
				numMC.x = i * numMC.width + 2;
				numMC.getChildAt(0).alpha = 0.2;
				numMC.tf.text = String(i+1);
				numMC.mouseChildren = false;
				numMC.buttonMode = true;
				numContainer.addChild(numMC);
			}
			
			start();
			
			addChild(numContainer);
			numContainer.y = stage.stageHeight - numContainer.height - 2;
			numContainer.x = stage.stageWidth - numContainer.width - 3;
			setChildIndex(numContainer, numChildren - 1);
			numContainer.addEventListener(MouseEvent.MOUSE_OUT,onOut);
			numContainer.addEventListener(MouseEvent.MOUSE_OVER,onOver);
			stage.addEventListener(MouseEvent.RIGHT_CLICK,function(e:MouseEvent):void{});
		}
		
		protected function onOver(e:MouseEvent):void
		{
			clearInterval(identifier);
			if (transition) 
			{
				transition.manager.removeAllTransitions();
			}
			setChildIndex(_mc[int(e.target.tf.text) - 1], numChildren - 2);
		}
		
		protected function onOut(e:MouseEvent):void
		{
			start();
		}
		private function getURL(e:MouseEvent):void
		{
			navigateToURL(new URLRequest("http://zl.qq.com"),"_blank");
		}
		protected function start():void
		{
			identifier = setInterval(showImage,time);
		}
		/**
		 *图片切换函数
		 */
		private function showImage():void
		{
			if (++showID == mainLen)
				showID = 0;
			
			transition = TransitionManager.start(_mc[showID], effect[Math.floor(Math.random()*effect.length)]);//随机特效将图片按顺序切换
			
			setChildIndex(_mc[showID], numChildren - 2);// 将下一个要切换的 mc 置顶
		}
		private function init():void
		{
			effect=new Vector.<Object>(27);
			
			//遮帘(纵向、横向)
			effect[0]={type:Blinds,direction:Transition.IN,duration:2,easing:None.easeNone,numStrips:20,dimension:0};
			effect[1]={type:Blinds,direction:Transition.IN,duration:2,easing:None.easeNone,numStrips:20,dimension:1};
			
			//淡化过渡（淡入、淡出）
			effect[2]={type:Fade,direction:Transition.IN,duration:3,easing:None.easeNone};
			effect[3]={type:Fade,direction:Transition.OUT,duration:3,easing:None.easeNone};
			
			//飞行过渡（九个不同的方向)
			effect[4]={type:Fly,direction:Transition.IN,duration:3,easing:Elastic.easeOut,startPoint:1};
			effect[5]={type:Fly,direction:Transition.IN,duration:3,easing:Elastic.easeOut,startPoint:2};
			effect[6]={type:Fly,direction:Transition.IN,duration:3,easing:Elastic.easeOut,startPoint:3};
			effect[7]={type:Fly,direction:Transition.IN,duration:3,easing:Elastic.easeOut,startPoint:4};
			effect[8]={type:Fly,direction:Transition.IN,duration:3,easing:Elastic.easeOut,startPoint:5};
			effect[9]={type:Fly,direction:Transition.IN,duration:3,easing:Elastic.easeOut,startPoint:6};
			effect[10]={type:Fly,direction:Transition.IN,duration:3,easing:Elastic.easeOut,startPoint:7};
			effect[11]={type:Fly,direction:Transition.IN,duration:3,easing:Elastic.easeOut,startPoint:8};
			effect[12]={type:Fly,direction:Transition.IN,duration:3,easing:Elastic.easeOut,startPoint:9};
			
			//光圈过渡
			effect[13]={type:Iris,direction:Transition.IN,duration:2,easing:Strong.easeOut,startPoint:5,shape:Iris.CIRCLE};
			
			//渐变暴光
			effect[14]={type:Photo,direction:Transition.IN,duration:1,easing:None.easeNone};
			
			//像素溶解
			effect[15]={type:PixelDissolve,direction:Transition.IN,duration:2,easing:None.easeNone,xSections:50,ySections:50};
			
			//旋转过渡
			effect[16]={type:Rotate,direction:Transition.IN,duration:3,easing:Strong.easeInOut,ccw:false,degrees:360};
			
			//挤压过渡(二个方向)
			effect[17]={type:Squeeze,direction:Transition.IN,duration:2,easing:Elastic.easeOut,dimension:1};
			effect[18]={type:Squeeze,direction:Transition.IN,duration:2,easing:Elastic.easeOut,dimension:2};
			
			//划入划出过渡--左上，1；上中，2；右上，3；左中，4；右中，6；左下，7；下中，8；右下，9
			effect[19]={type:Wipe,direction:Transition.IN,duration:2,easing:None.easeNone,startPoint:1};
			effect[20]={type:Wipe,direction:Transition.IN,duration:2,easing:None.easeNone,startPoint:2};
			effect[21]={type:Wipe,direction:Transition.IN,duration:2,easing:None.easeNone,startPoint:3};
			effect[22]={type:Wipe,direction:Transition.IN,duration:2,easing:None.easeNone,startPoint:4};
			effect[23]={type:Wipe,direction:Transition.IN,duration:2,easing:None.easeNone,startPoint:6};
			effect[24]={type:Wipe,direction:Transition.IN,duration:2,easing:None.easeNone,startPoint:7};
			effect[25]={type:Wipe,direction:Transition.IN,duration:2,easing:None.easeNone,startPoint:8};
			effect[26]={type:Wipe,direction:Transition.IN,duration:2,easing:None.easeNone,startPoint:9};
			
			//弹性缩放
			effect[27]={type:Zoom,direction:Transition.IN,duration:2,easing:Elastic.easeOut};
		}
	}
}