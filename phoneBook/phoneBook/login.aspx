<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="phoneBook.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <link href="Content/modern.css" rel="stylesheet" />
    <link href='https://fonts.googleapis.com/css?family=Roboto:400,300,500,700,900' rel='stylesheet' type='text/css'/>
    <script type="text/javascript" src="Scripts/jquery.js"></script>
    <link href="Content/login.css" rel="stylesheet" />
    <title>Вход в PhoneBook</title>
</head>
<body>
    <form id="form1" runat="server">
        <div class="main-section">
            <div class="sign" style="width: 300px; position: relative;">
                <fieldset>

                    <legend>Феникс[Контакты]</legend>
                    <table class="table-wrapper" style="width:100%">
                        <tbody>
                            <tr>
                                <td>
                                    <div class="group-item">
                                        <asp:TextBox ID="TextBox1" runat="server" MaxLength="64"  />
                                    </div>
                                    <div class="group-item password">
                                        <asp:TextBox ID="TextBox2" runat="server" MaxLength="64" TextMode="Password"  />
                                    </div>
                                    <div class="submit-block-wrapper">
                                        <button id="Submit1" type="submit" value="submit" class="btn btn-success" runat="server" onserverclick="Submit1_ServerClick">Войти</button>
                                    </div>
                                    <asp:Label ID="Label1" runat="server" Text="" ForeColor="Red"></asp:Label>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </fieldset>
            </div>
        </div>
    </form>
</body>
</html>
