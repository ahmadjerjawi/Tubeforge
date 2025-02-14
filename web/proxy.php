<?php

// Set CORS headers
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header('Access-Control-Allow-Credentials: true');
header('Access-Control-Allow-Headers: Origin, Content-Type, Authorization, X-Requested-With');

// Function to get headers for PHP versions below 5.4
function getallheaders_compat() {
    $headers = array();
    foreach ($_SERVER as $name => $value) {
        if (substr($name, 0, 5) === 'HTTP_') {
            $header = str_replace(' ', '-', ucwords(str_replace('_', ' ', strtolower(substr($name, 5)))));
            $headers[$header] = $value;
        }
    }
    return $headers;
}

// Retrieve request headers
$headers = array();
foreach (getallheaders_compat() as $header_name => $header_value) {
    if (stripos($header_name, 'Content-Type') === 0 || stripos($header_name, 'Authorization') === 0 || stripos($header_name, 'X-Requested-With') === 0) {
        $headers[] = strtolower($header_name) . ": " . $header_value;
    }
}

// Check if the request is JSON
$is_json_request = false;
$input_data = file_get_contents("php://input");
$is_json_string_request = json_decode($input_data);

if ($is_json_string_request !== null) {
    $is_json_request = true;
    // Request validation
    if (!isset($is_json_string_request->method) || empty($is_json_string_request->method)) {
        echo json_encode(array("message" => "PROXY ACCESS DENIED! Request method not specified"));
        exit();
    }
    if (!isset($is_json_string_request->cors) || empty($is_json_string_request->cors)) {
        echo json_encode(array("message" => "PROXY ACCESS DENIED! CORS endpoint not specified"));
        exit();
    }

    $url = $is_json_string_request->cors;
    $method = $is_json_string_request->method;
} else {
    // Raw request handling for non-JSON data
    if (!isset($_REQUEST['method']) || empty($_REQUEST['method'])) {
        echo json_encode(array("message" => "PROXY ACCESS DENIED! Request method not specified"));
        exit();
    }
    if (!isset($_REQUEST['cors']) || empty($_REQUEST['cors'])) {
        echo json_encode(array("message" => "PROXY ACCESS DENIED! CORS endpoint not specified"));
        exit();
    }

    $url = $_REQUEST['cors'];
    $method = $_REQUEST['method'];
}

// Handle POST or GET request
$curl = curl_init();
switch (strtoupper($method)) {
    case "POST":
        $post_data = $is_json_request ? (array)$is_json_string_request : $_POST;
        unset($post_data['cors'], $post_data['method']);
        $post_parameters = $is_json_request ? json_encode($post_data) : http_build_query($post_data);

        curl_setopt_array($curl, array(
            CURLOPT_URL            => $url,
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_CUSTOMREQUEST  => "POST",
            CURLOPT_POSTFIELDS     => $post_parameters,
            CURLOPT_HTTPHEADER     => $headers,
            CURLOPT_SSL_VERIFYPEER => false, // Disabling SSL verification for older versions
        ));
        break;

    case "GET":
        $get_data = $is_json_request ? (array)$is_json_string_request : $_GET;
        unset($get_data['cors'], $get_data['method']);
        $get_params = http_build_query($get_data);

        curl_setopt_array($curl, array(
            CURLOPT_URL            => $url . "?" . $get_params,
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_HTTPHEADER     => $headers,
            CURLOPT_SSL_VERIFYPEER => false, // Disabling SSL verification for older versions
        ));
        break;

    default:
        echo json_encode(array("message" => "Proxy only allows POST and GET requests"));
        exit();
}

$response = curl_exec($curl);
$err = curl_error($curl);
curl_close($curl);

if ($err) {
    echo json_encode(array("error" => $err));
} else {
    // Set response content-type based on response type
    if ($is_json_request && $response !== null && json_decode($response) !== null) {
        header('Content-Type: application/json');
    }
    echo $response;
}
?>
