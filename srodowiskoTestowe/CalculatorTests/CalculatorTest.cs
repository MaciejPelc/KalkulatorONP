using NUnit.Framework;
using superFajnyKalkulatorPodejscie2;

namespace CalculatorTests
{
    public class Tests
    {
        string additionInfix = "13 - (12 * 15) + 2";
        string additionPostfix = "13,12,15,*,-,2,+,";
        string substractInfix = "(13+(12*15))-100";
        string substractPostfix = "13,12,15,*,+,100,-,";
        string divisionInfix = "(13+(12*15))/93";//2.075268817204301
        string divisionPostfix = "13,12,15,*,+,93,/,";
        string multiplicationInfix = "2+2*2";
        string multiplicationPostfix = "2,2,2,*,+,";
        string infixToTranslator = "0-((5+63)-4-2-5*61+(8-16*4)/2*(22-11))";
        string encrypted = "0qtt5w63yq4q2q5r61wt8q16r4ye2rt22q11yy";
        [SetUp]
        public void Setup()
        {
        }

        [Test]
        public void CalculatorToRPN_Addition_InfixEqualToPostfix()
        {
            // Arange
            var ob = new Calculator();
            string actual;
            // Act
            actual = Calculator.toRPN(additionInfix);
            // Assert
            Assert.AreEqual(actual, "13,12,15,*,,2,+,");
        }
        [Test]
        public void CalculatorToRPN_Substract_InfixEqualToPostfix()
        {
            // Arange
            var ob = new Calculator();
            string actual;
            // Act
            actual = Calculator.toRPN(substractInfix);
            // Assert
            Assert.AreEqual(actual, "13,12,15,*,+,100,-,");
        }
        [Test]
        public void CalculatorToRPN_Division_InfixEqualToPostfix()
        {
            // Arange
            var ob = new Calculator();
            string actual;
            // Act
            actual = Calculator.toRPN(divisionInfix);
            // Assert
            Assert.AreEqual(actual, "13,12,15,*,+,93,/,");
        }
        [Test]
        public void CalculatorToRPN_Multiplication_InfixEqualToPostfix()
        {
            // Arange
            var ob = new Calculator();
            string actual;
            // Act
            actual = Calculator.toRPN(multiplicationInfix);
            // Assert
            Assert.AreEqual(actual, "2,2,2,*,+,");
        }
        [Test]
        public void CalculatorFromRPN_Addition_InfixEqualToPostfix()
        {
            // Arange
            var ob = new Calculator();
            string actual;
            // Act
            actual = Calculator.fromRPN(additionPostfix);
            // Assert
            Assert.AreEqual(actual, "-165");
        }
        [Test]
        public void CalculatorFromRPN_Substract_InfixEqualToPostfix()
        {
            // Arange
            var ob = new Calculator();
            string actual;
            // Act
            actual = Calculator.fromRPN(substractPostfix);
            // Assert
            Assert.AreEqual(actual, "93");
        }
        [Test]
        public void CalculatorFromRPN_Division_InfixEqualToPostfix()
        {
            // Arange
            var ob = new Calculator();
            string actual;
            // Act
            actual = Calculator.fromRPN(divisionPostfix);
            // Assert
            Assert.AreEqual(actual, "2.075268817204301");
        }
        [Test]
        public void CalculatorFromRPN_Multiplication_InfixEqualToPostfix()
        {
            // Arange
            var ob = new Calculator();
            string actual;
            // Act
            actual = Calculator.fromRPN(multiplicationPostfix);
            // Assert
            Assert.AreEqual(actual, "6");
        }
        [Test]
        public void Calculator_TranslateToServer_ConvertOperators()
        {
            // Arange
            var ob = new Calculator();
            string actual;
            // Act
            actual = Calculator.translateToServer(infixToTranslator);
            // Assert
            Assert.AreEqual(actual, "0qtt5w63yq4q2q5r61wt8q16r4ye2rt22q11yy");
        }
        [Test]
        public void Calculator_TranslateInServer_ConvertOperators()
        {
            // Arange
            var ob = new Calculator();
            string actual;
            // Act
            actual = Calculator.translateInServer(encrypted);
            // Assert
            Assert.AreEqual(actual, "0-((5+63)-4-2-5*61+(8-16*4)/2*(22-11))");
        }
    }
}