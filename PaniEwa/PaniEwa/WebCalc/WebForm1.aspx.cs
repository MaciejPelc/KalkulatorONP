using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebCalc
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        static string equation = "";

        void ClickMe(string a)
        {
            equation += a;
            PoleOperacji.Text = equation;
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            ClickMe(Button1.Text);
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            ClickMe(Button2.Text);
        }

        protected void Button3_Click1(object sender, EventArgs e)
        {
            ClickMe(Button3.Text);
        }

        protected void Button4_Click(object sender, EventArgs e)
        {
            ClickMe(Button4.Text);
        }

        protected void Button5_Click(object sender, EventArgs e)
        {
            ClickMe(Button5.Text);
        }

        protected void Button7_Click(object sender, EventArgs e)
        {
            ClickMe("6");
        }

        protected void Button7_Click1(object sender, EventArgs e)
        {
            ClickMe("7");
        }

        protected void Button8_Click(object sender, EventArgs e)
        {
            ClickMe(Button8.Text);
        }

        protected void Button9_Click(object sender, EventArgs e)
        {
            ClickMe(Button9.Text);
        }

        protected void Button0_Click(object sender, EventArgs e)
        {
            ClickMe(Button0.Text);
        }

        protected void ButtonPlus_Click(object sender, EventArgs e)
        {
            ClickMe(ButtonPlus.Text);
        }

        protected void ButtonMinus_Click(object sender, EventArgs e)
        {
            ClickMe(ButtonMinus.Text);
        }

        protected void ButtonRazy_Click(object sender, EventArgs e)
        {
            ClickMe(ButtonRazy.Text);
        }

        protected void ButtonPodziel_Click(object sender, EventArgs e)
        {
            ClickMe(ButtonPodziel.Text);
        }

        protected void ButtonNawiasLewy_Click(object sender, EventArgs e)
        {
            ClickMe(ButtonNawiasLewy.Text);
        }

        protected void ButtonNawiasPrawy_Click(object sender, EventArgs e)
        {
            ClickMe(ButtonNawiasPrawy.Text);
        }
        protected void ButtonWyczysc_Click(object sender, EventArgs e)
        {
            if (equation.Length != 0)
            {
                equation = "";
            }
            PoleOperacji.Text = equation;
        }

        protected void ButtonWynik_Click(object sender, EventArgs e)
        {
            string sending = equation;
            sending = sending.Replace("-", "q");//from - to q
            sending = sending.Replace("+", "w");//from + to w
            sending = sending.Replace("/", "e");//from / to e
            sending = sending.Replace("*", "r");//from * to r
            sending = sending.Replace("(", "t");//from ( to t
            sending = sending.Replace(")", "y");//from ) to y

            string urlPath = "http://localhost:23858/algorytm/";
            string uriBase = urlPath + sending;

            // Construct the URI of the search request
            var uriQuery = uriBase;
            //+ "?q=" + Uri.EscapeDataString(searchQuery) + mkt = en - us;

            // Run the Web request and get response.
            WebRequest request = HttpWebRequest.Create(uriQuery);
            //request.Headers["Ocp-Apim-Subscription-Key"] = accessKey;

            HttpWebResponse response = (HttpWebResponse)request.GetResponseAsync().Result;
            string json = new StreamReader(response.GetResponseStream()).ReadToEnd();
            equation = json;

            if (!json.All(char.IsDigit))
                PoleOperacji.Text = "nie wiem jak wyswietlic popup";
            else
                PoleOperacji.Text = json;
        }

        protected void PoleOperacji_TextChanged(object sender, EventArgs e)
        {

        }
              
    }
}