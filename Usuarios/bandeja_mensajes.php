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

$id_usuario_actual = $_SESSION['id_usuario']; // Asegúrate que esto esté guardado en el login

// Obtener mensajes recibidos
$sql_recibidos = "SELECT m.*, u.nombre_usuario AS emisor FROM mensajes m
                  JOIN usuarios u ON m.id_emisor = u.id_usuario
                  WHERE m.id_receptor = ?
                  ORDER BY m.fecha_envio DESC";
$stmt_recibidos = $conn->prepare($sql_recibidos);
$stmt_recibidos->bind_param("i", $id_usuario_actual);
$stmt_recibidos->execute();
$mensajes_recibidos = $stmt_recibidos->get_result();

// Obtener mensajes enviados
$sql_enviados = "SELECT m.*, u.nombre_usuario AS receptor FROM mensajes m
                 JOIN usuarios u ON m.id_receptor = u.id_usuario
                 WHERE m.id_emisor = ?
                 ORDER BY m.fecha_envio DESC";
$stmt_enviados = $conn->prepare($sql_enviados);
$stmt_enviados->bind_param("i", $id_usuario_actual);
$stmt_enviados->execute();
$mensajes_enviados = $stmt_enviados->get_result();
?>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Bandeja de Mensajes</title>
  <link rel="stylesheet" href="estilo.css">
</head>
<body>
<h2>📥 Mensajes Recibidos</h2>
<?php while ($row = $mensajes_recibidos->fetch_assoc()): ?>
  <div class="mensaje">
    <p><strong>De:</strong> <?php echo htmlspecialchars($row['emisor']); ?></p>
    <p><strong>Mensaje:</strong> <?php echo nl2br(htmlspecialchars($row['mensaje'])); ?></p>
    <p><strong>Fecha:</strong> <?php echo $row['fecha_envio']; ?></p>
    <?php if (!empty($row['archivo_url'])): ?>
      <p><a href="<?php echo htmlspecialchars($row['archivo_url']); ?>" download>📎 Descargar adjunto</a></p>
    <?php endif; ?>
  </div>
<?php endwhile; ?>

<h2>📤 Mensajes Enviados</h2>
<?php while ($row = $mensajes_enviados->fetch_assoc()): ?>
  <div class="mensaje enviado">
    <p><strong>Para:</strong> <?php echo htmlspecialchars($row['receptor']); ?></p>
    <p><strong>Mensaje:</strong> <?php echo nl2br(htmlspecialchars($row['mensaje'])); ?></p>
    <p><strong>Fecha:</strong> <?php echo $row['fecha_envio']; ?></p>
    <?php if (!empty($row['archivo_url'])): ?>
      <p><a href="<?php echo htmlspecialchars($row['archivo_url']); ?>" download>📎 Descargar adjunto</a></p>
    <?php endif; ?>
  </div>
<?php endwhile; ?>
</body>
</html>
