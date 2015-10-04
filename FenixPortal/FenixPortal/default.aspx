<%@ Page Title="" Language="C#" MasterPageFile="~/master.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="FenixPortal._default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div class="row" id ="content">
		<div class="col-md-3">
			<h4>
				WIKI
			</h4>
			<p>
		      Справочная информация по всем вопросам возникающим в нашей компании. 
			</p>
			<p>
				<a class="btn" href="http://portal.office.local/wiki/doku.php">Посетить »</a>
			</p>
		</div>
		<div class="col-md-3">
			<h4>
				Контакты
			</h4>
			<p>
				Поиск сотрудников.
			</p>
			<p>
				<a class="btn" href="contacts.aspx">Посетить »</a>
			</p>
		</div>
		<div class="col-md-3">
			<h4>
				Документы
			</h4>
			<p>
				Этот раздел поможет Вам легко и быстро оформить любые документы.
			</p>
			<p>
				<a class="btn" href="doc.aspx">Посетить »</a>
			</p>
		</div>
           <div class="col-md-3">
			<h4>
				Скоро
			</h4>
			<p>
				Donec id elit non mi porta gravida at eget metus.
			</p>
			<p>
				<a class="btn" href="#">Посетить »</a>
			</p>
		</div>
	</div>
</asp:Content>
