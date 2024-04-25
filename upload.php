<?php
include("db.php");
if (isset($_POST["submit"])) {
    $check = getimagesize($_FILES["image"]["tmp_name"]);
    if ($check !== false) {
        $image = $_FILES['image']['tmp_name'];
        $imgContent = file_get_contents($image);

        $nombre = $_POST['nombre'];
        $descripcion = $_POST['descripcion'];
        $query = "INSERT INTO `producto`(`id_producto`, `imagen_p`, `nombre_p`, `descripcion_p`, `fk_categoria`) VALUES (NULL, ?, ?, ?, ?)";
        $stmt = $sql->prepare($query);
        $stmt->bindParam(1, $imgContent, PDO::PARAM_STR);
        $stmt->bindParam(2, $nombre, PDO::PARAM_STR);
        $stmt->bindParam(3, $descripcion, PDO::PARAM_STR);
        $stmt->bindParam(4, $_POST['categoria'], PDO::PARAM_STR);
        $stmt->execute();

        echo "File uploaded successfully.";
        //echo $imgContent;
    } else {
        echo "Please select an image file to upload.";
    }
}
header("Location: prueba.php");