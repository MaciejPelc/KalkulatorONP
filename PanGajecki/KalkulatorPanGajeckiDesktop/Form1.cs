using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Tulpep.NotificationWindow;

namespace KalkulatorPanGajeckiDesktop
{
    public partial class Form : System.Windows.Forms.Form
    {
        String equation = "";

        void ClickMe(string a)
        {
            equation += a;
            textBox1.Text = equation;
        }

        public Form()
        {
            InitializeComponent();
        }

        private void buttonEqual_Click(object sender, EventArgs e)
        {
            string sending = equation;
            sending = sending.Replace("-", "q");//from - to q
            sending = sending.Replace("+", "w");//from + to w
            sending = sending.Replace("/", "e");//from / to e
            sending = sending.Replace("*", "r");//from * to r
            sending = sending.Replace("(", "t");//from ( to t
            sending = sending.Replace(")", "y");//from ) to y

            string urlPath = "http://localhost:90/algorytm/";
            string uriBase = urlPath + sending;

            // Construct the URI of the search request
            var uriQuery = uriBase;

            // Run the Web request and get response.
            WebRequest request = HttpWebRequest.Create(uriQuery);
            //request.Headers["Ocp-Apim-Subscription-Key"] = accessKey;
            HttpWebResponse response = (HttpWebResponse)request.GetResponseAsync().Result;
            string json = new StreamReader(response.GetResponseStream()).ReadToEnd();

            if (!json.All(char.IsDigit)) 
                MessageBox.Show(json);
            else
                textBox1.Text = json;

        }

        private void buttonLeftBracket_Click(object sender, EventArgs e)
        {
            ClickMe(buttonLeftBracket.Text);
        }

        private void buttonRightBracket_Click(object sender, EventArgs e)
        {
            ClickMe(buttonRightBracket.Text);
        }

        private void button1_Click(object sender, EventArgs e)//plus
        {
            ClickMe(button1.Text);
        }

        private void buttonSubtraction_Click(object sender, EventArgs e)
        {
            ClickMe(buttonSubtraction.Text);
        }

        private void buttonMultiply_Click(object sender, EventArgs e)
        {
            ClickMe("*");
        }

        private void buttonDivision_Click(object sender, EventArgs e)
        {
            ClickMe("/");
        }

        private void buttonBackSpace_Click(object sender, EventArgs e)
        {
            if (equation.Length != 0)
            {
                equation = equation.Remove(equation.Length - 1, 1); 
            }
            textBox1.Text = equation;
        }

        private void buttonC_Click(object sender, EventArgs e)
        {
            if (equation.Length != 0)
            {
                equation = ""; 
            }
            textBox1.Text = equation;
        }

        private void buttonZero_Click(object sender, EventArgs e)
        {
            ClickMe(buttonZero.Text);
        }

        private void buttonNine_Click(object sender, EventArgs e)
        {
            ClickMe(buttonNine.Text);
        }

        private void buttonEight_Click(object sender, EventArgs e)
        {
            ClickMe(buttonEight.Text);
        }

        private void buttonSeven_Click(object sender, EventArgs e)
        {
            ClickMe(buttonSeven.Text);
        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {
        }

        private void buttonSix_Click(object sender, EventArgs e)
        {
            ClickMe(buttonSix.Text);
        }

        private void buttonFive_Click(object sender, EventArgs e)
        {
            ClickMe(buttonFive.Text);
        }

        private void buttonFour_Click(object sender, EventArgs e)
        {
            ClickMe(buttonFour.Text);
        }

        private void buttonThree_Click(object sender, EventArgs e)
        {
            ClickMe(buttonThree.Text);
        }

        private void buttonTwo_Click(object sender, EventArgs e)
        {
            ClickMe(buttonTwo.Text);
        }

        private void buttonOne_Click(object sender, EventArgs e)
        {
            ClickMe(buttonOne.Text);
        }
    }
}
