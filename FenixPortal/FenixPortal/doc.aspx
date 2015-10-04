<%@ Page Title="" Language="C#" MasterPageFile="~/master.Master" AutoEventWireup="true" CodeBehind="doc.aspx.cs" Inherits="FenixPortal.doc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row" id="content">
        <div class="col-md-4">
            <h2>Документы
            </h2>
            <p>
                Этот раздел поможет Вам легко и быстро оформить любые документы. 
            </p>
            <p>
            </p>
        </div>

        <div class="col-md-4">
            
                  
                    <div class="form-group">
                        <label for="Фамилия" class="col-lg-2 control-label">Фамилия</label>
                        <div class="col-lg-10">
                            <input type="text" class="form-control" id="SecondName" placeholder="Введите Фамилию"/>
                        </div>
                    </div>
                   <div class="form-group">
                        <label for="Имя" class="col-lg-2 control-label">Имя</label>
                        <div class="col-lg-10">
                            <input type="text" class="form-control" id="FirstName" placeholder="Введите Имя"/>
                        </div>
                    </div>
                   <div class="form-group">
                        <label for ="Отчество" class="col-lg-2 control-label">Отчество</label>
                        <div class="col-lg-10">
                            <input type="text" class="form-control" id="MiddleName" placeholder="Введите Отчество"/>
                        </div>
                    </div>
                  
                  <br> <br>
                    <div class="form-group">
                        <label for="select" class="col-lg-2 control-label">Ваша компания</label>
                        <div class="col-lg-10">
                            <select class="form-control" id="select">
                                <option>Феникс-Плюс</option>
                                <option>Феникс-Презент</option>
                                
                            </select>
                            <br>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-10 col-lg-offset-2">
                            <button type="reset" class="btn btn-default">Cancel</button>
                            <button type="submit" class="btn btn-primary">Submit</button>
                        </div>
                    </div>
          




        </div>

        <script type="text/javascript">
            $(document).ready(function () {
                $('.datepicker').datepicker();
            })
        </script>




    </div>
    <link href="Content/DataTables/css/jquery.dataTables.css" rel="stylesheet" />
    <script src="Scripts/jquery-1.9.1.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <script src="Scripts/DataTables/jquery.dataTables.min.js"></script>
    <script src="Scripts/jquery-1.9.1.js"></script>
    <link href="Content/bootstrap-datepicker.min.css" rel="stylesheet" />
    <script src="Scripts/locales/bootstrap-datepicker.ru.min.js"></script>
    <script src="Scripts/bootstrap-datepicker.js"></script>

</asp:Content>
