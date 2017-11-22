<?php
$con=mysqli_connect("localhost","root","","inforMe");
if (mysqli_connect_errno())
{
	echo "Failed to connect to MySQL: " . mysqli_connect_error();
}
$UserId=$_GET["UserId"];
$sql = "SELECT * FROM Subcribed WHERE UserId='$UserId'";

if ($result = mysqli_query($con, $sql))
{
	$resultArray = array();
	$tempArray = array();

	while($row = $result->fetch_object())
	{
		$tempArray=$row;
		array_push($resultArray, $tempArray);
	}
	echo json_encode($resultArray);
}
mysqli_close($con);
?>