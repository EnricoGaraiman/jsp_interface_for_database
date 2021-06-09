<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>
<!DOCTYPE html>
<html>
<head>
	<title>Adauga caz</title>
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
	<body>
	
        <%
        if(session.getAttribute("login")==null || session.getAttribute("login")==" "){ //check condition unauthorize user 
    		response.sendRedirect("index.jsp"); 
    	}
            int idavocat, idclient;
            String numeleCazului, id1, id2, numeAvocat, prenumeAvocat, numeReprezentantFirma, prenumeReprezentantFirma, denumireFirma, data, status, functie, domeniu;
            numeleCazului = request.getParameter("numeleCazului");
            id1 = request.getParameter("idavocat");
            id2 = request.getParameter("idclient");
            data = request.getParameter("data");
            status = request.getParameter("status");
            if (id1 != null) {
                jb.connect();
                jb.adaugaCaz(numeleCazului, java.lang.Integer.parseInt(id1), java.lang.Integer.parseInt(id2), data, status);
                jb.disconnect();
		   		out.println("<script type=\"text/javascript\">");
		        out.println("if(window.confirm('Datele au fost adaugate cu succes! Adaugati un caz nou?'))");
		  	    out.println("location='adauga_caz.jsp';");
		  	    out.println("else");
		  	    out.println("location='cazuri.jsp';");
		        out.println("</script>");
	        } else {
	        jb.connect();
	        ResultSet rs1 = jb.afisareTabela("avocati");
	        ResultSet rs2 = jb.afisareTabela("clienti");
        %>
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
			  <li class="nav-item">
			    <a class="nav-link" href="cazuri.jsp"><i class="fas fa-gavel"> </i> Cazurile firmei</a>
			  </li>
			  <li class="nav-item">
			    <a class="nav-link" href="adaugare_avocati_clienti.jsp"><i class="fas fa-user-plus"> </i> Adaugare Avocati & Clienti</a>
			  </li>
			  <li class="nav-item active">
			    <a class="nav-link" href="adauga_caz.jsp"><i class="fas fa-plus"> </i> Adaugare caz</a>
			  </li>
			  <li class="nav-item">
			  	<a class="nav-link btn btn-danger" href="logout.jsp"><i class="fas fa-sign-out-alt"> </i> Logout</a>
			  </li>
		    </ul>
		  </div>
		</nav>
	</header>
	<section class="secondary-bg d-flex h-100">
			<div class="adauga_caz justify-content-center align-self-center mx-auto">
	        <form action="adauga_caz.jsp" method="post">
           		<div class="form-group">
				  <label for="input1">Denumirea cazului</label>
				  <input name="numeleCazului" type="text" id="input1" class="form-control white-text" placeholder="Tastati denumirea cazului" size=30 required>
				</div>
				<div class="form-group">
				    <label for="select1">Avocatul reprezentant</label>               
					<select NAME="idavocat" class="form-control" id="select1" required>
				                  <%
				                    while(rs1.next()){
				                        idavocat = rs1.getInt("idavocat");
				                        numeAvocat = rs1.getString("nume");
				                        prenumeAvocat = rs1.getString("prenume");
				                        functie = rs1.getString("functie");
				                %>
				                    <option VALUE="<%= idavocat%>"><%= prenumeAvocat%> <%= numeAvocat%>, <%= functie %></option>
				                <%
				                    }
				                %>
					</select>   
				</div>
				<div class="form-group">
				   	<label for="select2">Clientul reprezentat</label>               
					<select NAME="idclient" class="form-control" id="select2" required>                   
				                   <%
				                     while(rs2.next()){
				                         idclient = rs2.getInt("idclient");
				                         numeReprezentantFirma = rs2.getString("nume_reprezentant");
				                         prenumeReprezentantFirma = rs2.getString("prenume_reprezentant");
				                         denumireFirma = rs2.getString("denumire_firma");
				                         domeniu = rs2.getString("domeniu");
				                 %>
				                     <option VALUE="<%= idclient%>"><%= denumireFirma%>, <%= prenumeReprezentantFirma%> <%= numeReprezentantFirma%>, <%= domeniu%></option>
				                 <%
				                     }
				                 %>
					</select>
				</div>
				
	            <div class="form-group">
				  <label for="start-date">Data cazului</label>
				  <input id="today" name="data" type="date"  class="form-control datepicker"/>
				</div>
				<div class="form-group">
				   	<label for="select3">Status</label>               
					<select NAME="status" class="form-control" id="select3" required>
				                  <option selected="In progres" value = "In progres">In progres</option>
				                  <option value = "Castigat">Castigat</option>
				                  <option value = "Pierdut">Pierdut</option>
					</select>	
				</div>
				<div align="center">
				      <input type="submit" class="btn btn btn-danger delete my_animation" value="Adaugare caz" onclick="return confirm('Esti sigur ca vrei sa adaugi acest caz?')"/>
				</div>
	        </form>
	        </div>
        </section>
        <footer>
        	<jsp:include page="footer.html" />
        </footer>
        <%
            }
        %>
        <!-- JavaScript Bootstrap -->
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
	<script>
		<!-- Data curenta in formular -->
		let today = new Date().toISOString().substr(0, 10);
		document.querySelector("#today").valueAsDate = new Date();
	</script>
</body>
</html>
