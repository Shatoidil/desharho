<%@ Page Title="" Language="C#" MasterPageFile="~/Printer.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="FenixPrinters._default" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        
        <ContentTemplate>
    <div class="main">
        <div class="col-md-12">
            
            <asp:Repeater ID="Repeater1" runat="server" DataSourceID="PrinterSource">

                <HeaderTemplate>
                    <table id="example" class="table-bordered">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Имя</th>
                                <th>IP</th>
                                <th>Локация</th>
                                <th>Этаж</th>
                                <th>Кабинет</th>
                                <th>Редактирование</th>

                            </tr>
                        </thead>
                </HeaderTemplate>
                <ItemTemplate>

                    <tr>
                                <td>
                            <%# Eval("id")%>
                  
              </td>
                        <td>
                            <%# Eval("printername")%>
                  
              </td>
                        <td>
                            <%# Eval("ip")%>
                  
              </td>       <td>
                            <%# Eval("location")%>
                  
              </td>
                        <td>
                            <%# Eval("floor")%>
                  
              </td>
                        <td>
                            <%# Eval("cab")%>
                  
              </td>
                        <td>

                          <asp:Button ID="DeletePrinter" runat="server" Text="Удалить" OnCommand="DeletePrinter_Click" CommandArgument = '<%# Eval("id") %>'  CssClass="btn btn-danger" />
                             <asp:linkbutton ID="Linkbutton1" commandname="Update" runat="server" text="Update"  CommandArgument='<%# Eval("printername") +"|"+Eval("ip")+"|"+ Eval("location") %>' />
                        </td>
                    </tr>

                </ItemTemplate>
                <FooterTemplate>
                    </table>
         
                </FooterTemplate>
            </asp:Repeater>



            <asp:SqlDataSource ID="PrinterSource" runat="server"
                ConnectionString="<%$ ConnectionStrings:MySQLString %>"
                ProviderName="<%$ ConnectionStrings:MySQLString.ProviderName %>" SelectCommand="SELECT * FROM printers"></asp:SqlDataSource>

          
            <link href="Content/DataTables/css/jquery.dataTables.css" rel="stylesheet" />
            <script src="Scripts/jquery-1.9.1.min.js"></script>
            <script src="Scripts/bootstrap.min.js"></script>
            <script src="Scripts/DataTables/jquery.dataTables.min.js"></script>



            <script type="text/javascript">
                $(function () {
                    $('#example').dataTable({
                        "language": {
                            "url": "//cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/Russian.json"
                        }

                    });
                });
    </script>
        </div>
    </div>
            </ContentTemplate>
          </asp:UpdatePanel>
</asp:Content>
