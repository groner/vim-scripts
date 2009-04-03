" Vim syntax file
" Language:	Python
" Maintainer:	Neil Schemenauer <nas@python.ca>
" Updated:	2006-10-15
"		Added Python 2.4 features 2006 May 4 (Dmitry Vasiliev)
"
" Options to control Python syntax highlighting:
"
" For highlighted numbers:
"
"    let python_highlight_numbers = 1
"
" For highlighted builtin functions:
"
"    let python_highlight_builtins = 1
"
" For highlighted standard exceptions:
"
"    let python_highlight_exceptions = 1
"
" Highlight erroneous whitespace:
"
"    let python_highlight_space_errors = 1
"
" If you want all possible Python highlighting (the same as setting the
" preceding options):
"
"    let python_highlight_all = 1
"

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif


syn keyword pythonStatement	break continue del
syn keyword pythonStatement	except exec finally
syn keyword pythonStatement	pass print raise
syn keyword pythonStatement	return try with
syn keyword pythonStatement	global assert
syn keyword pythonStatement	lambda yield
syn keyword pythonStatement	def class nextgroup=pythonFunction skipwhite
syn match   pythonFunction	"[a-zA-Z_][a-zA-Z0-9_]*" contained nextgroup=pythonCall
syn match   pythonSymbol	"[a-zA-Z_][a-zA-Z0-9_]*" nextgroup=pythonSubscript,pythonCall,pythonOperator,pythonComma,pythonColon skipwhite
syn keyword pythonRepeat	for while
syn keyword pythonConditional	if elif else
syn keyword pythonOperator	and in is not or
" AS will be a keyword in Python 3
syn keyword pythonPreCondit	import from as
syn match   pythonComment	"#.*$" contains=pythonTodo,@Spell
syn keyword pythonTodo		TODO FIXME XXX contained

" Decorators (new in Python 2.4)
syn match   pythonDecorator	"@" display nextgroup=pythonFunction skipwhite

" strings
" syn region pythonString		matchgroup=Normal start=+[uU]\='+ end=+'+ skip=+\\\\\|\\'+ contains=pythonEscape,@Spell
" syn region pythonString		matchgroup=Normal start=+[uU]\="+ end=+"+ skip=+\\\\\|\\"+ contains=pythonEscape,@Spell
" syn region pythonString		matchgroup=Normal start=+[uU]\="""+ end=+"""+ contains=pythonEscape,@Spell
" syn region pythonString		matchgroup=Normal start=+[uU]\='''+ end=+'''+ contains=pythonEscape,@Spell
" syn region pythonRawString	matchgroup=Normal start=+[uU]\=[rR]'+ end=+'+ skip=+\\\\\|\\'+ contains=@Spell
" syn region pythonRawString	matchgroup=Normal start=+[uU]\=[rR]"+ end=+"+ skip=+\\\\\|\\"+ contains=@Spell
" syn region pythonRawString	matchgroup=Normal start=+[uU]\=[rR]"""+ end=+"""+ contains=@Spell
" syn region pythonRawString	matchgroup=Normal start=+[uU]\=[rR]'''+ end=+'''+ contains=@Spell

" Modification to the python syntax in vim 7.2 to better distinguish strings
" and multiline strings.  The folding routines rely on the new classes to
" work.
syn region pythonString			matchgroup=Normal start=+[uU]\='+ end=+'+ skip=+\\\\\|\\'+ contains=pythonEscape,@Spell oneline 
syn region pythonString			matchgroup=Normal start=+[uU]\="+ end=+"+ skip=+\\\\\|\\"+ contains=pythonEscape,@Spell oneline 
syn region pythonMultilineString	matchgroup=MultilineStringStart start=+[uU]\="""+ matchgroup=MultilineStringEnd end=+"""+ contains=pythonEscape,@Spell 
syn region pythonMultilineString	matchgroup=MultilineStringStart start=+[uU]\='''+ matchgroup=MultilineStringEnd end=+'''+ contains=pythonEscape,@Spell  
syn region pythonRawString		matchgroup=Normal start=+[uU]\=[rR]'+ end=+'+ skip=+\\\\\|\\'+ contains=@Spell oneline 
syn region pythonRawString		matchgroup=Normal start=+[uU]\=[rR]"+ end=+"+ skip=+\\\\\|\\"+ contains=@Spell oneline 
syn region pythonMultilineRawString	matchgroup=MultilineStringStart start=+[uU]\=[rR]"""+ matchgroup=MultilineStringEnd end=+"""+ contains=@Spell 
syn region pythonMultilineRawString	matchgroup=MultilineStringStart start=+[uU]\=[rR]'''+ matchgroup=MultilineStringEnd end=+'''+ contains=@Spell 
syn match  pythonEscape		+\\[abfnrtv'"\\]+ contained
syn match  pythonEscape		"\\\o\{1,3}" contained
syn match  pythonEscape		"\\x\x\{2}" contained
syn match  pythonEscape		"\(\\u\x\{4}\|\\U\x\{8}\)" contained
syn match  pythonEscape		"\\$"

syn match  pythonOperator	'\(==\|>=\|>\|<=\|<\|\*\*=\|\*\*\|+=\|+\|-=\|-\|\*=\|\*\|/=\|/\|%=\|%\|=\|\.\)' nextgroup=@pythonExpr skipwhite
syn match  pythonComma		',' contained nextgroup=@pythonExpr skipwhite
syn match  pythonColon		':' contained nextgroup=@pythonExpr skipwhite

syn region pythonList		start='\(\w\s*\)\@<!\[' end=']' contains=pythonExprs
syn region pythonTuple		start='\(\w\s*\)\@<!(' end=')'  contains=pythonExprs
syn region pythonDict		start='\(\w\s*\)\@<!{' end='}'  contains=@pythonDictPairs

" Not sure how to implement these ...
" syn region pythonListComp	start='\[' end=']' contains=sfhsafhiwefa
" syn region pythonGenComp	start='(' end=')'  contains=sfhsafhiwefa
" syn region pythonDictComp	start='{' end='}'  contains=sfhsafhiwefa

syn region pythonSubscript	start='\[' end=']' contained contains=@pythonExpr,pythonColon keepend
syn region pythonCall		start='(' end=')' contained contains=@pythonExpr,pythonComma

syn cluster pythonStrings	add=pythonString,pythonMultilineString,pythonRawString,pythonMultilineRawString
syn cluster pythonSeq		add=pythonList,pythonTuple,pythonDict
syn cluster pythonSeq		add=pythonListComp,pythonGenComp,pythonDictComp
syn cluster pythonExpr		add=@pythonStrings,pythonNumber,@pythonSeq,pythonSymbol


if exists("python_highlight_all")
  let python_highlight_numbers = 1
  let python_highlight_builtins = 1
  let python_highlight_exceptions = 1
  let python_highlight_space_errors = 1
endif

if exists("python_highlight_numbers")
  " numbers (including longs and complex)
  syn match   pythonNumber	"\<0x\x\+[Ll]\=\>"
  syn match   pythonNumber	"\<\d\+[LljJ]\=\>"
  syn match   pythonNumber	"\.\d\+\([eE][+-]\=\d\+\)\=[jJ]\=\>"
  syn match   pythonNumber	"\<\d\+\.\([eE][+-]\=\d\+\)\=[jJ]\=\>"
  syn match   pythonNumber	"\<\d\+\.\d\+\([eE][+-]\=\d\+\)\=[jJ]\=\>"
endif

if exists("python_highlight_builtins")
  " builtin functions, types and objects, not really part of the syntax
  syn keyword pythonBuiltin	True False bool enumerate set frozenset help
  syn keyword pythonBuiltin	reversed sorted sum
  syn keyword pythonBuiltin	Ellipsis None NotImplemented __import__ abs
  syn keyword pythonBuiltin	apply buffer callable chr classmethod cmp
  syn keyword pythonBuiltin	coerce compile complex delattr dict dir divmod
  syn keyword pythonBuiltin	eval execfile file filter float getattr globals
  syn keyword pythonBuiltin	hasattr hash hex id input int intern isinstance
  syn keyword pythonBuiltin	issubclass iter len list locals long map max
  syn keyword pythonBuiltin	min object oct open ord pow property range
  syn keyword pythonBuiltin	raw_input reduce reload repr round setattr
  syn keyword pythonBuiltin	slice staticmethod str super tuple type unichr
  syn keyword pythonBuiltin	unicode vars xrange zip
endif

if exists("python_highlight_exceptions")
  " builtin exceptions and warnings
  syn keyword pythonException	ArithmeticError AssertionError AttributeError
  syn keyword pythonException	DeprecationWarning EOFError EnvironmentError
  syn keyword pythonException	Exception FloatingPointError IOError
  syn keyword pythonException	ImportError IndentationError IndexError
  syn keyword pythonException	KeyError KeyboardInterrupt LookupError
  syn keyword pythonException	MemoryError NameError NotImplementedError
  syn keyword pythonException	OSError OverflowError OverflowWarning
  syn keyword pythonException	ReferenceError RuntimeError RuntimeWarning
  syn keyword pythonException	StandardError StopIteration SyntaxError
  syn keyword pythonException	SyntaxWarning SystemError SystemExit TabError
  syn keyword pythonException	TypeError UnboundLocalError UnicodeError
  syn keyword pythonException	UnicodeEncodeError UnicodeDecodeError
  syn keyword pythonException	UnicodeTranslateError
  syn keyword pythonException	UserWarning ValueError Warning WindowsError
  syn keyword pythonException	ZeroDivisionError
endif

if exists("python_highlight_space_errors")
  " trailing whitespace
  syn match   pythonSpaceError   display excludenl "\S\s\+$"ms=s+1
  " mixed tabs and spaces
  syn match   pythonSpaceError   display " \+\t"
  syn match   pythonSpaceError   display "\t\+ "
endif

" This is fast but code inside triple quoted strings screws it up. It
" is impossible to fix because the only way to know if you are inside a
" triple quoted string is to start from the beginning of the file. If
" you have a fast machine you can try uncommenting the "sync minlines"
" and commenting out the rest.
syn sync match pythonSync grouphere NONE "):$"
syn sync maxlines=200
"syn sync minlines=2000


if version >= 508 || !exists("did_python_syn_inits")
  if version <= 508
    let did_python_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  " The default methods for highlighting.  Can be overridden later
  HiLink pythonStatement	Statement
  HiLink pythonFunction		Function
  HiLink pythonConditional	Conditional
  HiLink pythonRepeat		Repeat
  HiLink pythonString		String
  HiLink pythonRawString	String
  HiLink pythonEscape		Special
  HiLink pythonOperator		Operator
  HiLink pythonPreCondit	PreCondit
  HiLink pythonComment		Comment
  HiLink pythonTodo		Todo
  HiLink pythonDecorator	Define

  " These could be somewhere more general, but right now they're not
  HiLink MultilineString	String
  HiLink MultilineStringStart	String 
  HiLink MultilineStringEnd	String 

  HiLink pythonMultilineString	pythonString
  HiLink pythonMultilineRawString pythonRawString

  if exists("python_highlight_numbers")
    HiLink pythonNumber	Number
  endif
  if exists("python_highlight_builtins")
    HiLink pythonBuiltin	Function
  endif
  if exists("python_highlight_exceptions")
    HiLink pythonException	Exception
  endif
  if exists("python_highlight_space_errors")
    HiLink pythonSpaceError	Error
  endif

  delcommand HiLink
endif

let b:current_syntax = "python"

" vim: ts=8
