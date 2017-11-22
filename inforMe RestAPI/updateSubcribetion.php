<?php
$con=mysqli_connect("localhost","root","","inforMe");
if (mysqli_connect_errno())
{
	echo "Failed to connect to MySQL: " . mysqli_connect_error();
}

$Active=$_GET["Active"];
$CategoryId=$_GET["CategoryId"];
$UserId=$_GET["UserId"];

$sql = "UPDATE Subcribed SET Active='$Active' WHERE UserId='$UserId' AND CategoryId='$CategoryId'";

if ($con->query($sql) === TRUE) {
	$arr = array('Message' => 'Subcribed');
	echo json_encode($arr);
} else {
	$arr = array('Message' =>"Error: " . $sql . "<br>" . $conn->error);
	echo json_encode($arr);
}
mysqli_close($con);
?>