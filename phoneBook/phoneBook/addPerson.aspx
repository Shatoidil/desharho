<%@ Page Title="" Language="C#" MasterPageFile="~/master.Master" AutoEventWireup="true" CodeBehind="addPerson.aspx.cs" Inherits="phoneBook.WebForm1" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    
        <ContentTemplate>
            <asp:HiddenField ID="personID" runat="server" />

            <div class="page-header" id="banner">
                <div class="row">

                    <asp:Button ID="ShowAddPersonBtn" runat="server" Text="Добавить контакт" CssClass="btn btn-sm btn-default" OnClick="ShowAddPersonBtn_Click" />


                    <asp:Panel ID="AddPersonPanel" runat="server" CssClass="panel panel-body panel-primary" Visible="false" Style="width: 80%">

                        <form class="form-horizontal">
                            <fieldset>
                                <legend>Новый контакт</legend>
                                <div class="form-group">
                                    <label for="lastNameTb" class="col-lg-2 control-label">Фамилия</label>
                                    <div class="col-lg-10">
                                        <asp:TextBox ID="lastNameTb" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="firstNameTb" class="col-lg-2 control-label">Имя</label>
                                    <div class="col-lg-10">
                                        <asp:TextBox ID="firstNameTb" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="middleNameTb" class="col-lg-2 control-label">Отчество</label>
                                    <div class="col-lg-10">
                                        <asp:TextBox ID="middleNameTb" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="birthDateTb" class="col-lg-2 control-label">Дата рождения</label>
                                    <div class="col-lg-10">
                                        <asp:TextBox ID="birthDateTb" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                        <ajaxToolkit:CalendarExtender ID="calendarExtender" runat="server" TargetControlID="birthDateTb" Format="dd.MM.yyyy" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="titleTb" class="col-lg-2 control-label">Описание</label>
                                    <div class="col-lg-10">
                                        <asp:TextBox ID="titleTb" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="companyTb" class="col-lg-2 control-label">Организация</label>
                                    <div class="col-lg-10">
                                        <asp:TextBox ID="companyTb" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                    </div>
                                </div>
                                  <div class="form-group">
                                    <label for="addressTb" class="col-lg-2 control-label">Адрес</label>
                                    <div class="col-lg-10">
                                        <asp:TextBox ID="addressTb" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                    </div>
                                </div>
                                 <div class="form-group">
                                    <label for="discriptionTb" class="col-lg-2 control-label">Информация</label>
                                    <div class="col-lg-10">
                                        <asp:TextBox ID="discriptionTb" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                    </div>
                                </div>
                                    <div class="form-group">
                                    <label for="mateTb" class="col-lg-2 control-label">Помощники</label>
                                    <div class="col-lg-10">
                                        <asp:TextBox ID="mateTb" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                    </div>
                                </div>
                                
                                
                              
                                <div class="form-group">
                                    <label for="roleDdl" class="col-lg-2 control-label">Тип контакта</label>
                                    <div class="col-lg-10">
                                        <asp:DropDownList ID="roleDdl" runat="server" CssClass="form-control input-sm"></asp:DropDownList>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-lg-10 col-lg-offset-2">
                                        <asp:Button ID="AddPersonBtn" runat="server" Text="Добавить" CssClass="btn btn-primary" OnClick="AddPersonBtn_Click" />
                                    </div>
                                </div>
                            </fieldset>
                        </form>
                    </asp:Panel>
                    <hr />
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
                    <asp:GridView
                        ID="PersonView"
                        runat="server"
                        DataSourceID="PersonSource"
                        GridLines="None"
                        CssClass="table table-striped table-bordered table-condensed"
                        AllowSorting="true"
                        AllowPaging="true"
                        PageSize="50"
                        DataKeyNames="id"
                        AutoGenerateColumns="false"
                        OnRowCommand="PersonView_RowCommand">
                        <Columns>
                            <asp:CommandField ButtonType="Link" ShowEditButton="true" ShowSelectButton="false">
                                <FooterStyle Wrap="false" />
                                <HeaderStyle Width="60px" Wrap="false" />
                                <ItemStyle Wrap="false" />
                            </asp:CommandField>
                            <asp:BoundField DataField="lastname" HeaderText="Фамилия" SortExpression="lastname" ControlStyle-CssClass="form-control input-sm" />
                            <asp:BoundField DataField="firstname" HeaderText="Имя" SortExpression="firstname" ControlStyle-CssClass="form-control input-sm" />
                            <asp:BoundField DataField="middlename" HeaderText="Отчество" SortExpression="middlename" ControlStyle-CssClass="form-control input-sm" />

                            <asp:BoundField DataField="birthdate" HeaderText="Дата Рождения" SortExpression="birthdate" DataFormatString="{0:d}" ControlStyle-CssClass="form-control input-sm" />

                            <asp:BoundField DataField="title" HeaderText="Описание" SortExpression="title" ControlStyle-CssClass="form-control input-sm" />
                            <asp:BoundField DataField="company" HeaderText="Организация" SortExpression="company" ControlStyle-CssClass="form-control input-sm" />
                             <asp:BoundField DataField="mate" HeaderText="Помощники" SortExpression="mate" ControlStyle-CssClass="form-control input-sm" />
                              <asp:BoundField DataField="discription" HeaderText="Информация" SortExpression="discription" ControlStyle-CssClass="form-control input-sm" />
                            <asp:BoundField DataField="address" HeaderText="Адрес" SortExpression="address" ControlStyle-CssClass="form-control input-sm" />
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Button ID="phoneBtn" runat="server" Text="Телефоны" CssClass="btn btn-xs btn-default" CommandName="ShowPhones" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Button ID="emailBtn" runat="server" Text="EMails" CssClass="btn btn-xs btn-default" CommandName="ShowEmails" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Button ID="deleteContactBtn" runat="server" Text="Удалить" CssClass="btn btn-xs btn-danger" CommandName="DeleteContact" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>


                    <asp:Button ID="btnShowPhone" runat="server" Style="display: none" />
                    <ajaxToolkit:ModalPopupExtender ID="PhoneExtender" runat="server" Enabled="true" PopupControlID="PhonePanel" TargetControlID="btnShowPhone" BackgroundCssClass="modalBackground" CancelControlID="btnClosePhone"></ajaxToolkit:ModalPopupExtender>
                    <asp:Panel ID="PhonePanel" runat="server">
                        <asp:Button ID="btnClosePhone" runat="server" Text="X" Style="display: none" />
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <asp:LinkButton ID="btnClose" runat="server" Text="x" CssClass="close" />
                                    <h4 class="modal-title">Телефоны</h4>
                                </div>
                                <div class="modal-body">

                                    <asp:Button ID="showAddPhoneBtn" runat="server" Text="Новый телефон" CssClass="btn btn-xs btn-default" OnClick="showAddPhoneBtn_Click" />
                                    <asp:Panel ID="AddNewPhonePanel" runat="server" CssClass="panel panel-primary panel-body" Visible="false">
                                        <table class="table">
                                            <tr>
                                                <th>Тип</th>
                                                <th>Номер</th>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:TextBox ID="phoneTypeTb" runat="server" CssClass="form-control input-sm"></asp:TextBox></td>
                                                <td>
                                                    <asp:TextBox ID="phoneNumberTb" runat="server" CssClass="form-control input-sm"></asp:TextBox></td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <asp:Button ID="addPhoneBtn" runat="server" Text="Добавить" CssClass="btn btn-sm btn-primary" OnClick="addPhoneBtn_Click" />
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>

                                    <asp:GridView ID="PhoneView"
                                        runat="server"
                                        GridLines="None"
                                        CssClass="table table-striped table-bordered"
                                        DataSourceID="PhoneSource"
                                        AutoGenerateColumns="false"
                                        DataKeyNames="id"
                                        OnRowCommand="PhoneView_RowCommand">
                                        <Columns>
                                            <asp:BoundField DataField="phone_type" HeaderText="Тип" SortExpression="phone_type" />
                                            <asp:BoundField DataField="phone" HeaderText="Телефон" SortExpression="phone" />
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:Button ID="deletePhoneBtn" runat="server" Text="Удалить" CssClass="btn btn-xs btn-warning" CommandName="DeletePhone" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" />
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                        </Columns>
                                    </asp:GridView>

                                </div>
                            </div>
                        </div>
                    </asp:Panel>


                    <asp:Button ID="btnShowEMail" runat="server" Style="display: none" />
                    <ajaxToolkit:ModalPopupExtender ID="EmailExtender" runat="server" Enabled="true" PopupControlID="EmailPanel" TargetControlID="btnShowEMail" BackgroundCssClass="modalBackground" CancelControlID="btnCloseEMail"></ajaxToolkit:ModalPopupExtender>
                    <asp:Panel ID="EmailPanel" runat="server">
                        <asp:Button ID="btnCloseEMail" runat="server" Text="X" Style="display: none" />
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <asp:LinkButton ID="LinkButton1" runat="server" Text="x" CssClass="close" />
                                    <h4 class="modal-title">Emails</h4>
                                </div>
                                <div class="modal-body">

                                    <asp:Button ID="newEmailBtn" runat="server" Text="Новый email" CssClass="btn btn-xs btn-default" OnClick="newEmailBtn_Click" />
                                    <asp:Panel ID="AddNewEMailPanel" runat="server" CssClass="panel panel-primary panel-body" Visible="false">
                                        <table class="table">
                                            <tr>
                                                <th>Тип</th>
                                                <th>Email</th>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:TextBox ID="emailTypeTb" runat="server" CssClass="form-control input-sm"></asp:TextBox></td>
                                                <td>
                                                    <asp:TextBox ID="emailTb" runat="server" CssClass="form-control input-sm"></asp:TextBox></td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <asp:Button ID="addEmailBtn" runat="server" Text="Добавить" CssClass="btn btn-sm btn-primary" OnClick="addEmailBtn_Click" />
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>

                                    <asp:GridView ID="EmailView"
                                        runat="server"
                                        GridLines="None"
                                        CssClass="table table-striped table-bordered"
                                        DataSourceID="EmailSource"
                                        AutoGenerateColumns="false"
                                        DataKeyNames="id"
                                        OnRowCommand="EmailView_RowCommand">
                                        <Columns>
                                            <asp:BoundField DataField="email_type" HeaderText="Тип" SortExpression="email_type" />
                                            <asp:BoundField DataField="email" HeaderText="Email" SortExpression="email" />
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:Button ID="deleteEmailBtn" runat="server" Text="Удалить" CssClass="btn btn-xs btn-warning" CommandName="DeleteEmail" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" />
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                        </Columns>
                                    </asp:GridView>

                                </div>
                            </div>
                        </div>
                    </asp:Panel>
        </ContentTemplate>

    <asp:SqlDataSource ID="PhoneSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:MySQLString %>"
        ProviderName="<%$ ConnectionStrings:MySQLString.ProviderName %>"
        SelectCommand="SELECT id,phone_type,phone FROM phones WHERE person_id=@pid AND active=1">
        <SelectParameters>
            <asp:ControlParameter ControlID="personID" Name="pid" PropertyName="Value" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="EmailSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:MySQLString %>"
        ProviderName="<%$ ConnectionStrings:MySQLString.ProviderName %>"
        SelectCommand="SELECT id,email_type,email FROM emails WHERE person_id=@pid AND active=1">
        <SelectParameters>
            <asp:ControlParameter ControlID="personID" Name="pid" PropertyName="Value" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="PersonSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:MySQLString %>"
        ProviderName="<%$ ConnectionStrings:MySQLString.ProviderName %>"
        UpdateCommand="UPDATE person SET lastname=@lastname,firstname=@firstname,middlename=@middlename,address=@address,title=@title,company=@company,birthdate=@birthdate,mate=@mate,discription=@discription WHERE id=@id"></asp:SqlDataSource>
</asp:Content>
