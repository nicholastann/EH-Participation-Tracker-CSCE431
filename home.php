<?php
	//Initialize the session
	session_start();
 
	//Check if the user is logged in, if not then redirect him to login page
	if(!isset($_SESSION["loggedin"]) || $_SESSION["loggedin"] !== true){
		header("location: login.php");
		exit;
	}

	// Include config file
	require_once "config.php";
 
	// Define variables and initialize with empty values
	$new_txt =  "";
	$new_txt_err = "";
	
	// Processing form data when form is submitted
	if($_SERVER["REQUEST_METHOD"] == "POST"){

			$new_txt = $_POST["txt"];
			
			// Prepare an update statement
			$sql = "UPDATE users SET txt = ? WHERE id = ?";
			
			if ($stmt = mysqli_prepare($link, $sql)){
				// Bind variables to the prepared statement as parameters
				mysqli_stmt_bind_param($stmt, "ii", $param_txt, $param_id);
				
				// Set parameters
				$param_txt = $new_txt;
				$param_id = $_SESSION["id"];
				$_SESSION["txt"] = $new_txt;
				
				// Attempt to execute the prepared statement
				if(mysqli_stmt_execute($stmt)){
					// Password updated successfully. Destroy the session, and redirect to login page
					header("location: home.php");
					exit();
				} 
				else {
					echo "Oops! Something went wrong. Please try again later.";
				}
				// Close statement
				mysqli_stmt_close($stmt);
			}
		// Close connection
		mysqli_close($link);
	}
?>


<!DOCTYPE html>
<html lang="en" class="no-js">

<head>
	<title>Hi, <?php echo htmlspecialchars($_SESSION["username"]); ?>. Welcome to Family Management.</h1></title>

	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="css/demo.css" />
	<link rel="stylesheet" type="text/css" href="css/component.css" />
	<script src="js/modernizr-custom.js"></script>


	<!-- Stylesheets -->
	<link rel="stylesheet" href="css/bootstrap.min.css"/>
	<link rel="stylesheet" href="css/font-awesome.min.css"/>
	<link rel="stylesheet" href="css/themify-icons.css"/>
	<link rel="stylesheet" href="css/accordion.css"/>
	<link rel="stylesheet" href="css/owl.carousel.min.css"/>
	<link rel="stylesheet" href="css/dashstyle.css"/>
</head>

<body>
	<!-- Page Preloder -->
	<div id="preloder"><div class="loader"></div></div>

	<title>Welcome.</title>

	<div class="colorlib-loader"></div>

	<!-- navigation -->
	<nav class="pages-nav">
		<div class="pages-nav__item"><a class="link link--page" href="#page-map">Locator</a></div>
		<div class="pages-nav__item" onclick='window.location = "calendar/index.html"'><a class="link link--page" href="calendar/index.html" >Calendar</a></div>
		<div class="pages-nav__item"><a class="link link--page" href="#page-lists">Lists</a></div>
		<div class="pages-nav__item" onclick='window.location = "photos/photos.html"'><a class="link link--page" href="photos/photos.html" >Photos</a></div>
		<div class="pages-nav__item"><a class="link link--page" href="#page-settings">Settings</a></div>
		<div class="pages-nav__item" onclick='window.location = "logout.php"'><a class="link link--page" href="logout.php">Sign Out </a></div>
	</nav>
	<!-- /navigation-->
	
	<!-- page stack -->
	<div class="pages-stack">

		<!-- Settings -->
		<div class="page" id="page-settings" style="background-image: url('images/4.png');background-size: cover;">
			<header class="bp-header cf"><h1 class="bp-header__title">Settings</h1></header>
					<button onclick='window.location = "resetemail.php"' class="button">reset email</button>
					<button onclick='window.location = "resetpassword.php"' class="button">reset password</button>
				</div>
			</h1>
		</div>
		<!-- /Settings -->


	</div>
	<!-- /pages-stack -->
	<button class="menu-button"><span>Menu</span></button>

	<!--====== Javascripts & Jquery ======-->
	<script src="js/classie.js"></script>
	<script src="js/main.js"></script>
	<script src="js/vendor/jquery-3.2.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/imagesloaded.pkgd.min.js"></script>
	<script src="js/isotope.pkgd.min.js"></script>
	<script src="js/jquery.nicescroll.min.js"></script>
	<script src="js/circle-progress.min.js"></script>
	<script src="js/dashmain.js"></script>
    <script src="js/bundle.js"></script>
	
</body>
</html>
