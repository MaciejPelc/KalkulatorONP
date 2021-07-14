<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="WebCalc.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:TextBox ID="PoleOperacji" runat="server" Height="34px" OnTextChanged="PoleOperacji_TextChanged" Width="211px"></asp:TextBox>
        </div>
        <p>
&nbsp;<asp:Button ID="Button1" runat="server" Font-Bold="True" Height="45px" OnClick="Button1_Click" Text="1" Width="45px" />
&nbsp;<asp:Button ID="Button2" runat="server" Font-Bold="True" Height="45px" OnClick="Button2_Click" Text="2" Width="45px" />
&nbsp;<asp:Button ID="Button3" runat="server" Font-Bold="True" Height="45px" OnClick="Button3_Click1" Text="3" Width="45px" />
&nbsp;<asp:Button ID="ButtonPlus" runat="server" Font-Bold="True" Height="45px" OnClick="ButtonPlus_Click" Text="+" Width="45px" />
        </p>
        <p>
&nbsp;<asp:Button ID="Button4" runat="server" Font-Bold="True" Height="45px" OnClick="Button4_Click" Text="4" Width="45px" />
&nbsp;<asp:Button ID="Button5" runat="server" Font-Bold="True" Height="45px" OnClick="Button5_Click" Text="5" Width="45px" />
&nbsp;<asp:Button ID="Button6" runat="server" Font-Bold="True" Height="45px" OnClick="Button7_Click" Text="6" Width="45px" />
&nbsp;<asp:Button ID="ButtonMinus" runat="server" Font-Bold="True" Height="45px" OnClick="ButtonMinus_Click" Text="-" Width="45px" />
        </p>
        <p>
&nbsp;<asp:Button ID="Button7" runat="server" Font-Bold="True" Height="45px" OnClick="Button7_Click1" Text="7" Width="45px" />
&nbsp;<asp:Button ID="Button8" runat="server" Font-Bold="True" Height="45px" OnClick="Button8_Click" Text="8" Width="45px" />
&nbsp;<asp:Button ID="Button9" runat="server" Font-Bold="True" Height="45px" OnClick="Button9_Click" Text="9" Width="45px" />
&nbsp;<asp:Button ID="ButtonRazy" runat="server" Font-Bold="True" Height="45px" OnClick="ButtonRazy_Click" Text="*" Width="45px" />
&nbsp;</p>
        <p>
&nbsp;<asp:Button ID="ButtonNawiasLewy" runat="server" Font-Bold="True" Height="45px" OnClick="ButtonNawiasLewy_Click" Text="(" Width="45px" />
&nbsp;<asp:Button ID="ButtonNawiasPrawy" runat="server" Font-Bold="True" Height="45px" OnClick="ButtonNawiasPrawy_Click" Text=")" Width="45px" />
&nbsp;<asp:Button ID="Button0" runat="server" Font-Bold="True" Height="45px" OnClick="Button0_Click" Text="0" Width="45px" />
&nbsp;<asp:Button ID="ButtonPodziel" runat="server" Font-Bold="True" Height="45px" OnClick="ButtonPodziel_Click" Text="/" Width="45px" />
&nbsp;</p>
        <p id="ButtonWyczysc">
            <asp:Button ID="ButtonWyczysc" runat="server" Font-Bold="True" Height="45px" OnClick="ButtonWyczysc_Click" Text="Wyczyść" Width="95px" />
&nbsp;<asp:Button ID="ButtonWynik" runat="server" Font-Bold="True" Font-Italic="False" Height="45px" OnClick="ButtonWynik_Click" Text="=" Width="94px" />
        </p>
    </form>
</body>
</html>
