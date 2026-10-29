import java.util.Stack;

String inputExpression = ""; // Stores the user's input infix expression
String postfixResult = "";    // Stores the converted postfix expression
String calcResult = "";       // Stores the final evaluation result

void setup() {
  size(700, 350);
  background(245);
}

void draw() {
  background(245); // Clear screen every frame
  
  // 1. Instruction guide
  fill(100);
  textSize(14);
  textAlign(LEFT, TOP);
  text("Type an infix expression and press [Enter] to calculate. (Use [Backspace] to edit)", 50, 40);
  
  // 2. User Input Field
  stroke(180);
  fill(255);
  rect(50, 70, 600, 45, 5);
  
  fill(30);
  textSize(20);
  textAlign(LEFT, CENTER);
  text(inputExpression + (frameCount % 30 < 15 ? "|" : ""), 65, 92); // Blinking cursor effect
  
  // 3. Output Display Area
  textAlign(LEFT, TOP);
  fill(80);
  textSize(16);
  text("Postfix Expression :", 50, 150);
  
  fill(30);
  textSize(18);
  text(postfixResult, 50, 180);
  
  fill(80);
  textSize(16);
  text("Result :", 50, 240);
  
  fill(#1A73E8); // Accent color for the final result
  textSize(24);
  text(calcResult, 50, 270);
}

// Capture keyboard inputs
void keyPressed() {
  if (key == ENTER || key == RETURN) {
    if (inputExpression.trim().length() > 0) {
      try {
        postfixResult = infixToPostfix(inputExpression);
        int res = evaluatePostfix(postfixResult);
        calcResult = String.valueOf(res);
      } catch (Exception e) {
        // Error handling for invalid expressions
        postfixResult = "ERROR";
        calcResult = "Invalid expression. Check parentheses and operators.";
      }
    }
  } else if (key == BACKSPACE) {
    if (inputExpression.length() > 0) {
      inputExpression = inputExpression.substring(0, inputExpression.length() - 1);
    }
  } else if (key != CODED && key != ESC) {
    inputExpression += key;
  }
}

// --- Stack Evaluation & Conversion Logic ---

int precedence(char op) {
  if (op == '+' || op == '-') return 1;
  if (op == '*' || op == '/') return 2;
  return -1;
}

String infixToPostfix(String expression) {
  StringBuilder result = new StringBuilder();
  Stack<Character> stack = new Stack<Character>();
  expression = expression.replaceAll("\\s+", "");

  for (int i = 0; i < expression.length(); i++) {
    char c = expression.charAt(i);

    if (Character.isDigit(c)) {
      while (i < expression.length() && Character.isDigit(expression.charAt(i))) {
        result.append(expression.charAt(i));
        i++;
      }
      result.append(" ");
      i--;
    } else if (c == '(') {
      stack.push(c);
    } else if (c == ')') {
      while (!stack.empty() && stack.peek() != '(') {
        result.append(stack.pop()).append(" ");
      }
      if (!stack.empty() && stack.peek() == '(') {
        stack.pop();
      }
    } else if (c == '+' || c == '-' || c == '*' || c == '/') {
      while (!stack.empty() && precedence(stack.peek()) >= precedence(c)) {
        result.append(stack.pop()).append(" ");
      }
      stack.push(c);
    }
  }

  while (!stack.empty()) {
    result.append(stack.pop()).append(" ");
  }

  return result.toString().trim();
}

int evaluatePostfix(String postfix) {
  Stack<Integer> stack = new Stack<Integer>();
  String[] tokens = postfix.split("\\s+");

  for (String token : tokens) {
    if (token.isEmpty()) continue;

    if (Character.isDigit(token.charAt(0))) {
      stack.push(int(token));
    } else {
      if (stack.size() < 2) throw new IllegalArgumentException();
      int val2 = stack.pop();
      int val1 = stack.pop();
      char op = token.charAt(0);

      switch (op) {
        case '+': stack.push(val1 + val2); break;
        case '-': stack.push(val1 - val2); break;
        case '*': stack.push(val1 * val2); break;
        case '/': 
          if (val2 == 0) throw new ArithmeticException();
          stack.push(val1 / val2); 
          break;
      }
    }
  }
  if (stack.size() != 1) throw new IllegalArgumentException();
  return stack.pop();
}
