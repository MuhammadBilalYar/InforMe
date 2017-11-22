<?php
$con=mysqli_connect("localhost","root","","inforMe");
if (mysqli_connect_errno())
{
	echo "Failed to connect to MySQL: " . mysqli_connect_error();
}
$sql = "SELECT * FROM Status";

if ($result = mysqli_query($con, $sql))
{
	$resultArray = array();
	$tempArray = array();

	while($row = $result->fetch_object())
	{
		$tempArray['status']=$row;
		$tempArray['user']=getUser($row->UserId);
		$tempArray['cat']=getCategory($row->CategoryId);
		$tempArray['loc']=getLocation($row->LocationId);
		$tempArray['FeedBack']=getTotleFeedBack($row->StatusId);
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
function getCategory($catId){
	$con=mysqli_connect("localhost","root","","inforMe");
	if (mysqli_connect_errno())
	{
		echo "Failed to connect to MySQL: " . mysqli_connect_error();
	}
	$tempArray = array();
	$sql = "SELECT * FROM Category WHERE CategoryId='$catId'";
	if ($result = mysqli_query($con, $sql))
	{
		while($row = $result->fetch_object())
		{
			$tempArray = $row;
		}	
	}
	return $tempArray;
}
function getLocation($locId){
	$con=mysqli_connect("localhost","root","","inforMe");
	if (mysqli_connect_errno())
	{
		echo "Failed to connect to MySQL: " . mysqli_connect_error();
	}
	$tempArray = array();
	$sql = "SELECT * FROM Location WHERE LocationId='$locId'";
	if ($result = mysqli_query($con, $sql))
	{
		while($row = $result->fetch_object())
		{
			$tempArray = $row;
		}	
	}
	return $tempArray;
}

function getTotleFeedBack($Id){
	$con=mysqli_connect("localhost","root","","inforMe");
	if (mysqli_connect_errno())
	{
		echo "Failed to connect to MySQL: " . mysqli_connect_error();
	}
	$tempArray = array();
	$sql = "SELECT COUNT(StatusId) FROM FeedBack WHERE StatusId='$Id'";
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