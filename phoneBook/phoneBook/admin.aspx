<%@ Page Title="" Language="C#" MasterPageFile="~/master.Master" AutoEventWireup="true" CodeBehind="admin.aspx.cs" Inherits="phoneBook.WebForm2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Button ID="ShowAddPersonBtn" runat="server" CssClass="btn btn-sm btn-default" Text="Добавить пользователя" OnClick="ShowAddPersonBtn_Click" />
    <asp:Panel ID="addPersonPanel" runat="server" CssClass="panel panel-default panel-body" Visible="false" Style="width: 50%">
        <table class="table">
            <tr>
                <td>Логин</td>
                <td>
                    <asp:TextBox ID="loginTb" runat="server" CssClass="form-control"></asp:TextBox></td>
            </tr>
            <tr>
                <td>Пароль</td>
                <td>
                    <asp:TextBox ID="passmd5Tb" runat="server" CssClass="form-control"></asp:TextBox></td>

            </tr>
            <tr>
                <td>Видит всё</td>
                <td>
                    <asp:CheckBox ID="viewAllCb" runat="server" /></td>
            </tr>
            <tr>
                <td>Админ</td>
                <td>
                    <asp:CheckBox ID="adminCb" runat="server" /></td>
            </tr>
            <tr>
                <td>Роль</td>
                <td>
                    <asp:DropDownList ID="roleDdl" runat="server" CssClass="form-control"></asp:DropDownList></td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:Button ID="addUserBtn" runat="server" Text="Добавить" CssClass="btn btn-primary" OnClick="addUserBtn_Click" />
                </td>
            </tr>
        </table>
    </asp:Panel>

    <hr />
    <asp:GridView
        ID="UserView"
        runat="server"
        DataSourceID="UserSource"
        GridLines="None"
        CssClass="table table-striped table-bordered table-hover"
        AutoGenerateColumns="false"
        DataKeyNames="id">
        <Columns>
            <asp:CommandField ButtonType="Link" ShowEditButton="true" ShowSelectButton="false">
                <FooterStyle Wrap="false" />
                <HeaderStyle Width="60px" Wrap="false" />
                <ItemStyle Wrap="false" />
            </asp:CommandField>
            <asp:BoundField DataField="uname" HeaderText="Логин" ControlStyle-CssClass="form-control" />
            <asp:CheckBoxField DataField="view_all" HeaderText="Видит все" />
            <asp:CheckBoxField DataField="admin" HeaderText="Админ" />
            <asp:CheckBoxField DataField="active" HeaderText="Активен" />
            <asp:BoundField DataField="name" HeaderText="Роль" ReadOnly="true" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="UserSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:MySQLString %>"
        ProviderName="<%$ ConnectionStrings:MySQLString.ProviderName %>"
        SelectCommand="SELECT u.id,u.uname,u.view_all,u.admin,u.active,r.name FROM users u LEFT JOIN roles r ON u.role_id=r.id"
        UpdateCommand="UPDATE users SET uname=@uname,view_all=@view_all,admin=@admin,active=@active WHERE id=@id"></asp:SqlDataSource>
</asp:Content>
