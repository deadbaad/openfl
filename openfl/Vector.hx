package openfl; #if (!flash || display)


import haxe.Constraints.Function;
import lime.utils.Float32Array;
import openfl.utils.ByteArray;

@:multiType(T)


abstract Vector<T>(AbstractVector<T>) from AbstractVector<T> {
	
	
	public var fixed (get, set):Bool;
	public var length (get, set):Int;
	
	
	public function new (?length:Int, ?fixed:Bool, ?array:Array<T>):Void;
	
	
	public inline function concat (?a:Vector<T>):Vector<T> {
		
		var data:IVector<T> = cast (a != null ? (a:AbstractVector<T>).data : null);
		return cast new AbstractVector<T> (this.data.concat (data));
		
	}
	
	
	public inline function copy ():Vector<T> {
		
		return cast new AbstractVector<T> (this.data.copy ());
		
	}
	
	
	@:arrayAccess public inline function get (index:Int):T {
		
		return this.data.get (index);
		
	}
	
	
	public inline function indexOf (x:T, ?from:Int = 0):Int {
		
		return this.data.indexOf (x, from);
		
	}
	
	
	public inline function insertAt (index:Int, element:T):Void {
		
		this.data.insertAt (index, element);
		
	}
	
	
	public inline function iterator<T> ():Iterator<T> {
		
		return this.data.iterator ();
		
	}
	
	
	public inline function join (sep:String = ","):String {
		
		return this.data.join (sep);
		
	}
	
	
	public inline function lastIndexOf (x:T, ?from:Int = 0):Int {
		
		return this.data.lastIndexOf (x, from);
		
	}
	
	
	public inline function pop ():Null<T> {
		
		return this.data.pop ();
		
	}
	
	
	public inline function push (x:T):Int {
		
		return this.data.push (x);
		
	}
	
	
	public inline function removeAt (index:Int):T {
		
		return this.data.removeAt (index);
		
	}
	
	
	public inline function reverse ():Vector<T> {
		
		return cast new AbstractVector<T> (this.data.reverse ());
		
	}
	
	
	@:arrayAccess public inline function set (index:Int, value:T):T {
		
		return this.data.set (index, value);
		
	}
	
	
	public inline function shift ():Null<T> {
		
		return this.data.shift ();
		
	}
	
	
	public inline function slice (?pos:Int, ?end:Int):Vector<T> {
		
		return cast new AbstractVector<T> (this.data.slice (pos, end));
		
	}
	
	
	public inline function sort (f:T->T->Int):Void {
		
		this.data.sort (f);
		
	}
	
	
	public inline function splice (pos:Int, len:Int):Vector<T> {
		
		return cast new AbstractVector<T> (this.data.splice (pos, len));
		
	}
	
	
	public inline function toString ():String {
		
		return (this != null && this.data != null) ? this.data.toString () : null;
		
	}
	
	
	public inline function unshift (x:T):Void {
		
		this.data.unshift (x);
		
	}
	
	
	public inline static function ofArray<T> (a:Array<T>):Vector<T> {
		
		var vector = new Vector<T> ();
		
		for (i in 0...a.length) {
			
			vector[i] = cast a[i];
			
		}
		
		return vector;
		
	}
	
	
	public inline static function convert<T,U> (v:AbstractVector<T>):AbstractVector<U> {
		
		return cast v;
		
	}
	
	
	@:to static #if (!js && !flash) inline #end function toBoolVector<T:Bool> (t:AbstractVector<T>, length:Int, fixed:Bool, array:Array<T>):AbstractVector<T> {
		
		return new AbstractVector<T> (cast new BoolVector (length, fixed), array);
		
	}
	
	
	@:to static #if (!js && !flash) inline #end function toIntVector<T:Int> (t:AbstractVector<T>, length:Int, fixed:Bool, array:Array<T>):AbstractVector<T> {
		
		return new AbstractVector<T> (cast new IntVector (length, fixed), array);
		
	}
	
	
	@:to static #if (!js && !flash) inline #end function toFloatVector<T:Float> (t:AbstractVector<T>, length:Int, fixed:Bool, array:Array<T>):AbstractVector<T> {
		
		//return new AbstractVector<T> (cast new FloatVector (length, fixed), array);
		return new AbstractVector<T> (cast new Float32ArrayVector (length, fixed), array);
		
	}
	
	
	#if !cs
	@:to static #if (!js && !flash) inline #end function toFunctionVector<T:Function> (t:AbstractVector<T>, length:Int, fixed:Bool, array:Array<T>):AbstractVector<T> {
		
		return new AbstractVector<T> (cast new FunctionVector (length, fixed), array);
		
	}
	#end
	
	
	@:to static #if (!js && !flash) inline #end function toObjectVector<T> (t:AbstractVector<T>, length:Int, fixed:Bool, array:Array<T>):AbstractVector<T> {
		
		return cast new AbstractVector<T> (cast new ObjectVector<T> (length, fixed), array);
		
	}
	
	
	
	
	// Getters & Setters
	
	
	
	
	@:noCompletion private inline function get_fixed ():Bool {
		
		return this.data.fixed;
		
	}
	
	
	@:noCompletion private inline function set_fixed (value:Bool):Bool {
		
		return this.data.fixed = value;
		
	}
	
	
	@:noCompletion private inline function get_length ():Int {
		
		return this.data.length;
		
	}
	
	
	@:noCompletion private inline function set_length (value:Int):Int {
		
		return this.data.length = value;
		
	}
	
	
}




#if !openfl_debug
@:fileXml('tags="haxe,release"')
@:noDebug
#end


// Wrap sub-types in a common wrapper to allow
// for Vector<T> to Vector<Dynamic> conversion
// while retaining the underlying type

@:dox(hide) private class AbstractVector<T> {
	
	
	public var data:IVector<T>;
	
	
	public function new (data:IVector<T>, ?array:Array<T>) {
		
		this.data = data;
		
		if (array != null) {
			
			var cacheFixed = data.fixed;
			data.fixed = false;
			
			for (i in 0...array.length) {
				
				data.set (i, cast array[i]);
				
			}
			
			data.fixed = cacheFixed;
			
		}
		
	}
	
	
	@:noCompletion @:keep private function toJSON () {
		
		return @:privateAccess data.toJSON ();
		
	}
	
	
}




#if !openfl_debug
@:fileXml('tags="haxe,release"')
@:noDebug
#end


@:dox(hide) private class BoolVector implements IVector<Bool> {
	
	
	public var fixed:Bool;
	public var length (get, set):Int;
	
	private var __array:Array<Bool>;
	
	
	public function new (?length:Int, ?fixed:Bool, ?array:Array<Bool>):Void {
		
		if (array == null) {
			
			array = new Array<Bool> ();
			
		}
		
		__array = array;
		
		if (length != null) {
			
			this.length = length;
			
		}
		
		this.fixed = (fixed == true);
		
	}
	
	
	public function concat (?a:IVector<Bool>):IVector<Bool> {
		
		if (a == null) {
			
			return new BoolVector (__array.copy ());
			
		} else {
			
			return new BoolVector (__array.concat (cast (a, BoolVector).__array));
			
		}
		
	}
	
	
	public function copy ():IVector<Bool> {
		
		return new BoolVector (fixed, __array.copy ());
		
	}
	
	
	public function get (index:Int):Bool {
		
		if (index >= __array.length) {
			
			return false;
			
		} else {
			
			return __array[index];
			
		}
		
	}
	
	
	public function indexOf (x:Bool, ?from:Int = 0):Int {
		
		for (i in from...__array.length) {
			
			if (__array[i] == x) {
				
				return i;
				
			}
			
		}
		
		return -1;
		
	}
	
	
	public function insertAt (index:Int, element:Bool):Void {
		
		if (!fixed || index < __array.length) {
			
			__array.insert (index, element);
			
		}
		
	}
	
	
	public function iterator<Bool> ():Iterator<Bool> {
		
		return cast __array.iterator ();
		
	}
	
	
	public function join (sep:String = ","):String {
		
		return __array.join (sep);
		
	}
	
	
	public function lastIndexOf (x:Bool, ?from:Int = 0):Int {
		
		var i = __array.length - 1;
		
		while (i >= from) {
			
			if (__array[i] == x) return i;
			i--;
			
		}
		
		return -1;
		
	}
	
	
	public function pop ():Null<Bool> {
		
		if (!fixed) {
			
			return __array.pop ();
			
		} else {
			
			return null;
			
		}
		
	}
	
	
	public function push (x:Bool):Int {
		
		if (!fixed) {
			
			return __array.push (x);
			
		} else {
			
			return __array.length;
			
		}
		
	}
	
	
	public function removeAt (index:Int):Bool {
		
		if (!fixed || index < __array.length) {
			
			return __array.splice (index, 1)[0];
			
		}
		
		return false;
		
	}
	
	
	public function reverse ():IVector<Bool> {
		
		__array.reverse ();
		return this;
		
	}
	
	
	public function set (index:Int, value:Bool):Bool {
		
		if (!fixed || index < __array.length) {
			
			return __array[index] = value;
			
		} else {
			
			return value;
			
		}
		
	}
	
	
	public function shift ():Null<Bool> {
		
		if (!fixed) {
			
			return __array.shift ();
			
		} else {
			
			return null;
			
		}
		
	}
	
	
	public function slice (?startIndex:Int = 0, ?endIndex:Int = 16777215):IVector<Bool> {
		
		return new BoolVector (__array.slice (startIndex, endIndex));
		
	}
	
	
	public function sort (f:Bool->Bool->Int):Void {
		
		__array.sort (f);
		
	}
	
	
	public function splice (pos:Int, len:Int):IVector<Bool> {
		
		return new BoolVector (__array.splice (pos, len));
		
	}
	
	
	@:noCompletion @:keep private function toJSON () {
		
		return __array;
		
	}
	
	
	public function toString ():String {
		
		return __array != null ? __array.toString () : null;
		
	}
	
	
	public function unshift (x:Bool):Void {
		
		if (!fixed) {
			
			__array.unshift (x);
			
		}
		
	}
	
	
	
	
	// Getters & Setters
	
	
	
	
	@:noCompletion private function get_length ():Int {
		
		return __array.length;
		
	}
	
	
	@:noCompletion private function set_length (value:Int):Int {
		
		if (!fixed) {
			
			#if cpp
			
			cpp.NativeArray.setSize (__array, value);
			
			#else
			
			var currentLength = __array.length;
			if (value < 0) value = 0;
			
			if (value > currentLength) {
				
				for (i in currentLength...value) {
					
					__array[i] = false;
					
				}
				
			} else {
				
				while (__array.length > value) {
					
					__array.pop ();
					
				}
				
			}
			
			#end
			
		}
		
		return __array.length;
		
	}
	
	
}




#if !openfl_debug
@:fileXml('tags="haxe,release"')
@:noDebug
#end


@:dox(hide) private class FloatVector implements IVector<Float> {
	
	
	public var fixed:Bool;
	public var length (get, set):Int;
	
	private var __array:Array<Float>;
	
	
	public function new (?length:Int, ?fixed:Bool, ?array:Array<Float>):Void {
		
		if (array == null) {
			
			array = new Array<Float> ();
			
		}
		
		__array = array;
		
		if (length != null) {
			
			this.length = length;
			
		}
		
		this.fixed = (fixed == true);
		
	}
	
	
	public function concat (?a:IVector<Float>):IVector<Float> {
		
		if (a == null) {
			
			return new FloatVector (__array.copy ());
			
		} else {
			
			return new FloatVector (__array.concat (cast (a, FloatVector).__array));
			
		}
		
	}
	
	
	public function copy ():IVector<Float> {
		
		return new FloatVector (fixed, __array.copy ());
		
	}
	
	
	public function get (index:Int):Float {
		
		return __array[index];
		
	}
	
	
	public function indexOf (x:Float, ?from:Int = 0):Int {
		
		for (i in from...__array.length) {
			
			if (__array[i] == x) {
				
				return i;
				
			}
			
		}
		
		return -1;
		
	}
	
	
	public function insertAt (index:Int, element:Float):Void {
		
		if (!fixed || index < __array.length) {
			
			__array.insert (index, element);
			
		}
		
	}
	
	
	public function iterator<Float> ():Iterator<Float> {
		
		return cast __array.iterator ();
		
	}
	
	
	public function join (sep:String = ","):String {
		
		return __array.join (sep);
		
	}
	
	
	public function lastIndexOf (x:Float, ?from:Int = 0):Int {
		
		var i = __array.length - 1;
		
		while (i >= from) {
			
			if (__array[i] == x) return i;
			i--;
			
		}
		
		return -1;
		
	}
	
	
	public function pop ():Null<Float> {
		
		if (!fixed) {
			
			return __array.pop ();
			
		} else {
			
			return null;
			
		}
		
	}
	
	
	public function push (x:Float):Int {
		
		if (!fixed) {
			
			return __array.push (x);
			
		} else {
			
			return __array.length;
			
		}
		
	}
	
	
	public function removeAt (index:Int):Float {
		
		if (!fixed || index < __array.length) {
			
			return __array.splice (index, 1)[0];
			
		}
		
		return 0;
		
	}
	
	
	public function reverse ():IVector<Float> {
		
		__array.reverse ();
		return this;
		
	}
	
	
	public function set (index:Int, value:Float):Float {
		
		if (!fixed || index < __array.length) {
			
			return __array[index] = value;
			
		} else {
			
			return value;
			
		}
		
	}
	
	
	public function shift ():Null<Float> {
		
		if (!fixed) {
			
			return __array.shift ();
			
		} else {
			
			return null;
			
		}
		
	}
	
	
	public function slice (?startIndex:Int = 0, ?endIndex:Int = 16777215):IVector<Float> {
		
		return new FloatVector (__array.slice (startIndex, endIndex));
		
	}
	
	
	public function sort (f:Float->Float->Int):Void {
		
		__array.sort (f);
		
	}
	
	
	public function splice (pos:Int, len:Int):IVector<Float> {
		
		return new FloatVector (__array.splice (pos, len));
		
	}
	
	
	@:noCompletion @:keep private function toJSON () {
		
		return __array;
		
	}
	
	
	public function toString ():String {
		
		return __array != null ? __array.toString () : null;
		
	}
	
	
	public function unshift (x:Float):Void {
		
		if (!fixed) {
			
			__array.unshift (x);
			
		}
		
	}
	
	
	
	
	// Getters & Setters
	
	
	
	
	@:noCompletion private function get_length ():Int {
		
		return __array.length;
		
	}
	
	
	@:noCompletion private function set_length (value:Int):Int {
		
		if (!fixed) {
			
			#if cpp
			
			cpp.NativeArray.setSize (__array, value);
			
			#else
			
			var currentLength = __array.length;
			if (value < 0) value = 0;
			
			if (value > currentLength) {
				
				for (i in currentLength...value) {
					
					__array[i] = 0;
					
				}
				
			} else {
				
				while (__array.length > value) {
					
					__array.pop ();
					
				}
				
			}
			
			#end
			
		}
		
		return __array.length;
		
	}
	
	
}




#if !cs
#if !openfl_debug
@:fileXml('tags="haxe,release"')
@:noDebug
#end


@:dox(hide) private class FunctionVector implements IVector<Function> {
	
	
	public var fixed:Bool;
	public var length (get, set):Int;
	
	private var __array:Array<Function>;
	
	
	public function new (?length:Int, ?fixed:Bool, ?array:Array<Function>):Void {
		
		if (array == null) {
			
			array = new Array<Function> ();
			
		}
		
		__array = array;
		
		if (length != null) {
			
			this.length = length;
			
		}
		
		this.fixed = (fixed == true);
		
	}
	
	
	public function concat (?a:IVector<Function>):IVector<Function> {
		
		if (a == null) {
			
			return new FunctionVector (__array.copy ());
			
		} else {
			
			return new FunctionVector (__array.concat (cast (a, FunctionVector).__array));
			
		}
		
	}
	
	
	public function copy ():IVector<Function> {
		
		return new FunctionVector (fixed, __array.copy ());
		
	}
	
	
	public function get (index:Int):Function {
		
		if (index >= __array.length) {
			
			return null;
			
		} else {
			
			return __array[index];
			
		}
		
	}
	
	
	public function indexOf (x:Function, ?from:Int = 0):Int {
		
		for (i in from...__array.length) {
			
			if (Reflect.compareMethods (__array[i], x)) {
				
				return i;
				
			}
			
		}
		
		return -1;
		
	}
	
	
	public function insertAt (index:Int, element:Function):Void {
		
		if (!fixed || index < __array.length) {
			
			__array.insert (index, element);
			
		}
		
	}
	
	
	public function iterator<Function> ():Iterator<Function> {
		
		return cast __array.iterator ();
		
	}
	
	
	public function join (sep:String = ","):String {
		
		return __array.join (sep);
		
	}
	
	
	public function lastIndexOf (x:Function, ?from:Int = 0):Int {
		
		var i = __array.length - 1;
		
		while (i >= from) {
			
			if (Reflect.compareMethods (__array[i], x)) return i;
			i--;
			
		}
		
		return -1;
		
	}
	
	
	public function pop ():Function {
		
		if (!fixed) {
			
			return __array.pop ();
			
		} else {
			
			return null;
			
		}
		
	}
	
	
	public function push (x:Function):Int {
		
		if (!fixed) {
			
			return __array.push (x);
			
		} else {
			
			return __array.length;
			
		}
		
	}
	
	
	public function removeAt (index:Int):Function {
		
		if (!fixed || index < __array.length) {
			
			return __array.splice (index, 1)[0];
			
		}
		
		return null;
		
	}
	
	
	public function reverse ():IVector<Function> {
		
		__array.reverse ();
		return this;
		
	}
	
	
	public function set (index:Int, value:Function):Function {
		
		if (!fixed || index < __array.length) {
			
			return __array[index] = value;
			
		} else {
			
			return value;
			
		}
		
	}
	
	
	public function shift ():Function {
		
		if (!fixed) {
			
			return __array.shift ();
			
		} else {
			
			return null;
			
		}
		
	}
	
	
	public function slice (?startIndex:Int = 0, ?endIndex:Int = 16777215):IVector<Function> {
		
		return new FunctionVector (__array.slice (startIndex, endIndex));
		
	}
	
	
	public function sort (f:Function->Function->Int):Void {
		
		__array.sort (f);
		
	}
	
	
	public function splice (pos:Int, len:Int):IVector<Function> {
		
		return new FunctionVector (__array.splice (pos, len));
		
	}
	
	
	@:noCompletion @:keep private function toJSON () {
		
		return __array;
		
	}
	
	
	public function toString ():String {
		
		return __array != null ? __array.toString () : null;
		
	}
	
	
	public function unshift (x:Function):Void {
		
		if (!fixed) {
			
			__array.unshift (x);
			
		}
		
	}
	
	
	
	
	// Getters & Setters
	
	
	
	
	@:noCompletion private function get_length ():Int {
		
		return __array.length;
		
	}
	
	
	@:noCompletion private function set_length (value:Int):Int {
		
		if (!fixed) {
			
			#if cpp
			
			cpp.NativeArray.setSize (__array, value);
			
			#else
			
			var currentLength = __array.length;
			if (value < 0) value = 0;
			
			if (value > currentLength) {
				
				for (i in currentLength...value) {
					
					__array[i] = null;
					
				}
				
			} else {
				
				while (__array.length > value) {
					
					__array.pop ();
					
				}
				
			}
			
			#end
			
		}
		
		return __array.length;
		
	}
	
	
}
#end




#if !openfl_debug
@:fileXml('tags="haxe,release"')
@:noDebug
#end


@:dox(hide) private class IntVector implements IVector<Int> {
	
	
	public var fixed:Bool;
	public var length (get, set):Int;
	
	private var __array:Array<Int>;
	
	
	public function new (?length:Int, ?fixed:Bool, ?array:Array<Int>):Void {
		
		if (array == null) {
			
			array = new Array<Int> ();
			
		}
		
		__array = array;
		
		if (length != null) {
			
			this.length = length;
			
		}
		
		this.fixed = (fixed == true);
		
	}
	
	
	public function concat (?a:IVector<Int>):IVector<Int> {
		
		if (a == null) {
			
			return new IntVector (__array.copy ());
			
		} else {
			
			return new IntVector (__array.concat (cast (a, IntVector).__array));
			
		}
		
	}
	
	
	public function copy ():IVector<Int> {
		
		return new IntVector (fixed, __array.copy ());
		
	}
	
	
	public function get (index:Int):Int {
		
		return __array[index];
		
	}
	
	
	public function indexOf (x:Int, ?from:Int = 0):Int {
		
		for (i in from...__array.length) {
			
			if (__array[i] == x) {
				
				return i;
				
			}
			
		}
		
		return -1;
		
	}
	
	
	public function insertAt (index:Int, element:Int):Void {
		
		if (!fixed || index < __array.length) {
			
			__array.insert (index, element);
			
		}
		
	}
	
	
	public function iterator<Int> ():Iterator<Int> {
		
		return cast __array.iterator ();
		
	}
	
	
	public function join (sep:String = ","):String {
		
		return __array.join (sep);
		
	}
	
	
	public function lastIndexOf (x:Int, ?from:Int = 0):Int {
		
		var i = __array.length - 1;
		
		while (i >= from) {
			
			if (__array[i] == x) return i;
			i--;
			
		}
		
		return -1;
		
	}
	
	
	public function pop ():Null<Int> {
		
		if (!fixed) {
			
			return __array.pop ();
			
		} else {
			
			return null;
			
		}
		
	}
	
	
	public function push (x:Int):Int {
		
		if (!fixed) {
			
			return __array.push (x);
			
		} else {
			
			return __array.length;
			
		}
		
	}
	
	
	public function removeAt (index:Int):Int {
		
		if (!fixed || index < __array.length) {
			
			return __array.splice (index, 1)[0];
			
		}
		
		return 0;
		
	}
	
	
	public function reverse ():IVector<Int> {
		
		__array.reverse ();
		return this;
		
	}
	
	
	public function set (index:Int, value:Int):Int {
		
		if (!fixed || index < __array.length) {
			
			return __array[index] = value;
			
		} else {
			
			return value;
			
		}
		
	}
	
	
	public function shift ():Null<Int> {
		
		if (!fixed) {
			
			return __array.shift ();
			
		} else {
			
			return null;
			
		}
		
	}
	
	
	public function slice (?startIndex:Int = 0, ?endIndex:Int = 16777215):IVector<Int> {
		
		return new IntVector (__array.slice (startIndex, endIndex));
		
	}
	
	
	public function sort (f:Int->Int->Int):Void {
		
		__array.sort (f);
		
	}
	
	
	public function splice (pos:Int, len:Int):IVector<Int> {
		
		return new IntVector (__array.splice (pos, len));
		
	}
	
	
	@:noCompletion @:keep private function toJSON () {
		
		return __array;
		
	}
	
	
	public function toString ():String {
		
		return __array != null ? __array.toString () : null;
		
	}
	
	
	public function unshift (x:Int):Void {
		
		if (!fixed) {
			
			__array.unshift (x);
			
		}
		
	}
	
	
	
	
	// Getters & Setters
	
	
	
	
	@:noCompletion private function get_length ():Int {
		
		return __array.length;
		
	}
	
	
	@:noCompletion private function set_length (value:Int):Int {
		
		if (!fixed) {
			
			#if cpp
			
			cpp.NativeArray.setSize (__array, value);
			
			#else
			
			var currentLength = __array.length;
			if (value < 0) value = 0;
			
			if (value > currentLength) {
				
				for (i in currentLength...value) {
					
					__array[i] = 0;
					
				}
				
			} else {
				
				while (__array.length > value) {
					
					__array.pop ();
					
				}
				
			}
			
			#end
			
		}
		
		return __array.length;
		
	}
	
	
}




#if !openfl_debug
@:fileXml('tags="haxe,release"')
@:noDebug
#end


@:dox(hide) private class ObjectVector<T> implements IVector<T> {
	
	
	public var fixed:Bool;
	public var length (get, set):Int;
	
	private var __array:Array<T>;
	
	
	public function new (?length:Int, ?fixed:Bool, ?array:Array<T>):Void {
		
		if (array == null) {
			
			array = new Array<T> ();
			
		}
		
		__array = array;
		
		if (length != null) {
			
			this.length = length;
			
		}
		
		this.fixed = (fixed == true);
		
	}
	
	
	public function concat (?a:IVector<T>):IVector<T> {
		
		if (a == null) {
			
			return new ObjectVector (__array.copy ());
			
		} else {
			
			return new ObjectVector (__array.concat (cast (cast (a, ObjectVector<Dynamic>).__array)));
			
		}
		
	}
	
	
	public function copy ():IVector<T> {
		
		return new ObjectVector (__array.copy ());
		
	}
	
	
	public function get (index:Int):T {
		
		return __array[index];
		
	}
	
	
	public function indexOf (x:T, ?from:Int = 0):Int {
		
		for (i in from...__array.length) {
			
			if (__array[i] == x) {
				
				return i;
				
			}
			
		}
		
		return -1;
		
	}
	
	
	public function insertAt (index:Int, element:T):Void {
		
		if (!fixed || index < __array.length) {
			
			__array.insert (index, element);
			
		}
		
	}
	
	
	public function iterator<T> ():Iterator<T> {
		
		return cast __array.iterator ();
		
	}
	
	
	public function join (sep:String = ","):String {
		
		return __array.join (sep);
		
	}
	
	
	public function lastIndexOf (x:T, ?from:Int = 0):Int {
		
		var i = __array.length - 1;
		
		while (i >= from) {
			
			if (__array[i] == x) return i;
			i--;
			
		}
		
		return -1;
		
	}
	
	
	public function pop ():T {
		
		if (!fixed) {
			
			return __array.pop ();
			
		} else {
			
			return null;
			
		}
		
	}
	
	
	public function push (x:T):Int {
		
		if (!fixed) {
			
			return __array.push (x);
			
		} else {
			
			return __array.length;
			
		}
		
	}
	
	
	public function removeAt (index:Int):T {
		
		if (!fixed || index < __array.length) {
			
			return __array.splice (index, 1)[0];
			
		}
		
		return null;
		
	}
	
	
	public function reverse ():IVector<T> {
		
		__array.reverse ();
		return this;
		
	}
	
	
	public function set (index:Int, value:T):T {
		
		if (!fixed || index < __array.length) {
			
			return __array[index] = value;
			
		} else {
			
			return value;
			
		}
		
	}
	
	
	public function shift ():T {
		
		if (!fixed) {
			
			return __array.shift ();
			
		} else {
			
			return null;
			
		}
		
	}
	
	
	public function slice (?startIndex:Int = 0, ?endIndex:Int = 16777215):IVector<T> {
		
		return new ObjectVector (__array.slice (startIndex, endIndex));
		
	}
	
	
	public function sort (f:T->T->Int):Void {
		
		__array.sort (f);
		
	}
	
	
	public function splice (pos:Int, len:Int):IVector<T> {
		
		return new ObjectVector (__array.splice (pos, len));
		
	}
	
	
	@:noCompletion @:keep private function toJSON () {
		
		return __array;
		
	}
	
	
	public function toString ():String {
		
		return __array != null ? __array.toString () : null;
		
	}
	
	
	public function unshift (x:T):Void {
		
		if (!fixed) {
			
			__array.unshift (x);
			
		}
		
	}
	
	
	
	
	// Getters & Setters
	
	
	
	
	@:noCompletion private function get_length ():Int {
		
		return __array.length;
		
	}
	
	
	@:noCompletion private function set_length (value:Int):Int {
		
		if (!fixed) {
			
			#if cpp
			
			cpp.NativeArray.setSize (__array, value);
			
			#else
			
			var currentLength = __array.length;
			if (value < 0) value = 0;
			
			if (value > currentLength) {
				
				for (i in currentLength...value) {
					
					__array.push (null);
					
				}
				
			} else {
				
				while (__array.length > value) {
					
					__array.pop ();
					
				}
				
			}
			
			#end
			
		}
		
		return __array.length;
		
	}
	

}


#if !openfl_debug
@:fileXml('tags="haxe,release"')
@:noDebug
#end


@:dox(hide) @:generic private class Float32ArrayVector implements IVector<Float> {
	
	
	public var fixed:Bool;
	public var length (get, set):Int;
	
	private var __array:Float32Array;
	private var __length:Int;
	
	
	public function new (?length:Int, ?fixed:Bool, ?array:Float32Array):Void {
		
		if (array == null) {
			
			array = new Float32Array (length > 128 ? length : 128);
			__length = length != null ? length : 0;
			
		} else {
			
			__length = length != null ? length : array.length;
			
		}
		
		__array = array;
		
		this.fixed = (fixed == true);
		
	}
	
	
	public function concat (?a:IVector<Float>):IVector<Float> {
		
		if (a == null) {
			
			var array = new Float32Array (__array.length);
			array.set (__array);
			return new Float32ArrayVector (__length, false, array);
			
		} else {
			
			var other:Float32ArrayVector = cast a;
			var array = new Float32Array (__length + other.__length);
			
			for (i in 0...__length) {
				
				array[i] = __array[i];
				
			}
			
			var index = __length;
			for (i in 0...other.__length) {
				
				array[index] = other.__array[i];
				index++;
				
			}
			
			return new Float32ArrayVector (array);
			
		}
		
	}
	
	
	public function copy ():IVector<Float> {
		
		var array = new Float32Array (__array.length);
		array.set (__array);
		return new Float32ArrayVector (__length, fixed, array);
		
	}
	
	
	public function get (index:Int):Float {
		
		return __array[index];
		
	}
	
	
	public function indexOf (x:Float, ?from:Int = 0):Int {
		
		for (i in from...__length) {
			
			if (__array[i] == x) {
				
				return i;
				
			}
			
		}
		
		return -1;
		
	}
	
	
	public function insertAt (index:Int, element:Float):Void {
		
		if (!fixed || index < __length) {
			
			__resize (__length + 1);
			
			var i = __length - 1;
			
			while (i >= index) {
				
				__array[i + 1] = __array[i];
				i--;
				
			}
			
			__array[index] = element;
			
		}
		
	}
	
	
	public function iterator<Float> ():Iterator<Float> {
		
		// TODO: Create custom iterator
		
		var array = new Array<Float> ();
		
		for (i in 0...__length) {
			
			array[i] = cast __array[i];
			
		}
		
		return cast array.iterator ();
		
	}
	
	
	public function join (sep:String = ","):String {
		
		// TODO: Is building a String more efficient?
		
		var array = new Array<Float> ();
		
		for (i in 0...__length) {
			
			array[i] = __array[i];
			
		}
		
		return array.join (sep);
		
	}
	
	
	public function lastIndexOf (x:Float, ?from:Int = 0):Int {
		
		var i = __length - 1;
		
		while (i >= from) {
			
			if (__array[i] == x) return i;
			i--;
			
		}
		
		return -1;
		
	}
	
	
	public function pop ():Null<Float> {
		
		if (!fixed && __length > 0) {
			
			__length--;
			return __array[__length];
			
		} else {
			
			return null;
			
		}
		
	}
	
	
	public function push (x:Float):Int {
		
		if (!fixed) {
			
			__resize (__length + 1);
			__array[__length - 1] = x;
			return __length;
			
		} else {
			
			return __length;
			
		}
		
	}
	
	
	public function removeAt (index:Int):Float {
		
		if (!fixed || index < __length) {
			
			var value = __array[index];
			
			for (i in index...(__length - 1)) {
				
				__array[i] = __array[i + 1];
				
			}
			
			__length--;
			return value;
			
		}
		
		return 0;
		
	}
	
	
	public function reverse ():IVector<Float> {
		
		var array = new Float32Array (__array.length);
		var index = __length - 1;
		
		for (i in 0...__length) {
			
			array[i] = __array[index];
			index--;
			
		}
		
		__array = array;
		return this;
		
	}
	
	
	public function set (index:Int, value:Float):Float {
		
		if (!fixed || index < __length) {
			
			if (index == __length) { __resize (__length + 1); }
			return __array[index] = value;
			
		} else {
			
			return value;
			
		}
		
	}
	
	
	public function shift ():Null<Float> {
		
		if (!fixed) {
			
			var value = __array[0];
			
			for (i in 0...__length - 2) {
				
				__array[i] = __array[i + 1];
				
			}
			
			__length--;
			return value;
			
		} else {
			
			return null;
			
		}
		
	}
	
	
	public function slice (?startIndex:Int = 0, ?endIndex:Int = 16777215):IVector<Float> {
		
		// TODO: Better implementation
		
		var array = new Array<Float> ();
		
		for (i in 0...__length) {
			
			array[i] = __array[i];
			
		}
		
		var array = array.slice (startIndex, endIndex);
		var __array = new Float32Array (array.length);
		
		for (i in 0...__length) {
			
			__array[i] = array[i];
			
		}
		
		return new Float32ArrayVector (__array);
		
	}
	
	
	public function sort (f:Float->Float->Int):Void {
		
		// TODO: Better implementation
		
		var array = new Array<Float> ();
		
		for (i in 0...__length) {
			
			array[i] = __array[i];
			
		}
		
		array.sort (f);
		
		for (i in 0...__length) {
			
			__array[i] = array[i];
			
		}
		
	}
	
	
	public function splice (pos:Int, len:Int):IVector<Float> {
		
		// TODO: Better implementation
		
		var array = new Array<Float> ();
		
		for (i in 0...__length) {
			
			array[i] = __array[i];
			
		}
		
		var returnArray = array.splice (pos, len);
		
		__length = array.length;
		
		for (i in 0...__length) {
			
			__array[i] = array[i];
			
		}
		
		var __array = new Float32Array (returnArray.length);
		
		for (i in 0...__length) {
			
			__array[i] = returnArray[i];
			
		}
		
		return new Float32ArrayVector (__array);
		
	}
	
	
	@:noCompletion @:keep private function toJSON () {
		
		// TODO: Better implementation
		
		var array = new Array<Float> ();
		
		for (i in 0...__length) {
			
			array[i] = cast __array[i];
			
		}
		
		return array;
		
	}
	
	
	public function toString ():String {
		
		return __array != null ? Std.string (__array) : null;
		
	}
	
	
	public function unshift (x:Float):Void {
		
		if (!fixed) {
			
			__resize (__length + 1);
			var index = __length - 2;
			
			while (index > 0) {
				
				__array[index + 1] = __array[index];
				index--;
				
			}
			
			__array[0] = x;
			
		}
		
	}
	
	
	private function __resize (newLength:Int):Void {
		
		if (newLength > __array.length) {
			
			// TODO: Larger data size intervals?
			
			var array = new Float32Array (newLength);
			array.set (__array);
			__array = array;
			
		}
		
		__length = newLength;
		
	}
	
	
	
	
	// Getters & Setters
	
	
	
	
	@:noCompletion private function get_length ():Int {
		
		return __length;
		
	}
	
	
	@:noCompletion private function set_length (value:Int):Int {
		
		if (!fixed) {
			
			__resize (value);
			
		}
		
		return __length;
		
	}
	
	
}




@:dox(hide) private interface IVector<T> {
	
	public var fixed:Bool;
	public var length (get, set):Int;
	
	public function concat (?a:IVector<T>):IVector<T>;
	public function copy ():IVector<T>;
	public function get (index:Int):T;
	public function indexOf (x:T, ?from:Int = 0):Int;
	public function insertAt (index:Int, element:T):Void;
	public function iterator<T> ():Iterator<T>;
	public function join (sep:String = ","):String;
	public function lastIndexOf (x:T, ?from:Int = 0):Int;
	public function pop ():Null<T>;
	public function push (x:T):Int;
	public function removeAt (index:Int):T;
	public function reverse ():IVector<T>;
	public function set (index:Int, value:T):T;
	public function shift ():Null<T>;
	public function slice (?pos:Int, ?end:Int):IVector<T>;
	public function sort (f:T -> T -> Int):Void;
	public function splice (pos:Int, len:Int):IVector<T>;
	public function toString ():String;
	public function unshift (x:T):Void;
	
	@:noCompletion private function toJSON ():Dynamic;
	
}




#else




abstract Vector<T>(VectorData<T>) {
	
	
	public var fixed (get, set):Bool;
	public var length (get, set):Int;
	
	
	public inline function new (?length:Int, ?fixed:Bool, ?array:Array<T>):Void {
		
		if (array != null) {
			
			this = VectorData.ofArray (array);
			
			//if (length != null) this.length = length;
			//if (fixed != null) this.fixed = fixed;
			
		} else {
			
			this = new VectorData<T> (length, fixed);
			
		}
		
		
	}
	
	
	public inline function concat (?a:VectorData<T>):Vector<T> {
		
		if (a == null) {
			
			return this.concat ();
			
		} else {
			
			return this.concat (a);
			
		}
		
	}
	
	
	public inline function copy ():Vector<T> {
		
		var vec = new VectorData<T> (this.length, this.fixed);
		
		for (i in 0...this.length) {
			
			vec[i] = this[i];
			
		}
		
		return vec;
		
	}
	
	
	public inline function indexOf (x:T, from:Int = 0):Int {
		
		return this.indexOf (x, from);
		
	}
	
	
	public function insertAt (index:Int, element:T):Void {
		
		#if flash19
		this.insertAt (index, element);
		#else
		Reflect.callMethod (this.splice, this.splice, [ index, 0, element ]);
		#end
		
	}
	
	
	public inline function iterator<T> ():Iterator<T> {
		
		return new VectorDataIterator<T> (this);
		
	}
	
	
	public inline function join (sep:String = ","):String {
		
		return this.join (sep);
		
	}
	
	
	public inline function lastIndexOf (x:T, from:Int = 0x7fffffff):Int {
		
		return this.lastIndexOf (x, from);
		
	}
	
	
	public inline function pop ():Null<T> {
		
		return this.pop ();
		
	}
	
	
	public inline function push (x:T):Int {
		
		return this.push (x);
		
	}
	
	
	public function removeAt (index:Int):T {
		
		#if flash19
		return this.removeAt (index);
		#else
		return Reflect.callMethod (this.splice, this.splice, [ index, 1 ])[0];
		#end
		
	}
	
	
	public inline function reverse ():Vector<T> {
		
		return this.reverse ();
		
	}
	
	
	public inline function shift ():Null<T> {
		
		return this.shift ();
		
	}
	
	
	public inline function slice (pos:Int = 0, end:Int = 16777215):Vector<T> {
		
		return this.slice (pos, end);
		
	}
	
	
	public inline function sort (f:T -> T -> Int):Void {
		
		this.sort (f);
		
	}
	
	
	public inline function splice (pos:Int, len:Int):Vector<T> {
		
		return this.splice (pos, len);
		
	}
	
	
	public inline function toString ():String {
		
		return this != null ? "[" + this.toString () + "]" : null;
		
	}
	
	
	public inline function unshift (x:T):Void {
		
		this.unshift (x);
		
	}
	
	
	public inline static function ofArray<T> (a:Array<Dynamic>):Vector<T> {
		
		return VectorData.ofArray (a);
		
	}
	
	
	public inline static function convert<T,U> (v:Vector<T>):Vector<U> {
		
		return cast VectorData.convert (v);
		
	}
	
	
	@:noCompletion @:dox(hide) @:arrayAccess public inline function get (index:Int):Null<T> {
		
		return this[index];
		
	}
	
	
	@:noCompletion @:dox(hide) @:arrayAccess public inline function set (index:Int, value:T):T {
		
		return this[index] = value;
		
	}
	
	
	/*@:noCompletion @:dox(hide) @:from public static inline function fromArray<T> (value:Array<T>):Vector<T> {
		
		return VectorData.ofArray (value);
		
	}
	
	
	@:noCompletion @:dox(hide) @:to public inline function toArray<T> ():Array<T> {
		
		var array = new Array<T> ();
		
		for (value in this) {
			
			array.push (value);
			
		}
		
		return array;
		
	}*/
	
	
	@:noCompletion @:dox(hide) @:from public static inline function fromHaxeVector<T> (value:haxe.ds.Vector<T>):Vector<T> {
		
		return cast value;
		
	}
	
	
	@:noCompletion @:dox(hide) @:to public inline function toHaxeVector<T> ():haxe.ds.Vector<T> {
		
		return cast this;
		
	}
	
	
	@:noCompletion @:dox(hide) @:from public static inline function fromVectorData<T> (value:VectorData<T>):Vector<T> {
		
		return cast value;
		
	}
	
	
	@:noCompletion @:dox(hide) @:to public inline function toVectorData<T> ():VectorData<T> {
		
		return cast this;
		
	}
	
	
	
	
	// Getters & Setters
	
	
	
	
	@:noCompletion private inline function get_fixed ():Bool {
		
		return this.fixed;
		
	}
	
	
	@:noCompletion private inline function set_fixed (value:Bool):Bool {
		
		return this.fixed = value;
		
	}
	
	
	@:noCompletion private inline function get_length ():Int {
		
		return this.length;
		
	}
	
	
	@:noCompletion private inline function set_length (value:Int):Int {
		
		return this.length = value;
		
	}
	
	
}


@:dox(hide) private class VectorDataIterator<T> {
	
	
	private var index:Int;
	private var vectorData:VectorData<T>;
	
	
	public function new (data:VectorData<T>) {
		
		index = 0;
		vectorData = data;
		
	}
	
	
	public function hasNext ():Bool {
		
		return index < vectorData.length;
		
	}
	
	
	public function next ():T {
		
		return vectorData[index++];
		
	}
	
	
}


private typedef VectorData<T> = flash.Vector<T>;


#end