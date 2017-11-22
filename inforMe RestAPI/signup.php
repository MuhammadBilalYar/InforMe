<?php
$con=mysqli_connect("localhost","root","","inforMe");
if (mysqli_connect_errno())
{
	echo "Failed to connect to MySQL: " . mysqli_connect_error();
}
$firstName=$_POST["firstName"];
$lastName=$_POST["lastName"];
$emailAdd=$_POST["email"];
$password=$_POST["password"];
$imageurl=$_POST["img"];

$sql = "INSERT INTO LoginedUser(UserId,FirstName,LastName,Email,Password,ImageUrl) VALUES('NULL','$firstName','$lastName','$emailAdd','$password','$imageurl')";

if ($con->query($sql) === TRUE) {
	$arr = array('Message' => 'New record created successfully. \nClick on close and login please');
	echo json_encode($arr);
} else {
	$arr = array('Message' =>"Error: " . $sql . "<br>" . $conn->error);
	echo json_encode($arr);
}
mysqli_close($con);
?>