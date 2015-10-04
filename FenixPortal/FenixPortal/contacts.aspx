<%@ Page Title="" Language="C#" MasterPageFile="~/master.Master" AutoEventWireup="true" CodeBehind="contacts.aspx.cs" Inherits="FenixPortal.WebForm1" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager" runat="server"></asp:ScriptManager>
    
            <div class="row" id="content">
                <div class="col-md-8">

                    <div class="form-group">

                        <input type="text" class="form-control" placeholder="Поиск" id="search" />
                    </div>

                    <asp:Repeater ID="ReapeterContacts" runat="server">

                        <HeaderTemplate>
                            <table id="contact" class="table table-hover">
                                <thead>
                                    <tr>
                                        <th></th>
                                        <th></th>
                                        <th></th>
                                        <th></th>
                                        <th></th>
                                    </tr>
                                </thead>
                        </HeaderTemplate>
                        <ItemTemplate>

                            <tr>
                                 <td>
                                   
                                     <img src='<%# Eval("img")%>' alt="" width="100" height="100"  class="img-circle" />
                                </td>
                                <td>
                                    
                                    
                                    <b class="lead text-success text-center" ><%# Eval("lastname")%>  <%# Eval("firstname")%>  <%# Eval("middlename")%></b> <br />
                                    <p><small> <%# Eval("position")%></small> </p> <br />
                                     <asp:Button ID="ShowContact" runat="server" Text="Узнать Всё" OnCommand="ShowContact_Command" CssClass="btn btn-default btn-xs" CommandArgument='<%# Eval("id") %>' />

                                </td>
                                <td>
                                    <%# Eval("company")%>
                 
                                </td>

                               
                                <td>
                                    <%# Eval("phone")%>
                 
                                </td>
                                <td>
                                    <%# Eval("emails")%>
                                </td>
                              

                            </tr>

                        </ItemTemplate>
                        <FooterTemplate>
                            </table>
         
                        </FooterTemplate>
                    </asp:Repeater>
                    <!-- Modal -->
                    <div id="myModal" class="modal fade" role="dialog">
                        <div class="modal-dialog modal-sm">
                            <asp:UpdatePanel ID="upModal" runat="server" ChildrenAsTriggers="false" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <!-- Modal content-->
                                    <div class="modal-content">


                                        <div class="modal-body">

                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <asp:Image ID="ContactImgPics" runat="server" CssClass="img-rounded img-responsive" /></div>
                                                <div class="col-sm-6">

                                                    <p class="lead text-success text-center">
                                                        <asp:Label ID="FioLB" runat="server" />

                                                    </p>

                                                    <table class="table table-hover">
                                                        <tr>
                                                            <h6 class="text-center">
                                                                <asp:Label ID="ModalLBPosition" runat="server" /></h6>
                                                        </tr>
                                                        <tr>
                                                            <td><small><b>Компания:</b></small></td>
                                                            <td><small>
                                                                <asp:Label ID="ModalLBCompany" runat="server" /></small></td>
                                                        </tr>
                                                         <tr>
                                                            <td><small><b>Отдел:</b></small></td>
                                                            <td><small>
                                                                <asp:Label ID="ModalLBDepartament" runat="server" /></small></td>
                                                        </tr>
                                                        <tr>
                                                            <td><i class="fa fa-phone fa-lg text-success"></i></td>
                                                            <td><small>
                                                                <asp:Label ID="ModalLBTelephone" runat="server" /></small></td>
                                                        </tr>
                                                        <tr>
                                                            <td><i class="fa fa-envelope fa-lg text-success"></i></td>
                                                            <td><small>
                                                                <asp:Label ID="ModalLBEmail" runat="server" /></small></td>
                                                        </tr>
                                                        <tr>
                                                            <td><i class="fa fa-map-marker fa-lg text-success"></i></td>
                                                            <td><small>
                                                                <asp:Label ID="ModalLBAddress" runat="server" /></small></td>
                                                        </tr>
                                                         <tr>
                                                            <td><i class="fa fa-birthday-cake fa-lg text-success"></i></td>
                                                            <td><small>
                                                                <asp:Label ID="ModalLBirthday" runat="server" /></small></td>
                                                        </tr>

                                                      
                                                    </table>

                                                    


                                                </div>
                                            </div>

                                        </div>



                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                    </div>


                    <link href="Content/DataTables/css/jquery.dataTables.css" rel="stylesheet" />
                  
                    <script src="Scripts/DataTables/jquery.dataTables.min.js"></script>

                    <script type="text/javascript">
                        function openModal() {
                            $('#myModal').modal('show');
                        }
                    </script>



                    <script type="text/javascript">
                        $(function () {
                            oTable = $('#contact').dataTable({
                                "language": {
                                    "url": "//cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/Russian.json"
                                }



                            });
                            $('#search').keyup(function () {
                                oTable.fnFilter($(this).val());
                            });
                        });

                    </script>

                </div>
            </div>
  
</asp:Content>
