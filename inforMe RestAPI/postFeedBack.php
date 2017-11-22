<?php
$con=mysqli_connect("localhost","root","","inforMe");
if (mysqli_connect_errno())
{
	echo "Failed to connect to MySQL: " . mysqli_connect_error();
}
$FeedBackBody=$_POST["FeedBackBody"];
$StatusId=$_POST["StatusId"];
$UserId=$_POST["UserId"];
$Time=$_POST["Time"];

$sql = "INSERT INTO FeedBack(FeedBackID,FeedBackBody,StatusId,UserId,Time) VALUES('NULL','$FeedBackBody','$StatusId','$UserId','$Time')";

if ($con->query($sql) === TRUE) {
	$arr = array('Message' => 'POSTED');
	echo json_encode($arr);
} else {
	$arr = array('Message' =>"Error: " . $sql . "<br>" . $conn->error);
	echo json_encode($arr);
}
mysqli_close($con);
?>