<?php
$servername = "120.77.147.252";
$username = "root";
$password = "f7ea3512da";
$dbname = "myDB";

// 创建连接
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
    die("连接失败: " . $conn->connect_error);
}
 
$sql = "SELECT * FROM person";
$result = $conn->query($sql);
 
if ($result->num_rows > 0) {
    // 输出数据
    $data = array();
    while($row = $result->fetch_assoc()) {
    	$arr = array('url' => $row["image_url"], 'tid' => 'name');
    	$data[] = $arr;
    }
    $response = array('code' => 200, 'message' => 'success for data', 'list' => $data);

    echo json_encode($response);

    // $arr = array('dd' => 'kk' );
    // echo json_encode($arr);

} else {
    echo "0 结果";
}
$conn->close();
?>