<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="reservation.*"%>
<%@ page import="user.*"%>
<%@ page import="java.util.*"%>
<%request.setCharacterEncoding("UTF-8"); String date = request.getParameter("date");%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
</head>
<body>
   <script>
      $(function() {
          //input�� datepicker�� ����
          $("#datepicker").datepicker({
              dateFormat: 'yy-mm-dd' //�޷� ��¥ ����
              ,showOtherMonths: true //�� ������ ������� �յڿ��� ��¥�� ǥ��
              ,showMonthAfterYear:true // ��- �� �������ƴ� �⵵ - �� ����
              ,changeYear: true //option�� �� ���� ����
              ,changeMonth: true //option��  �� ���� ����                
              ,showOn: "both" //button:��ư�� ǥ���ϰ�,��ư�� �����߸� �޷� ǥ�� ^ both:��ư�� ǥ���ϰ�,��ư�� �����ų� input�� Ŭ���ϸ� �޷� ǥ��  
              ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //��ư �̹��� ���
              ,buttonImageOnly: true //��ư �̹����� ����ϰ� ���̰���
              ,buttonText: "����" //��ư ȣ�� �ؽ�Ʈ              
              ,yearSuffix: "��" //�޷��� �⵵ �κ� �� �ؽ�Ʈ
              ,monthNamesShort: ['1��','2��','3��','4��','5��','6��','7��','8��','9��','10��','11��','12��'] //�޷��� �� �κ� �ؽ�Ʈ
              ,monthNames: ['1��','2��','3��','4��','5��','6��','7��','8��','9��','10��','11��','12��'] //�޷��� �� �κ� Tooltip
              ,dayNamesMin: ['��','��','ȭ','��','��','��','��'] //�޷��� ���� �ؽ�Ʈ
              ,dayNames: ['�Ͽ���','������','ȭ����','������','�����','�ݿ���','�����'] //�޷��� ���� Tooltip
              ,minDate: "-5Y" //�ּ� ��������(-1D:�Ϸ���, -1M:�Ѵ���, -1Y:�ϳ���)
              ,maxDate: "+5y" //�ִ� ��������(+1D:�Ϸ���, -1M:�Ѵ���, -1Y:�ϳ���)  
          });                    
          
          //�ʱⰪ�� ���� ��¥�� ��������� �մϴ�.
          $('#datepicker').datepicker('setDate', $("#hidden_param").val()); //(-1D:�Ϸ���, -1M:�Ѵ���, -1Y:�ϳ���), (+1D:�Ϸ���, -1M:�Ѵ���, -1Y:�ϳ���)            
      });
      function view() {
         var date = document.getElementById("datepicker");
         console.log(date.value);
      }
   </script>
   <!-- �ڹٽ�ũ��Ʈ�� post�� �ޱ� -->
   <input type="hidden" id="hidden_param", value="<%= date %>"/>
   <!-- �׺���̼�  -->
   <nav class="navbar navbar-default">
      <div class="navbar-header">
         <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
            aria-expaned="false">
            <span class="icon-bar"></span> <span class="icon-bar"></span> <span
               class="icon-bar"></span>
         </button>
         <a class="navbar-brand" href="Main.jsp">�����ϱ�</a>
      </div>
      <div class="collapse navbar-collapse"
         id="#bs-example-navbar-collapse-1">
         <ul class="nav navbar-nav">
            <li><a href="Main.jsp">����</a></li>
            <li><a href="bbs.jsp">�Խ���</a></li>
            <li><a href="reservationSearch.jsp">���� ��ȸ</a></li>
         </ul>
         <ul class="nav navbar-nav navbar-right">
            <li class="dropdown"><a href="#" class="dropdown-toggle"
               data-toggle="dropdown" role="button" aria-haspopup="true"
               aria-expanded="false">�����ϱ�<span class="caret"></span></a>
               <ul class="dropdown-menu">
                  <li class="active"><a href="Login.jsp">�α���</a></li>
                  <li><a href="Join.jsp">ȸ������</a></li>
               </ul></li>
         </ul>
      </div>
   </nav>
   <br>
   <div class="container">
   <form method="post" action="reservationSearch.jsp">
      <p>������ �������ּ���. 
         <input type="text" id="datepicker" name="date"></input>
         <button class="btn btn-primary" type="submit">
         <span class="glyphicon glyphicon-search">
         </span>
         </button>
      </p>
   </form>
   <table class="table table-bordered table-hover text-center" style="text-align: center; border: 1px;">
      <thead>
         <tr>
         <th>��ȣ</th>
         <th>�ð�</th>
         <th>���̺�</th>
         <th>����</th>
         <th>�ο�</th>
         </tr>
      </thead>
      <tbody>
         <%
         UserDAO userDAO = new UserDAO();
         ReservationDAO reservationDAO = new ReservationDAO();
         ArrayList<Reservation> list = reservationDAO.getReservationList(date);
         for (int i = 0; i < list.size(); i++) {
         %>
         <tr onclick="location.href='reservationView.jsp?oid=<%=list.get(i).getOid()%>'">
            <td><%=i + 1%></td>
            <td><%=list.get(i).getTime().toString()%></td>
            <td><%=list.get(i).getTableID()%></td>
            <td><%=userDAO.getUserName(list.get(i).getUserID())%>(<%=userDAO.getUserEmail(list.get(i).getUserID())%>)</td>
            <td><%=list.get(i).getCovers()%></td>
         </tr>
         <%}%>
      </tbody>
   </table>
   </div>
</body>
   <!-- ��Ʈ��Ʈ�� JS  -->
   <script src="js/bootstrap.js"></script>
</html>