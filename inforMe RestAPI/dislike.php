<?php
$con=mysqli_connect("localhost","root","","inforMe");
if (mysqli_connect_errno())
{
	echo "Failed to connect to MySQL: " . mysqli_connect_error();
}
$dislike=$_GET["dislike"];
$id=$_GET["id"];
$sql = "UPDATE Status SET StatusDislike='$dislike' WHERE StatusId='$id'";

if ($con->query($sql) === TRUE) {
	$arr = array('Message' => 'Dislike');
	echo json_encode($arr);
} else {
	$arr = array('Message' =>"Error: " . $sql . "<br>" . $conn->error);
	echo json_encode($arr);
}
mysqli_close($con);
?>