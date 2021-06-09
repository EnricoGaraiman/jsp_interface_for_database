<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>
<!DOCTYPE html>
<html>
<head>
	<title>Cazurile firmei</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no, user-scalable=no">
	<!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
	
	<!--  Icons -->
	<script src="https://kit.fontawesome.com/d8dbbaf693.js" crossorigin="anonymous"></script>
	
    <!-- CSS -->
    <link rel="stylesheet" href="./css/style.css">
</head>
	<jsp:useBean id="jb" scope="session" class="db.JavaBean" />
    <jsp:setProperty name="jb" property="*" />
    <%
    if(session.getAttribute("login")==null || session.getAttribute("login")==" "){ //check condition unauthorize user 
		out.println("<script type=\"text/javascript\">");
        out.println("alert('Nu v-ati autentificat');");
        out.println("</script>");
        response.sendRedirect("index.jsp"); 
	}
    if (request.getParameter("delete") != null) {
            String[] s = request.getParameterValues("primarykey");
	        jb.connect();
	        jb.stergeDateTabela(s, "caz", "idcaz");
	        jb.disconnect();
	        out.println("<script type=\"text/javascript\">");
	        out.println("alert('Datele selectate au fost sterse cu succes');");
	  	    out.println("location='cazuri.jsp';");
	        out.println("</script>");
		    }
    else if (request.getParameter("update") != null) {
    		%>
   			<jsp:forward page="update_caz.jsp" />
			<%
  	}
    else {
        %>
<body>
	<header>
		<nav class="navbar navbar-expand-lg navbar-dark my-bg-transparent fixed-top">
		   <a class="navbar-brand" href="index.jsp">
		    <img src="images/logo.png" class="my_animation" width="30" height="30" alt="LOGO">
		  </a>
		  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
		    <span class="navbar-toggler-icon"></span>
		  </button>
		
		  <div class="collapse navbar-collapse" id="navbarSupportedContent">
		    <ul class="navbar-nav ml-auto">
		      <li class="nav-item">
		        <a class="nav-link" href="index.jsp"><i class="fas fa-home"> </i> Pagina principala</a>
		      </li>
			  <li class="nav-item">
			    <a class="nav-link" href="avocati_clienti.jsp"><i class="fas fa-list"> </i> Avocati & Clienti</a>
			  </li>
			  <li class="nav-item active">
			    <a class="nav-link" href="cazuri.jsp"><i class="fas fa-gavel"> </i> Cazurile firmei</a>
			  </li>
			  <li class="nav-item">
			    <a class="nav-link" href="adaugare_avocati_clienti.jsp"><i class="fas fa-user-plus"> </i> Adaugare Avocati & Clienti</a>
			  </li>
			  <li class="nav-item">
			    <a class="nav-link" href="adauga_caz.jsp"><i class="fas fa-plus"> </i> Adaugare caz</a>
			  </li>
			  <li class="nav-item">
			  	<a class="nav-link btn btn-danger" href="logout.jsp"><i class="fas fa-sign-out-alt"> </i> Logout</a>
			  </li>
		    </ul>
		  </div>
		</nav>
	</header>
	<section class="secondary-bg">
	<h1 class="h1 cazuri_title"> Cazurile firmei</h1>
        <div class="col-md-3 width-80 cazuri-form">
        	<input type="text" id="my_input" onkeyup="filter()" placeholder="Cautare dupa numele cazului...">
        </div>
        <form action="cazuri.jsp" method="post">
        	<div class="table-responsive-lg">
            <table id="tabel_cazuri" class="table table-striped table-dark my-table">
                <tr>
                    <th><b></b></th>
                    <th><b>ID Caz</b></th>
                    <th><b>Numele cazului</b></th>
                    <th><b>Data</b></th>
                    <th><b>ID Avocat</b></th>
                    <th><b>Prenume avocat</b></th>
                    <th><b>Nume avocat</b></th>
                    <th><b>ID Client</b></th>
                    <th><b>Denumire firma</b></th>
                    <th><b>Prenume reprezentant</b></th>
                    <th><b>Nume reprezentant</b></th>
                    <th><b>Status:</b></th>
                </tr>
                <%
                    jb.connect();
                    ResultSet rs = jb.afisareCaz();
                    long x;
                    while (rs.next()) {
                        x = rs.getInt("idcaz");
                %>
                <tr>
                    <td><input type="checkbox" name="primarykey" class="checkbox checkbox_update" value="<%= x%>" /></td><td><%= x%></td>
                    <td><%= rs.getString("numele_cazului")%></td>
                    <td><%= rs.getDate("data")%></td>
                    <td><%= rs.getInt("idavocat")%></td>
                    <td><%= rs.getString("prenume")%></td>
                    <td><%= rs.getString("nume")%></td>
                    <td><%= rs.getInt("idclient")%></td>
                    <td><%= rs.getString("denumire_firma")%></td>
                    <td><%= rs.getString("prenume_reprezentant")%></td>
                    <td><%= rs.getString("nume_reprezentant")%></td>
                    <!-- Schimbare culoare in functie de status -->
                    <%
                    String succes;
                    succes = rs.getString("status");
                    
                    if (Objects.equals(succes, new String("Castigat"))) {%>
                    	<td class="text-success"><%= succes %></td> <% } %>
                    <% if (Objects.equals(succes, new String("Pierdut"))) {%>
                    	<td class="text-danger"><%= succes %></td> <% } %>
                    <% if (Objects.equals(succes, new String("In progres"))) {%>
                    	<td class="text-warning"><%= succes %></td><% } %>
                    <%
                        }
                    %>
                </tr>
            </table><br/>
            <div class="cazuri-form submit-btns" align="center">
			  <input id="check" type="submit" name="delete" class="btn btn btn-danger delete my_animation" value="Sterge cazurile bifate" disabled="disabled" onclick="return confirm('Esti sigur ca vrei sa stergi cazurile?')">
			  <input id="check2" type="submit" name="update" class="btn btn btn-warning delete my_animation" value="Modifica cazul bifat" disabled="disabled">
			  <a href="adauga_caz.jsp"><button type="button" class="btn btn-dark my_animation">Adauga un nou caz</button></a>
            </div>
            </div>
        </form>
        </section>
        <footer>
        	<jsp:include page="footer.html" />
        </footer>
        <%
            rs.close();
            jb.disconnect();
    		}
        %>
        
    <!-- JavaScript, Bootstrap js, jquery -->
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
	<script>
		<!-- Buton de stergere disabled/enabled delete -->
		 $('.btn-danger').prop('disabled', !$('.checkbox:checked').length); //initially disable/enable button based on checked length
		 $('input[type=checkbox]').click(function() {
		   console.log($('.checkbox:checkbox:checked').length);
		   if ($('.checkbox:checkbox:checked').length >= 1) {
		     $('.btn-danger').prop('disabled', false);
		   } else {
		     $('.btn-danger').prop('disabled', true);
		   }
		 });
		<!-- Buton de stergere disabled/enabled update -->
		 $('.btn-warning').prop('disabled', !$('.checkbox_update:checked').length); //initially disable/enable button based on checked length
		 $('input[type=checkbox]').click(function() {
		   console.log($('.checkbox_update:checkbox:checked').length);
		   if ($('.checkbox_update:checkbox:checked').length == 1) {
		     $('.btn-warning').prop('disabled', false);
		   } else {
		     $('.btn-warning').prop('disabled', true);
		   }
		 });
		<!-- Filtrare tabel -->
		function filter() {
			  var input, filter, table, tr, td, i, txtValue;
			  input = document.getElementById("my_input");
			  filter = input.value.toUpperCase();
			  table = document.getElementById("tabel_cazuri");
			  tr = table.getElementsByTagName("tr");
			  for (i = 0; i < tr.length; i++) {
			    td = tr[i].getElementsByTagName("td")[2];
			    if (td) {
			      txtValue = td.textContent || td.innerText;
			      if (txtValue.toUpperCase().indexOf(filter) > -1) {
			        tr[i].style.display = "";
			      } else {
			        tr[i].style.display = "none";
			      }
			    }       
			  }
			}
	</script>
</body>
</html>

