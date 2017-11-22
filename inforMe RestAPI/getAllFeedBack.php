<?php
$con=mysqli_connect("localhost","root","","inforMe");
if (mysqli_connect_errno())
{
	echo "Failed to connect to MySQL: " . mysqli_connect_error();
}
$StatusId=$_GET["StatusId"];
$sql = "SELECT * FROM FeedBack WHERE StatusId='$StatusId'";

if ($result = mysqli_query($con, $sql))
{
	$resultArray = array();
	$tempArray = array();

	while($row = $result->fetch_object())
	{
		$tempArray['FeedBack']=$row;
		$tempArray['user']=getUser($row->UserId);
		array_push($resultArray, $tempArray);
	}
	echo json_encode($resultArray);
}
mysqli_close($con);

function getUser($UserId){
	$con=mysqli_connect("localhost","root","","inforMe");
	if (mysqli_connect_errno())
	{
		echo "Failed to connect to MySQL: " . mysqli_connect_error();
	}
	$tempArray = array();
	$sql = "SELECT * FROM LoginedUser WHERE UserId='$UserId'";
	if ($result = mysqli_query($con, $sql))
	{
		while($row = $result->fetch_object())
		{
			$tempArray = $row;
		}	
	}
	return $tempArray;
}
?>