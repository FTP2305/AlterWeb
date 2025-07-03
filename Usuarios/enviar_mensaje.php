<?php
session_start();
include '../Includes/conexion.php';


$conexion = new Conexion();
$conn = $conexion->getConectar();

// Verificar que el usuario ha iniciado sesión
if (!isset($_SESSION['id_usuario'])) {
    header('Location: ../Roles/Login.php');
    exit();
}

// Obtener todos los usuarios (excepto uno mismo)
$id_actual = $_SESSION['id_usuario'];
$usuarios = $conn->query("SELECT id_usuario, nombre_usuario FROM usuarios WHERE id_usuario != $id_actual");

?>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Enviar Mensaje</title>
</head>
<body>
  <h2>Enviar mensaje</h2>
  <form action="procesar_mensaje.php" method="POST" enctype="multipart/form-data">
    <label for="destinatario">Para:</label>
    <select name="destinatario" required>
      <option value="">Seleccione un usuario</option>
      <?php while ($row = $usuarios->fetch_assoc()): ?>
        <option value="<?= $row['id_usuario'] ?>"><?= htmlspecialchars($row['nombre_usuario']) ?></option>
      <?php endwhile; ?>
    </select><br><br>

    <label for="mensaje">Mensaje:</label><br>
    <textarea name="mensaje" rows="5" cols="50" required></textarea><br><br>

    <label for="archivo">Adjuntar archivo:</label>
    <input type="file" name="archivo"><br><br>

    <button type="submit">Enviar</button>
  </form>
</body>
</html>
