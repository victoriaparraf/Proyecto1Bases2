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
        $stmt->bindParam(3, $_POST['categoria'], PDO::PARAM_STR);
        $stmt->execute();

        echo "File uploaded successfully.";
        //echo $imgContent;
    } else {
        echo "Please select an image file to upload.";
    }
}
$id = 1;
$query = "select * from producto where order by id_producto DESC";
$stmt = $sql->prepare($query);
$stmt->bindParam(1, $id, PDO::PARAM_STR);
$stmt->execute();
$row = $stmt->fetch();


echo '<img src="data:image/jpeg;base64,' . base64_encode($row['imagen_p']) . '">';
