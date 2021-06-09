<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>
<!DOCTYPE html>
<html>
<head>
	<title>Actualizare client</title>
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
<body class="secondary-bg">
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
	<%
	if(session.getAttribute("login")==null || session.getAttribute("login")==" "){ //check condition unauthorize user 
		response.sendRedirect("index.jsp"); 
	}
	if (request.getParameter("denumireFirma") != null) {
		jb.connect();
        int aux = java.lang.Integer.parseInt(request.getParameter("idclient"));
        String numeReprezentant = request.getParameter("numeReprezentant");
        String prenumeReprezentant = request.getParameter("prenumeReprezentant");
        String denumireFirma = request.getParameter("denumireFirma");
        String domeniu = request.getParameter("domeniu");

        String[] valori = {numeReprezentant, prenumeReprezentant, denumireFirma, domeniu};
        String[] campuri = {"nume_reprezentant", "prenume_reprezentant", "denumire_firma", "domeniu"};
        jb.modificaTabela("clienti", "idclient", aux, campuri, valori);
        jb.disconnect();
        out.println("<script type=\"text/javascript\">");
        out.println("alert('Clientul selectat au fost actualizate cu succes');");
  	    out.println("location='avocati_clienti.jsp';");
        out.println("</script>");
	} else {
		jb.connect();
        int aux = java.lang.Integer.parseInt(request.getParameter("primarykey2"));
        ResultSet rs = jb.intoarceLinieDupaId("clienti", "idclient", aux);
        rs.first();
        String numeReprezentant = rs.getString("nume_reprezentant");
        String prenumeReprezentant = rs.getString("prenume_reprezentant");
        String denumireFirma = rs.getString("denumire_firma");
        String domeniu = rs.getString("domeniu");
        rs.close();
        jb.disconnect();
        %>
	<section class="adauga_caz container d-flex h-100">
		<div class="justify-content-center align-self-center mx-auto">
        <form action="update_client.jsp" method="post">
        <div class="form-group">
				    <label for="input">ID Client</label>
					<input type="text" id="input" class="form-control" name="idclient" size="30" value="<%= aux%>" readonly/>
           		</div>
        		<div class="form-group">
				  <label for="input1">Prenumele reprezentantului</label>
				  <input name=prenumeReprezentant type="text" id="input1" value="<%= prenumeReprezentant%>" class="form-control white-text" placeholder="Tastati prenumele reprezentantului" size=30 required>
				</div>
				<div class="form-group">
				  <label for="input1">Numele reprezentantului</label>
				  <input name="numeReprezentant" type="text" id="input1" value="<%= numeReprezentant%>" class="form-control white-text" placeholder="Tastati numele reprezentantului" size=30 required>
				</div>
				<div class="form-group">
				  <label for="input1">Denumirea companiei</label>
				  <input name="denumireFirma" type="text" id="input1" value="<%= denumireFirma%>" class="form-control white-text" placeholder="Tastati denumirea companiei" size=30 required>
				</div>
				<div class="form-group">
				  <label for="input1">Domeniu</label>
				  <input name="domeniu" type="text" id="input1" value="<%= domeniu%>" class="form-control white-text" placeholder="Tastati domeniul(optional)" size=30>
				</div>
			    <input type="submit" name="update_client" class="btn btn btn-danger delete my_animation" value="Actualizare client" onclick="return confirm('Esti sigur ca vrei sa modifici clientul?')"/>
				</form>
            </div>
            </section>
    	<footer>
        	<jsp:include page="footer.html" />
        </footer>
    </body>
    <%
        rs.close();
        jb.disconnect();
	}
    %>
<!-- JavaScript Bootstrap -->
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</body>
</html>