
grammar LULU2;

@header{
	import java.util.Stack;
	import java.util.ArrayList;
	import java.lang.reflect.Array;
}

@members{
	Stack<symbolTable> stack = new Stack<>();
}

program:(ft_dcl)? (ft_def)* ;

ft_dcl: {stack.add(new symbolTable());} 'declare' '{' ( func_dcl | type_dcl | var_def)+ '}'
	{
		symbolTable st = stack.pop();
		System.out.println("SymbolTable:");
		st.print();	
        System.out.println("total size: " + st.getTotalSize());
        System.out.println("---------------------------------------------------------");
        stack.add(st);
	} ;

func_dcl: ( '(' args ')' '=' )? id=ID{
		String name1 = $id.text; 
		symbol sy = null; 
		symbolTable st = stack.pop();
		
		sy = new symbol( "function",name1, 0, false);{
		if(sy != null){
			st.addSymbol(sy);
		}
		stack.add(st);	
		}
		} '(' ( args | args_var )? ')' ';' ;


args: type( '[' ']' )* | args ',' type ( '[' ']' )* ;

args_var :
 type id1=ID {
		String name1 = $id1.text; 
		symbol sy = null; 
		symbolTable st = stack.pop();
				if($type.value == "int"){
				sy = new symbol(name1, $type.value, 4, false);
				} else if ($type.value == "float"){
					sy = new symbol(name1, $type.value, 4, false);
				} else if ($type.value == "long"){
					sy = new symbol(name1, $type.value, 8, false);
				} else if ($type.value == "double"){
					sy = new symbol(name1, $type.value, 8, false);
				} else if ($type.value == "bool"){
					sy = new symbol(name1, $type.value, 1, false);
				} else if ($type.value == "char"){
					sy = new symbol(name1, $type.value, 2, false);
				} else if ($type.value == "string"){
					sy = new symbol(name1, $type.value, 4 ,false);
				}else if ($type.value=="/0" ){
					System.err.println(" type of " + $type.text + "  not defined." + "line: " + $type.start.getLine());
				} else {
						sy = new symbol(name1, $type.value, 4, false);
				}
			
		} ( '[' ']' {int size=0;size+=4;if(size == 4){sy = new symbol(name1, $type.value, 4, false);}; })*{if(sy != null){st.addSymbol(sy);}stack.add(st);}
		 | args_var ',' type id2=ID {
		String name1 = $id2.text; 
		symbol sy = null; 
		symbolTable st = stack.pop();
		if($type.value == "int"){
				sy = new symbol(name1, $type.value, 4, false);
				} else if ($type.value == "float"){
					sy = new symbol(name1, $type.value, 4, false);
				} else if ($type.value == "long"){
					sy = new symbol(name1, $type.value, 8, false);
				} else if ($type.value == "double"){
					sy = new symbol(name1, $type.value, 8, false);
				} else if ($type.value == "bool"){
					sy = new symbol(name1, $type.value, 1, false);
				} else if ($type.value == "char"){
					sy = new symbol(name1, $type.value, 2, false);
				} else if ($type.value == "string"){
					sy = new symbol(name1, $type.value, 4, false);
				}else if ($type.value=="/0" ){
					System.err.println("type of " + $type.text + "  not defined." + "line: " + $type.start.getLine());
				} else {
						sy = new symbol(name1, $type.value, 4, false);
				}
	
		} ( '[' ']'{int size=0;size+=4;if(size == 4){sy = new symbol(name1, $type.value, 4, false);};} )*{if(sy != null){
			st.addSymbol(sy);
		}
		stack.add(st);} ;

type returns [String value]
	:	'int' {$value = "int";}
	|	'bool' {$value = "bool";}
	|	'float' {$value = "float";}
	|	'long' {$value = "long";}
	|	'char' {$value = "char";}
	|	'double' {$value = "double";}
	|	'string' {$value = "string";}
	|	ID {$value = $ID.text;}
	;

type_dcl : id=ID {
		String name1 = $id.text; 
		symbol sy = null; 
		symbolTable st = stack.pop();
		
		sy = new symbol( "user type",name1, 0, false);{
		if(sy != null){
			st.addSymbol(sy);
		}
		stack.add(st);	
		}
		}';' ;

var_def: {boolean yes=false;}(('const'{yes=true;})?) type v1 = var_val{
		symbolTable st2 = stack.pop();
		symbol sy = null;
		String name1 = $v1.name;
		int size = $v1.size;
		int stSize ;//= $v1.stSize;
		{String string = $v1.text; stSize=string.length()-3-name1.length();}
		if($v1.value != null){
		String top2 = $v1.value;
		if($type.value == "int" &&  top2 == "int"){
			sy = new symbol(name1, top2, 4 * size, yes);
		} else if($type.value == "long" &&  top2 == "long"){
			sy = new symbol(name1, top2, 8 * size, yes);
		} else if($type.value == "double" &&  top2 == "double"){
			sy = new symbol(name1, top2, 8 * size, yes);
		} else if($type.value == "Float" &&  top2 == "float"){
			sy = new symbol(name1, top2, 4 * size, yes);
		} else if($type.value == "char" &&  top2 == "char"){
			sy = new symbol(name1, top2, 2 * size, yes);
		} else if($type.value == "bool" &&  top2 == "bool"){
			sy = new symbol(name1, top2, 1 * size, yes);
		} else if($type.value == "string" &&  top2 == "string"){
			
			sy = new symbol(name1, top2, 2 * stSize, yes);
		}else if ($type.value=="/0" ){
					System.err.println("type of " + $type.text + " not defined." + "line: " + $type.start.getLine());
				} else {
						sy = new symbol(name1, $type.value, 4, false);
				}
		}
		else {
				if($type.value == "int"){
				sy = new symbol(name1, $type.value, 4 * size, yes);
				} else if ($type.value == "float"){
					sy = new symbol(name1, $type.value, 4 * size, yes);
				} else if ($type.value == "long"){
					sy = new symbol(name1, $type.value, 8 * size, yes);
				} else if ($type.value == "double"){
					sy = new symbol(name1, $type.value, 8 * size, yes);
				} else if ($type.value == "bool"){
					sy = new symbol(name1, $type.value, 1 * size, yes);
				} else if ($type.value == "char"){
					sy = new symbol(name1, $type.value, 2 * size, yes);
				} else if ($type.value == "string"){
					sy = new symbol(name1, $type.value, 2 * stSize, yes);
				}else if ($type.value=="/0" ){
					System.err.println(" type of " + $type.text + "  not defined." + "line: " + $type.start.getLine());
				} else {
						sy = new symbol(name1, $type.value, 4, false);
				}
		}

		if(sy != null){
			st2.addSymbol(sy);
		}
		stack.add(st2);
	}( ',' v2 = var_val
{
		symbolTable st = stack.pop();
		symbol s = null;
		String name2 = $v2.name;
		int size1 = $v2.size;
		int stSize1 ;//= $v2.stSize;
		{String string = $v1.text; stSize1=string.length()-3-name2.length();}
		if($v2.value != null){
		String top2 = $v2.value;
		
		if($type.value == "int" &&  top2 == "int"){
			s = new symbol(name2, top2, 4 * size1, false);
		} else if($type.value == "long" &&  top2 == "long"){
			s = new symbol(name2, top2, 8 * size1, false);
		} else if($type.value == "double" &&  top2 == "double"){
			s = new symbol(name2, top2, 8 * size1, false);
		} else if($type.value == "Float" &&  top2 == "float"){
			s = new symbol(name2, top2, 4 * size1, false);
		} else if($type.value == "char" &&  top2 == "char"){
			s = new symbol(name2, top2, 2 * size1, false);
		} else if($type.value == "bool" &&  top2 == "bool"){
			s = new symbol(name2, top2, 1 * size1, false);
		} else if($type.value == "string" &&  top2 == "string"){
			s = new symbol(name2, top2, 2 * stSize1, false);
		}else if ($type.value=="/0" ){
					System.err.println(" type of " + $type.text + "  not defined." + "line: " + $type.start.getLine());
				} else {
						sy = new symbol(name1, $type.value, 4, false);
				}} else {
				if($type.value == "int"){
				sy = new symbol(name1, $type.value, 4 * size1, false);
				} else if ($type.value == "float"){
					sy = new symbol(name1, $type.value, 4 * size1, false);
				} else if ($type.value == "long"){
					sy = new symbol(name1, $type.value, 8 * size1, false);
				} else if ($type.value == "double"){
					sy = new symbol(name1, $type.value, 8 * size1, false);
				} else if ($type.value == "bool"){
					sy = new symbol(name1, $type.value, 1 * size1, false);
				} else if ($type.value == "char"){
					sy = new symbol(name1, $type.value, 2 * size1, false);
				} else if ($type.value == "string"){
					sy = new symbol(name1, $type.value, 2 * stSize1, false);
				}else if ($type.value=="/0" ){
					System.err.println("type of " + $type.text + "  not defined." + "line: " + $type.start.getLine());
				} else {
						sy = new symbol(name1, $type.value, 4, false);
				}
		}

		if(s != null){
			st.addSymbol(s);
		}
		stack.add(st);
	} )* ';';
	

var_val returns [String value, String name, int size,int stSize]
		:id=ID{$name = $id.text; 
		$size = 1;
		symbolTable st = stack.pop();
		if(st.isDefined($name)){
			System.out.println("variable " + $name + " is defined before. line: " + $id.line);
		}
		stack.add(st);
		}
		( '[' in=Int_const {$size += Integer.parseInt($in.text); } ']' )* ( '=' ( e=expr{$value = $e.value;} | list | 'allocate' ID ))? ;

list: '[' ( expr | list ) ( ',' ( expr | list ) )* ']' ;

ft_def: ( type_def | fun_def )+ ;

type_def:{stack.add(new symbolTable());}  'type' ID ( ':' ID )? '{' (component) + '}' 
{	symbolTable st = stack.pop();
	System.out.println("SymbolTable:");
	st.print();
	System.out.println("total size : " + st.getTotalSize());
	System.out.println("---------------------------------------------------------");
};

component: (access_modifier)? ( var_def | fun_def ) ;

access_modifier returns[String value]
	:	'private' {$value = "private";}
	|	'public' {$value = "public";}
	|	'protected' {$value = "protected";}
	;

fun_def: {stack.add(new symbolTable());} ( '(' args_var ')' '=' )? 'function' ID '(' (args_var)? ')' block 
{	symbolTable st = stack.pop();
	System.out.println("SymbolTable:");
	st.print();
	System.out.println("total size: " + st.getTotalSize());
    System.out.println("---------------------------------------------------------");
}

	;

block: '{' ( var_def | stmt ) * '}' ;

stmt: assign ';' |func_call ';' | cond_stmt | loop_stmt | 'return' ';' | goto_def ';' | label | expr ';' | 'break' ';' | 'continue' ';' | 'destruct' ( '[' ']' )* ID ';' ;

assign: (var) '=' expr{
		String type = "/0";
		ArrayList<symbolTable> arr = new ArrayList<>();
			boolean defined = false;
			boolean isConst=false;
			while(!stack.isEmpty()){
				symbolTable st = stack.pop();
				arr.add(st);
				type = st.getType((String)$var.name);
				if (st.isDefined((String)$var.name)) {
					defined = true;
					isConst = st.isConstSymbol((String)$var.name);
					break;
				}
			}
			
			for(int i = arr.size() - 1 ; i >= 0 ; i--){
				stack.add(arr.get(i));
			}
			if(!defined){
				System.err.println(" not defined : " + $var.name + " " + $var.start.getLine());
			} else if(isConst){
				System.err.println("variable is const : " + $var.name + " " + $var.start.getLine());
 				}}| var '=' 'new' | '(' var ( ',' var )* ')' '=' func_call ;

	 

var returns [String value, String name]: ( ( 'this' | 'super' ) '.' )? r1 = ref {
			$name = $r1.name;
			$value = $r1.value;
			if($value == "\0"){
				System.err.println($r1.text + " not defined. line: " + $r1.start.getLine());
			
		} }
		 ( '.' r2 = ref {
			$name = $r2.name;
			$value = $r2.value;
			if($value == "\0"){
				System.err.println($r2.text + " not defined. line: " + $r2.start.getLine());
			}})* 
;


ref returns [String value, String name]: id=ID ('[' expr ']')* {
		$name = $id.text;
		ArrayList<symbolTable> array = new ArrayList<>();
		boolean defined = false;
		while(!stack.isEmpty()){
			symbolTable st = stack.pop();
			array.add(st);
			$value = st.getType((String)$id.text);
			
			if (st.isDefined((String)$id.text)) {
				defined = true;
				break;
			}
		}
		for(int i = array.size() - 1; i >= 0 ; i--){
			stack.add(array.get(i));
		}
		if(!defined){
			System.err.println(" not defined : " + $id.text + "line: " + $id.line);
		}
}; 

//expr: expr binary_op expr | '(' expr ')' | unary_op expr| const_val | func_call | var | 'nil' ;


expr  returns [String value]: expr '||'t { $value = $t.value;}|t{ $value = $t.value;};

t returns [String value]: t'&&'f{ $value = $f.value;}|f{ $value = $f.value;};

f returns [String value]:f'|'a{ $value = $a.value;}|a{ $value = $a.value;};

a returns [String value]:a'^'c{ $value = $c.value;}|c{ $value =$c.value;};

c returns [String value]:c'&'d{ $value = $d.value;}|d{ $value =$d.value;};

d returns [String value]:d'=='g{ $value = $g.value;}| d'!='g{ $value = $g.value;}|g{ $value = $g.value;};

g returns [String value]:g'<'h{ $value = $h.value;}|g'<='h{ $value = $h.value;}|g'>'h{ $value = $h.value;}|g'>='h{ $value = $h.value;}|h{ $value = $h.value;};

h returns [String value]:h'+'i{ $value = $i.value;}|h'-'i{ $value = $i.value;}|i{ $value = $i.value;};

i returns [String value]:i'*'j{ $value = $j.value;}|i'/'j{ $value = $j.value;}|i'%'j{ $value = $j.value;}|j{ $value = $j.value;};

j returns [String value]:'!'j|'~'j|k{ $value = $k.value;};

k returns [String value]:'-'k|l{ $value = $l.value;};

l returns [String value] :'('expr ')'|const_val { $value = $const_val.value;}|func_call{$value = "double";}| var {$value = "int";}| 'nil';
func_call returns [String value]: ( var '.' )? ID '(' (params)? ')' | 'sizeof' '(' ( type | var ) ')' | 'read' '(' var ')' | 'write' '(' var ')' ;

params: expr | expr ',' params ;


cond_stmt:{stack.add(new symbolTable());} 'if' '(' expr ')' block 
{	symbolTable st = stack.pop();
	System.out.println("SymbolTable:");
	st.print();
    System.out.println("total size: " + st.getTotalSize());
           System.out.println("---------------------------------------------------------");
}
        ({stack.add(new symbolTable());}'else' block 
{	symbolTable st1 = stack.pop();
	System.out.println(" SymbolTable:");
	st1.print();
    System.out.println("total size: " + st1.getTotalSize());
           System.out.println("---------------------------------------------------------");
}
		)? 

		 | 'switch' '(' var ')' 'of' ':' '{' ( {stack.add(new symbolTable());} 'case' Int_const ':' block 
{
	symbolTable st2 = stack.pop();
	System.out.println("SymbolTable:");
	st2.print();
	System.out.println("total size : " + st2.getTotalSize());
	       System.out.println("---------------------------------------------------------");
}
 ) * {stack.add(new symbolTable());} 'default' ':' block 
 {
	symbolTable st3 = stack.pop();
	System.out.println("SymbolTable:");
	st3.print();
	System.out.println("total size : " + st3.getTotalSize());
	       System.out.println("---------------------------------------------------------");
}'}' ;

loop_stmt: {stack.add(new symbolTable());} 'for' '(' (var_def)? ';' expr ';' (assign)? ')' block 
 {
	symbolTable st1 = stack.pop();
	System.out.println("SymbolTable:");
	st1.print();
	System.out.println("total size : " + st1.getTotalSize());
	       System.out.println("---------------------------------------------------------");
}
		|{stack.add(new symbolTable());} 'while' '(' expr ')' block 
{
	symbolTable st2 = stack.pop();
	System.out.println("SymbolTable:");
	st2.print();
	System.out.println("total size: " + st2.getTotalSize());
	       System.out.println("---------------------------------------------------------");
}

	;

goto_def: 'goto' ID ;

label: ID ':' ;

const_val returns [String value]: Int_const {$value = "int";} | Real_const {$value = "double";} | Char_const {$value = "char";}| Bool_const {$value = "bool";} | String_const {$value = "string";}{String string = $String_const.text;} ;

unary_op: '-' | '!' | '~' ;

binary_op: arithmetic | relational ;

arithmetic: '+' | '-' | '*' | '/' | '%' | '&' | '|' | '^' | '||' | '&&' ;

relational: '==' | '!=' | '<=' | '>=' | '<' | '>' ;

Bool_const: 'true'| 'false' ;

Int_const : [1-9]DIGIT*|'0'|'0'[Xx]HEX+;

Char_const : '\''( ESC|.?)'\'';

String_const :'"' (ESC | ~["\\])* '"' ;

Real_const : DIGIT* '.'DIGIT*([Ee][+-]?Int_const)?;

WS : (' '|'\t'|'\r'|'\n')+ -> skip ;

Comments : ('%%' .*? '\n' | '%@' .*? '@%') -> skip;

ID :([a-zA-Z]|'_')([a-zA-Z0-9]|'_')*;

fragment ESC : '\\' ('a'|'b'|'f'|'n'|'r'|'t'|'v'|'\''|'\\'|'?'|'"'| ASCII) ; 

fragment ASCII : [xX](HEX |HEX HEX);

fragment HEX : [0-9a-fA-F] ;

fragment DIGIT: [0-9];