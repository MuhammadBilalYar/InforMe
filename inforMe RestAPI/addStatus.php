<?php
$con=mysqli_connect("localhost","root","","inforMe");
if (mysqli_connect_errno())
{
	echo "Failed to connect to MySQL: " . mysqli_connect_error();
}
$StatusText=$_POST["StatusText"];
$UpdatingTime=$_POST["UpdatingTime"];
$UserId=$_POST["UserId"];
$CategoryId=$_POST["CategoryId"];
$ImageUrl=$_POST["ImageUrl"];
$AudioUrl=$_POST["AudioUrl"];
$VideoUrl=$_POST["VideoUrl"];

$Latitude=$_POST["Latitude"];
$Longitude=$_POST["Longitude"];
$Address=$_POST["Address"];

$sql = "INSERT INTO Location(LocationId,Latitude,Longitude,Address) VALUES('NULL','$Latitude','$Longitude','$Address')";
$Message='';
if ($con->query($sql) === TRUE) {
	$LocationId = $con->insert_id;
	$sql1 = "INSERT INTO Status(StatusId,StatusText,UpdatingTime,StatusLike,StatusDislike,CategoryId,UserId,LocationId,AudioUrl,VideoUrl,ImageUrl,Report) VALUES('NULL','$StatusText','$UpdatingTime',0,0,'$CategoryId','$UserId','$LocationId','$AudioUrl','$VideoUrl','$ImageUrl',0)";
	if ($con->query($sql1) === TRUE) {
		$Message='INSERTED';
	} else {
		$Message="Error: " . $sql1 . "<br>" . $conn->error;		
	}
}else {
		$Message="Error: " . $sql . "<br>" . $conn->error;
	}
$arr = array('Message' => $Message);
echo json_encode($arr);
mysqli_close($con);
?>