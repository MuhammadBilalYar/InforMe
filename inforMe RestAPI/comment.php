'<?php
$con=mysqli_connect("localhost","root","","inforMe");
if (mysqli_connect_errno())
{
	echo "Failed to connect to MySQL: " . mysqli_connect_error();
}
$emailAdd=$_POST["email"];
$password=$_POST["password"];
$sql = "SELECT * FROM LoginedUser WHERE email='$emailAdd' AND Password='$password'";

if ($result = mysqli_query($con, $sql))
{
	$resultArray = array();
	$tempArray = array();

	while($row = $result->fetch_object())
	{
		$tempArray = $row;
		array_push($resultArray, $tempArray);
	}
	echo json_encode($resultArray);
}
mysqli_close($con);
?>