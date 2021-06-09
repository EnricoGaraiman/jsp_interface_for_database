<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>
<!DOCTYPE html>
<html>
<head>
	<title>Avocati & clienti</title>
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
		response.sendRedirect("index.jsp"); 
	}
    if (request.getParameter("delete_avocat") != null) {
        String[] s = request.getParameterValues("primarykey");
        jb.connect();
        jb.stergeDateTabela(s, "avocati", "idavocat");
        jb.disconnect();
        out.println("<script type=\"text/javascript\">");
        out.println("alert('Datele selectate au fost sterse cu succes');");
  	    out.println("location='avocati_clienti.jsp';");
        out.println("</script>");
	    }
	else if (request.getParameter("update_avocat") != null) {
			%>
				<jsp:forward page="update_avocat.jsp" />
			<%
		} 
	else if (request.getParameter("delete_client") != null) {
        String[] s = request.getParameterValues("primarykey2");
        jb.connect();
        jb.stergeDateTabela(s, "clienti", "idclient");
        jb.disconnect();
        out.println("<script type=\"text/javascript\">");
        out.println("alert('Datele selectate au fost sterse cu succes');");
  	    out.println("location='avocati_clienti.jsp';");
        out.println("</script>");
	    }
	else if (request.getParameter("update_client") != null) {
			%>
				<jsp:forward page="update_client.jsp" />
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
			  <li class="nav-item active">
			    <a class="nav-link" href="avocati_clienti.jsp"><i class="fas fa-list"> </i> Avocati & Clienti</a>
			  </li>
			  <li class="nav-item">
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
	<section class="secondary-bg" id="avocati_clienti">
		<div class="tabele_avocati_clienti">
			<ul class="nav nav-tabs nav-justified" id="myTab" role="tablist">
			  <li class="nav-item">
			    <a class="nav-link" id="avocati-tab" data-toggle="tab" href="#avocati" role="tab" aria-controls="home" aria-selected="true"><h1>Avocati</h1></a>
			  </li>
			  <li class="nav-item">
			    <a class="nav-link" id="clienti-tab" data-toggle="tab" href="#clienti" role="tab" aria-controls="profile" aria-selected="false"><h1>Clienti</h1></a>
			  </li>
			</ul>
			<div class="tab-content" id="myTabContent">
			  <div class="tab-pane fade" id="avocati" role="tabpanel" aria-labelledby="avocati-tab">
				<div class="col-md-3 width-80 cazuri-form">
		        	<input type="text" id="my_input" onkeyup="filter()" placeholder="Cautare dupa numele avocatului...">
		        </div>
		        <form action="avocati_clienti.jsp" method="post">
		        	<div class="table-responsive-lg">
		            <table id="tabel_avocati" class="table table-striped table-dark my-table">
		                <tr>
		                    <th><b></b></th>
		                    <th><b>ID Avocat</b></th>
		                    <th><b>Prenumele avocatului</b></th>
		                    <th><b>Numele avocatului</b></th>
		                    <th><b>Functie</b></th>
		                    <th><b>Asociat</b></th>
		                </tr>
		                <%
		                    jb.connect();
		                    ResultSet rs = jb.afisareTabela("avocati");
		                    long x;
		                    while (rs.next()) {
		                        x = rs.getInt("idavocat");
		                %>
		                <tr>
		                    <td><input type="checkbox" name="primarykey" class="checkbox_avocati_delete checkbox_avocati_update" value="<%= x%>" /></td><td><%= x%></td>
		                    <td><%= rs.getString("prenume")%></td>
		                    <td><%= rs.getString("nume")%></td>
		                    <td><%= rs.getString("functie")%></td>
		                    <td><%= rs.getString("asociat")%></td>
		                </tr>
		                <%     
		                    }
				    		rs.close();
				            jb.disconnect();
						    
					     %>
		            </table><br/>
		            <div align="center" class="submit-btns">
					  <input id="check" type="submit" name="delete_avocat" class="btn btn-danger delete my_animation" value="Sterge avocatii selectati" disabled="disabled" onclick="return confirm('Esti sigur ca vrei sa stergi avocatii?')">
					  <input id="check2" type="submit" name="update_avocat" class="btn btn-warning delete my_animation" value="Modifica avocatul selectat" disabled="disabled">
					  <a href="adaugare_avocati_clienti.jsp"><button type="button" class="btn btn-dark my_animation">Adauga un nou avocat</button></a>
		            </div>
		            </div>
		        </form>
			  </div>
			  <div class="tab-pane fade" id="clienti" role="tabpanel" aria-labelledby="clienti-tab">
			  	<div class="col-md-3 width-80 cazuri-form">
		        	<input type="text" id="my_input2" onkeyup="filter2()" placeholder="Cautare dupa numele companiei...">
		        </div>
		        <form action="avocati_clienti.jsp" method="post">
		        	<div class="table-responsive-lg">
		            <table id="tabel_clienti" class="table table-striped table-dark my-table">
		                <tr>
		                    <th><b></b></th>
		                    <th><b>ID Client</b></th>
		                    <th><b>Companie</b></th>
		                    <th><b>Prenume reprezentant</b></th>
		                    <th><b>Nume reprezentant</b></th>
		                    <th><b>Domeniu</b></th>
		                </tr>
		                <%
		                    jb.connect();
		                    ResultSet rs2 = jb.afisareTabela("clienti");
		                    long x2;
		                    while (rs2.next()) {
		                        x2 = rs2.getInt("idclient");
		                %>
		                <tr>
		                    <td><input type="checkbox" name="primarykey2" class="checkbox_clienti_delete checkbox_clienti_update" value="<%= x2%>" /></td><td><%= x2%></td>
		                    <td><%= rs2.getString("denumire_firma")%></td>
		                    <td><%= rs2.getString("prenume_reprezentant")%></td>
		                    <td><%= rs2.getString("nume_reprezentant")%></td>
		                    <td><%= rs2.getString("domeniu")%></td>
		                </tr>
		                <%     
		                    }
				    		rs2.close();
				            jb.disconnect();
						    }
					     %>
		            </table><br/>
		            <div align="center" class="submit-btns">
					  <input id="check3" type="submit" name="delete_client" class="btn btn-danger btn-danger2 delete my_animation" value="Sterge clientii selectati" disabled="disabled" onclick="return confirm('Esti sigur ca vrei sa stergi clientii?')">
					  <input id="check4" type="submit" name="update_client" class="btn btn-warning btn-warning2 delete my_animation" value="Modifica clientul selectat" disabled="disabled">
					  <a href="adaugare_avocati_clienti.jsp"><button type="button" class="btn btn-dark my_animation">Adauga un nou client</button></a>
		            </div>
		            </div>
		        </form>
			  </div>
			</div>
		</div>
    </section>
    <footer>
    	<jsp:include page="footer.html" />
    </footer>
        
    <!-- JavaScript, Bootstrap js, jquery -->
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
	<script>
		<!-- Buton de stergere disabled/enabled avocati delete -->
		 $('.btn-danger').prop('disabled', !$('.checkbox_avocati_delete:checked').length); //initially disable/enable button based on checked length
		 $('input[type=checkbox]').click(function() {
		   console.log($('.checkbox_avocati_delete:checkbox:checked').length);
		   if ($('.checkbox_avocati_delete:checkbox:checked').length >= 1) {
		     $('.btn-danger').prop('disabled', false);
		   } else {
		     $('.btn-danger').prop('disabled', true);
		   }
		 });
		<!-- Buton de stergere disabled/enabled avocati update -->
		 $('.btn-warning').prop('disabled', !$('.checkbox_avocati_update:checked').length); //initially disable/enable button based on checked length
		 $('input[type=checkbox]').click(function() {
		   console.log($('.checkbox_avocati_update:checkbox:checked').length);
		   if ($('.checkbox_avocati_update:checkbox:checked').length == 1) {
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
			  table = document.getElementById("tabel_avocati");
			  tr = table.getElementsByTagName("tr");
			  for (i = 0; i < tr.length; i++) {
			    td = tr[i].getElementsByTagName("td")[3];
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
		<!-- Buton de stergere disabled/enabled clienti delete -->
		 $('.btn-danger2').prop('disabled', !$('.checkbox_clienti_delete:checked').length); //initially disable/enable button based on checked length
		 $('input[type=checkbox]').click(function() {
		   console.log($('.checkbox_clienti_delete:checkbox:checked').length);
		   if ($('.checkbox_clienti_delete:checkbox:checked').length >= 1) {
		     $('.btn-danger2').prop('disabled', false);
		   } else {
		     $('.btn-danger2').prop('disabled', true);
		   }
		 });
		<!-- Buton de stergere disabled/enabled clienti update -->
		 $('.btn-warning2').prop('disabled', !$('.checkbox_clienti_update:checked').length); //initially disable/enable button based on checked length
		 $('input[type=checkbox]').click(function() {
		   console.log($('.checkbox_clienti_update:checkbox:checked').length);
		   if ($('.checkbox_clienti_update:checkbox:checked').length == 1) {
		     $('.btn-warning2').prop('disabled', false);
		   } else {
		     $('.btn-warning2').prop('disabled', true);
		   }
		 });
		<!-- Filtrare tabel -->
		function filter2() {
			  var input, filter, table, tr, td, i, txtValue;
			  input = document.getElementById("my_input2");
			  filter = input.value.toUpperCase();
			  table = document.getElementById("tabel_clienti");
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

