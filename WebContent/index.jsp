<!--
@author: Enrico Garaiman
-->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>

<jsp:useBean id="jb" scope="session" class="db.JavaBean" />
<jsp:setProperty name="jb" property="*" />
<%
	if(session.getAttribute("login")!=null) //check login session user not access or back to index.jsp page
	{
		response.sendRedirect("welcome.jsp");
	}

	jb.connect();
	
	if(request.getParameter("btn_login")!=null){
		String dbname, dbpassword, name,password, functie;
		
		name=request.getParameter("txt_name");
		password=request.getParameter("txt_password"); 
		
		ResultSet rs = jb.intoarceLinieDupaNume(name);
		
		if(rs.next() && rs.getString("parola") != null){
			dbname=rs.getString("nume");
			dbpassword=rs.getString("parola");
			functie=rs.getString("functie");
			if(name.equals(dbname) && password.equals(dbpassword) && (functie.equals("Partner") || functie.equals("Senior Partner") || functie.equals("Main Partner") || functie.equals("Managing Partner"))){
				session.setAttribute("login",dbname); 
				response.sendRedirect("welcome.jsp"); 
			}
			else {
				request.setAttribute("errorMsg","Parola este gresita sau nu aveti nivelul de acces necorespunzator!"); 
			}
		}
		else{
			request.setAttribute("errorMsg","Nu aveti acces la aceasta aplicatie, deoarece nu va regasiti printre avocatii firmei!"); // daca nu gaseste in baza de date utilizatorul, nu are acces la aplicatie
		}
		
		jb.disconnect(); //close connection	
	}

%>


<!DOCTYPE html>
<html>
<head>
	<title>Firma de avocatura</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no, user-scalable=no">
	
	<!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
	
	<!--  Icons -->
	<script src="https://kit.fontawesome.com/d8dbbaf693.js" crossorigin="anonymous"></script>
	
    <!-- CSS -->
    <link rel="stylesheet" href="./css/style.css">
</head>
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
		      <li class="nav-item active">
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
	<section class="home-bg d-flex h-100">
		<div class="container justify-content-center align-self-center mx-auto">
			<div class="jumbotron">
			  <h1 class="display-4"><i class="fas fa-sign-in-alt"> </i> LOGIN</h1>
			  <hr class="my-4">
			    <p><span style="color:#e60000;"><i class="fas fa-exclamation"> </i> 
			    </span>Pentru accesarea aplicatiei, trebuie sa va autentificati <span style="color:#e60000;"><i class="fas fa-exclamation"> </i> </span></p>
			  	<p style="color:#e60000;"><% 
			  		if(request.getAttribute("errorMsg") != null) {
			  			out.println(request.getAttribute("errorMsg"));
			  		}
			  	%></p>
			  	<form class="form-register" method="post" name="myform" onsubmit="return validate();">
                    <div class="form-row">
                        <label for="name">Nume</label>
                        <input type="text" class="form-control" name="txt_name" id="name" placeholder="Tastati numele...">
                    </div>

                    <div class="form-row">
                       <label for="password">Parola</label>
                       <input type="password" class="form-control" name="txt_password" id="password" placeholder="Tastati parola...">
                    </div>
					<br>
					<input type="submit" class="btn btn-danger my_animation" name="btn_login" value="Login">
        		</form>
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
		
		function validate()
		{
			var name = document.myform.txt_name;
			var password = document.myform.txt_password;
				
			if (name.value == null || name.value == "") //check name textbox not blank
			{
				window.alert("Adaugati numele"); //alert message
				name.focus();
				return false;
			}
			if (password.value == null || password.value == "") //check password textbox not blank
			{
				window.alert("Adaugati parola"); //alert message
				password.focus();
				return false;
			}
		}
			
	</script>
</body>
</html>