/*
	File: Expressions
	Procedures for parsing expressions.
*/

/*
	Macros: Expression Macros
	OPERATOR   - A value indicating the parser currently expects a binary operator.
	VALUE			 - A value indicating the parser currently expects a value.
	SHIFT      - Tells the parser to push the current operator onto the stack.
	REDUCE		 - Tells the parser to reduce the stack.
*/
#define OPERATOR  1
#define VALUE     2
#define SHIFT     0
#define REDUCE    1

/*
	Class: nS_Parser
*/
/n_Parser/nS_Parser
	var
/*
	Var: expecting
	A variable which keeps track of whether an operator or value is expected. It should be either <OPERATOR> or <VALUE>. See <ParseExpression()>
	for more information.
*/
		expecting=VALUE

/*
	Proc: Precedence
	Compares two operators, decides which is higher in the order of operations, and returns <SHIFT> or <REDUCE>.
*/
/n_Parser/nS_Parser/proc/Precedence(node/expression/operator/top, node/expression/operator/input)
	if(istype(top))
		top=top.precedence
	if(istype(input))
		input=input.precedence
	if(top>=input)
		return REDUCE
	return SHIFT

/*
	Proc: GetExpression
	Takes a token expected to represent a value and returns an <expression> node.
*/
/n_Parser/nS_Parser/proc/GetExpression(token/T)
	if(!T) return
	if(istype(T, /node/expression))
		return T
	switch(T.type)
		if(/token/word)
			return new/node/expression/value/variable(T.value, T)

		if(/token/number, /token/string)
			return new/node/expression/value/literal(T.value, T)

/*
	Proc: GetOperator
	Gets a path related to a token or string and returns an instance of the given type. This is used to get an instance of either a binary or unary
	operator from a token.

	Parameters:
	O		 - The input value. If this is a token, O is reset to the token's value.
			   When O is a string and is in L, its associated value is used as the path to instantiate.
	type - The desired type of the returned object.
	L		 - The list in which to search for O.

	See Also:
	- <GetBinaryOperator()>
	- <GetUnaryOperator()>
*/
/n_Parser/nS_Parser/proc/GetOperator(O, type=/node/expression/operator, L[])
	var/token/T
	if(istype(O, type)) return O		//O is already the desired type
	if(istype(O, /token))
		T = O
		O=O:value //sets O to text
	if(istext(O))										//sets O to path
		if(L.Find(O)) O=L[O]
		else return null
	if(ispath(O))O=new O(T)						//catches path from last check
	else return null								//Unknown type
	return O

/*
	Proc: GetBinaryOperator
	Uses <GetOperator()> to search for an instance of a binary operator type with which the given string is associated. For example, if
	O is set to "+", an <Add> node is returned.

	See Also:
	- <GetOperator()>
	- <GetUnaryOperator()>
*/
/n_Parser/nS_Parser/proc/GetBinaryOperator(O)
	return GetOperator(O, /node/expression/operator/binary, options.binary_operators)

/*
	Proc: GetUnaryOperator
	Uses <GetOperator()> to search for an instance of a unary operator type with which the given string is associated. For example, if
	O is set to "!", a <LogicalNot> node is returned.

	See Also:
	- <GetOperator()>
	- <GetBinaryOperator()>
*/
/n_Parser/nS_Parser/proc/GetUnaryOperator(O)
	return GetOperator(O, /node/expression/operator/unary,  options.unary_operators)

/*
	Proc: Reduce
	Takes the operator on top of the opr stack and assigns its operand(s). Then this proc pushes the value of that operation to the top
	of the val stack.
*/
/n_Parser/nS_Parser/proc/Reduce(stack/opr, stack/val, check_assignments = 1)
	var/node/expression/operator/O=opr.Pop()
	if(!O) return
	if(!istype(O))
		errors+=new/scriptError("Error reducing expression - invalid operator.")
		return
	//Take O and assign its operands, popping one or two values from the val stack
	//depending on whether O is a binary or unary operator.
	if(istype(O, /node/expression/operator/binary))
		var/node/expression/operator/binary/B=O
		B.exp2=val.Pop()
		B.exp =val.Pop()
		val.Push(B)
		if(check_assignments && istype(B, /node/expression/operator/binary/Assign) && !istype(B.exp, /node/expression/value/variable) && !istype(B.exp, /node/expression/member))
			errors += new/scriptError/InvalidAssignment()
	else
		O.exp=val.Pop()
		val.Push(O)

/*
	Proc: EndOfExpression
	Returns true if the current token represents the end of an expression.

	Parameters:
	end - A list of values to compare the current token to.
*/
/n_Parser/nS_Parser/proc/EndOfExpression(end[])
	if(!curToken)
		return 1
	if(istype(curToken, /token/symbol) && end.Find(curToken.value))
		return 1
	if(istype(curToken, /token/end) && end.Find(/token/end))
		return 1
	return 0

/*
	Proc: ParseExpression
	Uses the Shunting-yard algorithm to parse expressions.

	Notes:
	- When an opening parenthesis is found, then <ParseParenExpression()> is called to handle it.
	- The <expecting>  variable helps distinguish unary operators from binary operators (for cases like the - operator, which can be either).

	Articles:
	- <http://epaperpress.com/oper/>
	- <http://en.wikipedia.org/wiki/Shunting-yard_algorithm>

	See Also:
	- <ParseFunctionExpression()>
	- <ParseParenExpression()>
	- <ParseParamExpression()>
*/
/n_Parser/nS_Parser/proc/ParseExpression(list/end=list(/token/end), list/ErrChars=list("{", "}"), check_functions = 0, check_assignments = 1)
	var/stack/opr = new
	var/stack/val = new

	src.expecting=VALUE
	var/loop = 0
	while(TRUE)
		loop++
		if(loop > 800)
			errors+=new/scriptError("Too many nested tokens.")
			return

		if(EndOfExpression(end))
			break
		if(istype(curToken, /token/symbol) && ErrChars.Find(curToken.value))
			errors+=new/scriptError/BadToken(curToken)
			break


		if(index>tokens.len)																						//End of File
			errors+=new/scriptError/EndOfFile()
			break
		var/token/ntok
		if(index+1<=tokens.len)
			ntok=tokens[index+1]

		if(istype(curToken, /token/symbol) && curToken.value=="(")			//Parse parentheses expression
			if(expecting == VALUE)
				val.Push(ParseParenExpression())
			else
				val.Push(ParseFunctionExpression(val.Pop())) // you can call *anything*! You can even call "2()". It'll runtime though so just don't please.
				expecting = OPERATOR
		else if(istype(curToken, /token/symbol) && curToken.value == "." && ntok && istype(ntok, /token/word))
			if(expecting == VALUE)
				errors+=new/scriptError/ExpectedToken("expression", curToken)
				NextToken()
				continue
			var/node/expression/member/dot/E = new(curToken)
			E.object = val.Pop()
			NextToken()
			E.id = new(curToken.value, curToken)
			val.Push(E)
		else if(istype(curToken, /token/symbol) && curToken.value == "\[")
			if(expecting == VALUE)
				errors+=new/scriptError/ExpectedToken("expression", curToken)
				NextToken()
				continue
			var/node/expression/member/brackets/B = new(curToken)
			B.object = val.Pop()
			NextToken()
			B.index = ParseExpression(list("]"))
			val.Push(B)
		else if(istype(curToken, /token/symbol))												//Operator found.
			var/node/expression/operator/curOperator											//Figure out whether it is unary or binary and get a new instance.
			if(src.expecting==OPERATOR)
				curOperator=GetBinaryOperator(curToken)
				if(!curOperator)
					errors+=new/scriptError/ExpectedToken("operator", curToken)
					NextToken()
					continue
			else
				curOperator=GetUnaryOperator(curToken)
				if(!curOperator) 																						//given symbol isn't a unary operator
					errors+=new/scriptError/ExpectedToken("expression", curToken)
					NextToken()
					continue

			if(opr.Top() && Precedence(opr.Top(), curOperator)==REDUCE)		//Check order of operations and reduce if necessary
				Reduce(opr, val, check_assignments)
				continue
			opr.Push(curOperator)
			src.expecting=VALUE
		else if(istype(curToken, /token/word) && curToken.value == "list" && ntok && ntok.value == "(" && expecting == VALUE)
			val.Push(ParseListExpression())
		else if(istype(curToken, /token/keyword)) 										//inline keywords
			var/n_Keyword/kw=options.keywords[curToken.value]
			kw=new kw(inline=1)
			if(kw)
				if(!kw.Parse(src))
					return
			else
				errors+=new/scriptError/BadToken(curToken)

		else if(istype(curToken, /token/end)) 													//semicolon found where it wasn't expected
			errors+=new/scriptError/BadToken(curToken)
			NextToken()
			continue
		else
			if(expecting!=VALUE)
				errors+=new/scriptError/ExpectedToken("operator", curToken)
				NextToken()
				continue
			val.Push(GetExpression(curToken))
			src.expecting=OPERATOR

		NextToken()

	while(opr.Top()) Reduce(opr, val, check_assignments) 																//Reduce the value stack completely
	.=val.Pop()                       																//Return what should be the last value on the stack
	if(val.Top())                     																//
		var/node/N=val.Pop()
		errors+=new/scriptError("Error parsing expression. Unexpected value left on stack: [N.ToString()].")
		return null

/*
	Proc: ParseFunctionExpression
	Parses a function call inside of an expression.

	See Also:
	- <ParseExpression()>
*/
/n_Parser/nS_Parser/proc/ParseFunctionExpression(func_exp)
	var/node/expression/FunctionCall/exp=new(curToken)
	exp.function = func_exp
	NextToken() //skip open parenthesis, already found
	var/loops = 0

	while(TRUE)
		loops++
		if(loops>=800)
			errors += new/scriptError("Too many nested expressions.")
			break
			//CRASH("Something TERRIBLE has gone wrong in ParseFunctionExpression ;__;")

		if(istype(curToken, /token/symbol) && curToken.value==")")
			return exp
		exp.parameters+=ParseParamExpression()
		if(errors.len)
			return exp
		if(curToken.value==","&&istype(curToken, /token/symbol))NextToken()	//skip comma
		if(istype(curToken, /token/end))																		//Prevents infinite loop...
			errors+=new/scriptError/ExpectedToken(")")
			return exp

/n_Parser/nS_Parser/proc/ParseListExpression()
	var/node/expression/value/list_init/exp = new(curToken)
	exp.init_list = list()
	NextToken() // skip the "list" word
	NextToken() // skip the open parenthesis
	var/loops = 0
	while(TRUE)
		loops++
		if(loops >= 800)
			errors += new /scriptError("Too many nested expressions.")
			break

		if(istype(curToken, /token/symbol) && curToken.value == ")")
			return exp
		var/node/expression/E = ParseParamExpression(check_assignments = FALSE)
		if(E.type == /node/expression/operator/binary/Assign)
			var/node/expression/operator/binary/Assign/A = E
			exp.init_list[A.exp] = A.exp2
		else
			exp.init_list += E
		if(errors.len)
			return exp
		if(curToken.value==","&&istype(curToken, /token/symbol))NextToken()	//skip comma
		if(istype(curToken, /token/end))																		//Prevents infinite loop...
			errors+=new/scriptError/ExpectedToken(")")
			return exp

/*
	Proc: ParseParenExpression
	Parses an expression that ends with a close parenthesis. This is used for parsing expressions inside of parentheses.

	See Also:
	- <ParseExpression()>
*/
/n_Parser/nS_Parser/proc/ParseParenExpression()
	var/group_token = curToken
	if(!CheckToken("(", /token/symbol))
		return
	return new/node/expression/operator/unary/group(group_token, ParseExpression(list(")")))

/*
	Proc: ParseParamExpression
	Parses an expression that ends with either a comma or close parenthesis. This is used for parsing the parameters passed to a function call.

	See Also:
	- <ParseExpression()>
*/
/n_Parser/nS_Parser/proc/ParseParamExpression(check_functions = 0, check_assignments = 1)
	var/cf = check_functions
	var/ca = check_assignments
	return ParseExpression(list(",", ")"), check_functions = cf, check_assignments = ca)
