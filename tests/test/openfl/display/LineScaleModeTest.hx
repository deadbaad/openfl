package openfl.display;


class LineScaleModeTest {
	
	
	@Test public function test () {
		
		switch (LineScaleMode.VERTICAL) {
			
			case LineScaleMode.HORIZONTAL, LineScaleMode.NONE, LineScaleMode.NORMAL, LineScaleMode.VERTICAL:
			
			//TODO: Add fake LineScaleMode.OPENGL value for Flash?
			#if ((cpp || neko) && !next)
			case LineScaleMode.OPENGL:
			#end
			
		}
		
	}
	
	
}