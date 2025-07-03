<?php
session_start();
include 'Includes/conexion.php';
$conexion = new Conexion();
$conn = $conexion->getConectar();

session_start();
if (!isset($_SESSION['id_usuario'])) {
    header('Location: ../Roles/Login.php');
    exit();
}


$id_emisor = $_SESSION['id_usuario']; // Asegúrate de que esté logueado
$id_receptor = $_POST['id_receptor'];
$asunto = $_POST['asunto'];
$mensaje = $_POST['mensaje'];
$archivo_url = null;

// Procesar archivo si se subió
if (isset($_FILES['archivo']) && $_FILES['archivo']['error'] === 0) {
    $nombre_archivo = basename($_FILES["archivo"]["name"]);
    $ruta_destino = "archivos_mensajes/" . $nombre_archivo;

    if (move_uploaded_file($_FILES["archivo"]["tmp_name"], $ruta_destino)) {
        $archivo_url = $ruta_destino;
    }
}

// Insertar en la base de datos
$stmt = $conn->prepare("INSERT INTO mensajes (id_emisor, id_receptor, asunto, mensaje, archivo_url) VALUES (?, ?, ?, ?, ?)");
$stmt->bind_param("iisss", $id_emisor, $id_receptor, $asunto, $mensaje, $archivo_url);
$stmt->execute();

header("Location: bandeja_mensajes.php");
exit();
?>
