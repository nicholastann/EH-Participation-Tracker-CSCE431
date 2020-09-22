<?php
// Initialize the session
session_start();
 
// Check if the user is logged in, if not then redirect to login page
if(!isset($_SESSION["loggedin"]) || $_SESSION["loggedin"] !== true){
    header("location: login.php");
    exit;
}
 
// Include config file
require_once "config.php";
 
// Define variables and initialize with empty values
$new_UIN = $confirm_UIN = "";
$new_UIN_err = $confirm_UIN_err = "";
 
// Processing form data when form is submitted
if($_SERVER["REQUEST_METHOD"] == "POST"){
 
    // Validate new UIN
    if(empty(trim($_POST["new_UIN"]))){
        $new_UIN_err = "Please enter the new UIN.";     
    } elseif(strlen(trim($_POST["new_UIN"])) < 6){
        $new_UIN_err = "UIN must have atleast 6 characters.";
    } else{
        $new_UIN = trim($_POST["new_UIN"]);
    }
    
    // Validate confirm UIN
    if(empty(trim($_POST["confirm_UIN"]))){
        $confirm_UIN_err = "Please confirm the UIN.";
    } else{
        $confirm_UIN = trim($_POST["confirm_UIN"]);
        if(empty($new_UIN_err) && ($new_UIN != $confirm_UIN)){
            $confirm_UIN_err = "UIN did not match.";
        }
    }
        
    // Check input errors before updating the database
    if(empty($new_UIN_err) && empty($confirm_UIN_err)){
        // Prepare an update statement
        $sql = "UPDATE users SET UIN = ? WHERE id = ?";
        
        if($stmt = mysqli_prepare($link, $sql)){
            // Bind variables to the prepared statement as parameters
            mysqli_stmt_bind_param($stmt, "si", $param_UIN, $param_id);
            
            // Set parameters
            $param_UIN = $new_UIN;
            $param_id = $_SESSION["id"];
            
            // Attempt to execute the prepared statement
            if(mysqli_stmt_execute($stmt)){
                // UIN updated successfully. Destroy the session, and redirect to login page
                session_destroy();
                header("location: settings.php");
                exit();
            } else{
                echo "Oops! Something went wrong. Please try again later.";
            }

            // Close statement
            mysqli_stmt_close($stmt);
        }
    }
    
    // Close connection
    mysqli_close($link);
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
	<title>Reset UIN</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
<!--===============================================================================================-->	
	<link rel="icon" type="image/png" href="images/icons/favicon.ico"/>
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="fonts/iconic/css/material-design-iconic-font.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/select2/select2.min.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="vendor/daterangepicker/daterangepicker.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="css/util.css">
	<link rel="stylesheet" type="text/css" href="css/main.css">
<!--===============================================================================================-->
</head>
<body>
	
	<div class="limiter">
		<div class="container-login100" >
			<div class="wrap-login100">
                <form class="login100-form validate-form" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>" method="post"> 
                <h2>Reset UIN</h2>
					<span class="login100-form-title p-b-26">
                        Reset UIN
					</span>
				

					<div class="wrap-input100 validate-input" data-validate="Enter UIN">	
						<input class="input100" type="UIN" name="new_UIN">
						<span class="focus-input100" data-placeholder="New UIN"></span>
					</div>

					<div class="wrap-input100 validate-input" data-validate="Enter UIN">
						<input class="input100" type="UIN" name="confirm_UIN">
						<span class="focus-input100" data-placeholder="Confirm UIN"></span>
					</div>

					<div class="container-login100-form-btn">
						<div class="wrap-login100-form-btn">
							<div class="login100-form-bgbtn"></div>
							<button class="login100-form-btn" value="Submit">
								Submit
							</button>
						</div>
                    </div>
                    
                    <div class="container-login100-form-btn">
						<div class="wrap-login100-form-btn">
							<div class="login100-form-bgbtn"></div>
							<button href="home.php" class="login100-form-btn" value='cancel'>
								Cancel
							</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	

	<div id="dropDownSelect1"></div>
	
<!--===============================================================================================-->
<script src="vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/animsition/js/animsition.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/bootstrap/js/popper.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/select2/select2.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/daterangepicker/moment.min.js"></script>
	<script src="vendor/daterangepicker/daterangepicker.js"></script>
<!--===============================================================================================-->
	<script src="vendor/countdowntime/countdowntime.js"></script>
<!--===============================================================================================-->
	<script src="js/form.js"></script>

</body>
</html>