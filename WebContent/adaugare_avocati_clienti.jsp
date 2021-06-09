<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>
<!DOCTYPE html>
<html>
<head>
	<title>Adaugare avocati & clienti</title>
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
    if (request.getParameter("adaugare_avocat") != null) {
   
        String numeAvocat = request.getParameter("numeAvocat");
        String prenumeAvocat = request.getParameter("prenumeAvocat");
        String functie = request.getParameter("functie");
        String asociat = request.getParameter("asociat");
        String parola = request.getParameter("parola");
        jb.connect();
        jb.adaugaAvocat(numeAvocat, prenumeAvocat, functie, asociat, parola);
        jb.disconnect();
        out.println("<script type=\"text/javascript\">");
        out.println("if(window.confirm('Avocatul a fost adaugat cu succes! Adaugati un alt avocat?'))");
  	    out.println("location='adaugare_avocati_clienti.jsp';");
  	    out.println("else");
  	    out.println("location='avocati_clienti.jsp';");
        out.println("</script>");
    } else if (request.getParameter("adaugare_client") != null) {
    	String numeReprezentant = request.getParameter("numeReprezentant");
        String prenumeReprezentant = request.getParameter("prenumeReprezentant");
        String denumireFirma = request.getParameter("denumireFirma");
        String domeniu = request.getParameter("domeniu");
        jb.connect();
        jb.adaugaClient(numeReprezentant, prenumeReprezentant, denumireFirma, domeniu);
        jb.disconnect();
        out.println("<script type=\"text/javascript\">");
        out.println("if(window.confirm('Clientul a fost adaugat cu succes! Adaugati un alt client?'))");
  	    out.println("location='adaugare_avocati_clienti.jsp';");
  	    out.println("else");
  	    out.println("location='avocati_clienti.jsp';");
        out.println("</script>");	
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
			  <li class="nav-item">
			    <a class="nav-link" href="cazuri.jsp"><i class="fas fa-gavel"> </i> Cazurile firmei</a>
			  </li>
			  <li class="nav-item active">
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
	<section class="secondary-bg d-flex h-100">
	<div class="justify-content-center align-self-center mx-auto">
		<div id="accordion">
		  <div class="card">
		    <div class="card-header" id="headingOne">			
		    <a class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseOne" aria-expanded="false" aria-controls="collapseOne">
		      <h3 class="mb-0">
		          Avocati
		      </h3>
		    </a>
		    </div>
		    <div id="collapseOne" class="collapse" aria-labelledby="headingOne" data-parent="#accordion">
		      <div class="card-body">
		        <form action="adaugare_avocati_clienti.jsp" method="post">
           		<div class="form-group">
				  <label for="input1">Prenumele avocatului</label>
				  <input name=prenumeAvocat type="text" id="input1" class="form-control white-text" placeholder="Tastati prenumele avocatului" size=30 required>
				</div>
				<div class="form-group">
				  <label for="input1">Numele avocatului</label>
				  <input name="numeAvocat" type="text" id="input1" class="form-control white-text" placeholder="Tastati numele avocatului" size=30 required>
				</div>
				<div class="form-group">
				  <label for="input1">Functia</label>
				  <select NAME="functie" class="form-control" id="select3" required>
	                  <option selected="Junior Associate" value = "Junior Associate">Junior Associate</option>
	                  <option value = "Senior Associate">Senior Associate</option>
	                  <option value = "Partner">Partner</option>
	                  <option value = "Senior Partner">Senior Partner</option>
	                  <option value = "Main Partner">Main Partner</option>
	                  <option value = "Managing Partner">Managing Partner</option>
					</select>	
				</div>
				<div class="form-group">
				  <label for="input1">Asociat</label>
				  <input name="asociat" type="text" id="input1" class="form-control white-text" placeholder="Tastati asociatul(optional)" size=30>
				</div>
				<div class="form-group">
				  <label for="input1">Parola</label>
				  <input name="parola" type="text" id="input1" class="form-control white-text" placeholder="Tastati parola(optional)" size=30>
				</div>
			    <input type="submit" name="adaugare_avocat" class="btn btn btn-danger delete my_animation" value="Adaugare avocat" onclick="return confirm('Esti sigur ca vrei sa adaugi avocatul?')"/>
				</form>
		      </div>
		    </div>
		  </div>
		  <div class="card">
		    <div class="card-header" id="headingTwo">
		  	<a class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
		      <h3 class="mb-0">
		          Clienti   
		      </h3>
		    </a>
		    </div> 
		    <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordion">
		      <div class="card-body">
			  <form action="adaugare_avocati_clienti.jsp" method="post">
           		<div class="form-group">
				  <label for="input1">Prenumele reprezentantului</label>
				  <input name=prenumeReprezentant type="text" id="input1" class="form-control white-text" placeholder="Tastati prenumele reprezentantului" size=30 required>
				</div>
				<div class="form-group">
				  <label for="input1">Numele reprezentantului</label>
				  <input name="numeReprezentant" type="text" id="input1" class="form-control white-text" placeholder="Tastati numele reprezentantului" size=30 required>
				</div>
				<div class="form-group">
				  <label for="input1">Denumirea companiei</label>
				  <input name="denumireFirma" type="text" id="input1" class="form-control white-text" placeholder="Tastati denumirea companiei" size=30 required>
				</div>
				<div class="form-group">
				  <label for="input1">Domeniu</label>
				  <input name="domeniu" type="text" id="input1" class="form-control white-text" placeholder="Tastati domeniul(optional)" size=30>
				</div>
			    <input type="submit" name="adaugare_client" class="btn btn btn-danger delete my_animation" value="Adaugare client" onclick="return confirm('Esti sigur ca vrei sa adaugi clientul?')"/>
				</form>		     
			   </div>
		    </div>
		  </div>	
		</div>
	</div>    
    </section>
    <footer>
    	<jsp:include page="footer.html" />
    </footer>   
    <%
    }
    %>     
    <!-- JavaScript, Bootstrap js, jquery -->
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</body>
</html>

