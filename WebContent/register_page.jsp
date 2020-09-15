<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="css/mystyle.css">
    <title>register</title>
    <style type="text/css">
    	.banner-background {
    		clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 91%, 53% 100%, 23% 91%, 0 100%, 0 0);
    	}
    </style>
</head>
<body>
	
	<!--navbar  -->
	<%@ include file="normal_navbar.jsp" %>

	<main>
		<div class="container-fluid primary-background  banner-background" style="padding-bottom: 80px;">
			<div class="row">
				<div class="col-md-6 offset-md-3">
					<div class="card">
						<div class="card-header text-center primary-background text-white">
							<span class="fa fa-user-circle fa-2x"></span>
							<br>
							<p>Register here...</p>
						</div>
						<div class="card-body">
							<form id="reg-form" action="registerServlet" method="post">
							  <div class="form-group">
							    <label for="user_name">User Name</label>
							    <input name="user_name"  type="text" class="form-control" id="user_name" aria-describedby="userHelp" placeholder="Enter name">
							  </div>
							  <div class="form-group">
							    <label for="exampleInputEmail1">Email address</label>
							    <input name="user_email" type="email" class="form-control" id="user_email" aria-describedby="emailHelp" placeholder="Enter email">
							    <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
							  </div>
							  <div class="form-group">
							    <label for="exampleInputPassword1">Password</label>
							    <input name="user_password" type="password" class="form-control" id="user_password" placeholder="Password">
							  </div>
							  <div class="form-group">
							    <label for="gender">Select Gender</label><br>
							    <input type="radio"  id="gender" name="gender" value="male">Male
							    <input type="radio"  id="gender" name="gender" value="female">Female
							  </div>
							  <div class="form-group">
							  	<textarea name="about" class="form-control" id="user_about" rows="" cols="" placeholder="enter something your self"></textarea>
							  </div>
							  <div class="form-check">
							    <input name="check" type="checkbox" class="form-check-input" id="exampleCheck1">
							    <label class="form-check-label" for="exampleCheck1">agree terms and conditions</label>
							  </div>
							  <br>
							  <div class="container text-center" id="loader" style="display: none;">
							  	<span class="fa fa-refresh fa-spin fa-4x"></span>
							  	<h4>Please wait...</h4>
							  </div>
							  <button id="submit-btn" type="submit" class="btn btn-primary">Submit</button>
							</form>
						</div>
					</div>					
				</div>
			</div>
		</div>
	</main>
	<!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
    <script type="text/javascript" src="js/myjs.js"></script>
    
    <script type="text/javascript">
    	$(document).ready(function(){
			console.log('loaded.....');
			$('#reg-form').on('submit', function(event){
				event.preventDefault();
				let form = new FormData(this);
				$('#submit-btn').hide();
				$('#loader').show();
				/* send data to register servlet */
				$.ajax({
					url: 'registerServlet',
					type: 'POST',
					data: form,
					success: function(data, textStatus, jqXHR){
						console.log(data);
						$('#submit-btn').show();
						$('#loader').hide();

						/* alert */
						if(data.trim() == 'done'){
							swal("Registered successfully... we are redirecting to login page!")
							.then((value) => {
						  		window.location="login-page.jsp";
							});
						}else {
							swal(data);		
						}
					},
					error: function(jqXHR, textStatus, errorThrown){
						$('#submit-btn').show();
						$('#loader').hide();
						swal("something went wrong... try again!");
					},
					processData: false,
					contentType: false					
				});				
			});
        });
    </script>
</body>
</html>