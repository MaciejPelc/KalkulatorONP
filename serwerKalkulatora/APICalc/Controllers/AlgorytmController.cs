using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;

namespace APIAlgorytm.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class AlgorytmController : ControllerBase
    {
        /// <summary>
        /// algorytm manewrowy stoczni. Stworzony przez  Edsgera Dijkstre.
        /// </summary>
        static string toRPN(string infix)
        {
            /// <summary>
            /// A stack S to hold the operators that not added to the output queue. 
            /// </summary>
            Stack<char> stackS = new Stack<char>();
            string postfix;
            /// <summary>
            /// //A queue Q to hold the final reverse polish notation.
            /// </summary>
            string outputQ = "";
            string sum = "";
            Dictionary<string, int> operators = new Dictionary<string, int>();
            string wynik = "zle";
            operators.Add("/", 5);
            operators.Add("*", 5);
            operators.Add("+", 4);
            operators.Add("-", 4);
            operators.Add("(", 0);
            for (int i = 0; i < infix.Length; i++)
            {
                if (infix[i] == '(') //is '(' 
                {
                    if (sum != "")
                    {
                        outputQ += sum + ",";
                        sum = "";
                    }
                    stackS.Push(infix[i]);
                }
                else if (infix[i] == ')') //is ')' 
                {
                    if (sum != "")
                    {
                        outputQ += sum + ",";
                        sum = "";
                    }
                    while (stackS.Peek() != '(')
                    {
                        outputQ += (stackS.Pop() + ",");
                    }
                    stackS.Pop();
                }
                else if (infix[i] == '+' || infix[i] == '-' || infix[i] == '*' || infix[i] == '/')  //is an 'operator': 
                {
                    if (sum != "")
                    {
                        outputQ += sum + ",";
                        sum = "";
                    }
                    while (stackS.Count != 0 && operators[stackS.Peek().ToString()] >= operators[infix[i].ToString()])
                    {
                        outputQ += (stackS.Pop() + ",");
                    }
                    stackS.Push(infix[i]);
                }
                else if (Char.IsDigit(infix[i])) //is a number
                {
                    sum += (infix[i]);
                }
            }

            //warunek stworzony do zabezpieczenia kodu
            if (sum != "")
            {
                outputQ += sum + ",";
                sum = "";
            }

            while (stackS.Count != 0)
            {
                outputQ += (stackS.Pop() + ",");
            }
            postfix = outputQ;

            //koniec jednego algorytmu, początek drugiego

            char[] sp = new char[] { ',', '\t' };
            for (; ; )
            {
                string s = postfix;
                if (s == null) break;
                Stack<string> tks = new Stack<string>(s.Split(sp, StringSplitOptions.RemoveEmptyEntries));
                if (tks.Count == 0) continue;
                try
                {
                    double r = evalrpn(tks);
                    if (tks.Count != 0) throw new Exception();
                    wynik = r.ToString();
                    break;
                }
                catch (Exception e)
                {
                    return e.ToString();
                }
            }
            return wynik;
        }
        static double evalrpn(Stack<string> tks)
        {
            string tk = tks.Pop();
            double x, y;
            if (!Double.TryParse(tk, out x))
            {
                y = evalrpn(tks); x = evalrpn(tks);
                if (tk == "+") x += y;
                else if (tk == "-") x -= y;
                else if (tk == "*") x *= y;
                else if (tk == "/") x /= y;
                else throw new Exception();
            }
            return x;
        }

        [HttpGet("{convertt}")]
        public IActionResult Get(string convertt)
        {
            string Converting()
            {
                convertt = convertt.Replace("q", "-");//from q to -
                convertt = convertt.Replace("w", "+");//from w to +
                convertt = convertt.Replace("e", "/");//from e to /
                convertt = convertt.Replace("r", "*");//from r to *
                convertt = convertt.Replace("t", "(");//from t to (
                convertt = convertt.Replace("y", ")");//from y to )
                return toRPN(convertt);
                //convertt = convertt.Replace("-", "q");//from - to q
                //convertt = convertt.Replace("+", "w");//from + to w
                //convertt = convertt.Replace("/", "e");//from / to e
                //convertt = convertt.Replace("*", "r");//from * to r
                //convertt = convertt.Replace("(", "t");//from ( to t
                //convertt = convertt.Replace(")", "y");//from ) to y
            }
            return string.IsNullOrEmpty(convertt) ? Content(""):Content(Converting());
        }
        [HttpGet]
        public string Works()
        {
            return "This works";
        }
    }
}
