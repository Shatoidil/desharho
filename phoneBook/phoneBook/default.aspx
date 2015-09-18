<%@ Page Title="" Language="C#" MasterPageFile="~/master.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="phoneBook._default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="page-header" id="banner">
            <div class="row">
            <div class="col-lg-12 col-md-7 col-sm-6">
                <div class="form-group">
                    <div class="input-group">

                        <asp:TextBox ID="findTb" runat="server" CssClass="form-control"></asp:TextBox>
                        <ajaxToolkit:AutoCompleteExtender ServiceMethod="SearchContact" MinimumPrefixLength="1" CompletionInterval="100" EnableCaching="false" TargetControlID="findTb" ID="AutoCompleteManagerFrom" runat="server" FirstRowSelected="false"></ajaxToolkit:AutoCompleteExtender>
                        <span class="input-group-btn">
                            <asp:Button ID="findBtn" runat="server" Text="Найти" CssClass="btn btn-primary" OnClick="findBtn_Click" />
                        </span>
                        <span class="input-group-btn">
                            <asp:Button ID="clearBtn" runat="server" Text="Снять фильтр" CssClass="btn btn-default" OnClick="clearBtn_Click" />
                        </span>
                    </div>
                </div>
            </div>
         </div>
       </div>
            <asp:GridView
                ID="ContactGrid"
                runat="server"
                GridLines="None"
                CssClass="table table-bordered table-hover table-striped"
                DataSourceID="ContactSource"
                AutoGenerateColumns="false"
                AllowSorting="true">
                <Columns>
                    <asp:TemplateField HeaderText="ФИО" SortExpression="lastname">
                        <ItemTemplate>
                            <%# string.Format("{0} {1} {2}",Eval("lastname"),Eval("firstname"),Eval("middlename")) %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="birthdate" HeaderText="День рождения" DataFormatString="{0:M}" SortExpression="birthdate" />
                    <asp:BoundField DataField="title" HtmlEncode="false" HeaderText="Описание" SortExpression="title" />
                    <asp:BoundField DataField="company" HtmlEncode="false" HeaderText="Организация" SortExpression="company" />
                    <asp:BoundField DataField="address" HtmlEncode="false" HeaderText="Адрес" SortExpression="address" />
                    <asp:BoundField DataField="phones" HtmlEncode="false" HeaderText="Телефоны" SortExpression="phones" />
                    <asp:BoundField DataField="emails" HtmlEncode="false" HeaderText="Email" SortExpression="emails" />
                </Columns>
            </asp:GridView>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:SqlDataSource ID="ContactSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:MySQLString %>"
        ProviderName="<%$ ConnectionStrings:MySQLString.ProviderName %>"></asp:SqlDataSource>

</asp:Content>
