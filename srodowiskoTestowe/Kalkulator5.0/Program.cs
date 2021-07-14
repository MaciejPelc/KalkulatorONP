using System;
using System.Collections.Generic;
using System.IO;
using System.Net;

namespace superFajnyKalkulatorPodejscie2//5
{
    /// <summary>
    /// Główna klasa
    /// </summary>
    public class Calculator
    {
        /// <summary>
        /// algorytm manewrowy stoczni. Stworzony przez  Edsgera Dijkstre. Implementacja Maciej Pelc
        /// </summary>
        /// <returns>
        /// Zwracany jest zapis postfiksowy
        /// </returns>
        /// <example>
        /// <code>
        /// 4 5 7 2 + - *
        /// </code>
        /// </example>
        /// <see cref = https://www.szkolazpasja.pl/onp-np-notacja-infiksowa/ />
        public static string toRPN(string infix)
        {
            /// <summary>
            /// stos trzymający operatory, które nie zostaną dodane do zmiennej output
            /// </summary>
            Stack<char> stackS = new Stack<char>();
            /// <summary>
            /// A queue Q to hold the final reverse polish notation.
            /// </summary>
            string outputQ = "";
            /// <summary>
            /// słownik, zapisywane są w nim priorytety operatorów
            /// </summary>
            Dictionary<string, int> operators = new Dictionary<string, int>();
            ///zmienna wykorzystywana do przechowywania liczb pona
            string sum = "";
            operators.Add("/", 5);
            operators.Add("*", 5);
            operators.Add("+", 4);
            operators.Add("-", 4);
            operators.Add("(", 0);
            /// <summary>
            /// Pętla główna algorytmu kolejkowego
            /// rozbija zapis infiksowy w stringu na postfix
            /// </summary>
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
                    sum += (infix[i]);
            }

            //warunek stworzony do zabezpieczenia kodu
            if (sum != "")
            {
                outputQ += sum + ",";
                sum = "";
            }

            /// <summary>
            /// dodanie do output pozostałych operatorów, nie uwzględnionych w głównej pętli
            /// </summary>
            while (stackS.Count != 0)
            {
                outputQ += (stackS.Pop() + ",");
            }
            return outputQ;
        }

        /// <summary>
        /// Algorytm konwersji zapisu posfiksowego na wynik
        /// </summary>
        /// <returns>
        /// Zwracany wynik operacji
        /// </returns>
        /// <example>
        /// <code>
        /// -16
        /// </code>
        /// </example>
        /// <see cref = http://www.math.bas.bg/bantchev/place/rpn/rpn.c%23.html />
        public static string fromRPN(string postfix)
        {
            string er = "this is an error";
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
                    return r.ToString();
                    break;
                }
                catch (Exception e) { Console.WriteLine("error"); }
            }
            return er;
        }

        /// <summary>
        /// Metoda pomocnicza do "fromRPN" obliczająca
        /// </summary>
        private static double evalrpn(Stack<string> tks)
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

        /// <summary>
        /// metoda szyfrowania zapisu na serwer
        /// </summary>
        /// <returns>
        /// Zwraca zapis gotowy do wysłania na serwer
        /// </returns>
        /// <example>
        /// <code>
        /// przykładowo: 0qtt5w63yq4q2q5r61wt8q16r4ye2rt22q11yy
        /// </code>
        /// </example>
        public static string translateToServer(string infix)
        {
            infix = infix.Replace("-", "q");//from - to q
            infix = infix.Replace("+", "w");//from + to w
            infix = infix.Replace("/", "e");//from / to e
            infix = infix.Replace("*", "r");//from * to r
            infix = infix.Replace("(", "t");//from ( to t
            infix = infix.Replace(")", "y");//from ) to y
            return infix;
        }

        /// <summary>
        /// metoda rozszyfrowania zapisu przychodzą
        /// </summary>
        /// <returns>
        /// Zwraca zapis gotowy do wysłania na serwer
        /// </returns>
        /// <example>
        /// <code>
        /// przykładowo: 0qtt5w63yq4q2q5r61wt8q16r4ye2rt22q11yy
        /// </code>
        /// </example>
        public static string translateInServer(string encrypted)
        {
            encrypted = encrypted.Replace("q", "-");//from q to -
            encrypted = encrypted.Replace("w", "+");//from w to +
            encrypted = encrypted.Replace("e", "/");//from e to /
            encrypted = encrypted.Replace("r", "*");//from r to *
            encrypted = encrypted.Replace("t", "(");//from t to (
            encrypted = encrypted.Replace("y", ")");//from y to )
            return encrypted;
        }

        public static void Main(string[] args)
        {
            string output = "2+2*2+2+2+2+(12-123)";
            Console.WriteLine(output);
            output = toRPN(output);
            Console.WriteLine(output);
            output = fromRPN(output);
            Console.WriteLine(output);

            if (false)//zamieniaj jak kod działa
            {
                const string uriBase = "http://localhost:23858/algorytm/0qtt5w63yq4q2q5r61wt8q16r4ye2rt22q11yy";
                // Construct the URI of the search request
                var uriQuery = uriBase;
                // Run the Web request and get response.
                WebRequest request = HttpWebRequest.Create(uriQuery);
                HttpWebResponse response = (HttpWebResponse)request.GetResponseAsync().Result;
                string json = new StreamReader(response.GetResponseStream()).ReadToEnd();
                Console.WriteLine(json); 
            }
        }
    }
}
