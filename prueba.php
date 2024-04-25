<?php 
include "db.php";
?>
<!DOCTYPE html>
<html lang="en">

<head>
    <script src="js/jquery.min.js"></script>
    <script src="js/popper.js"></script>
    <script src="js/bootstrap.min.js"></script>

    <!-- JQuery Datalist -->
    <script src="js/jquery.flexdatalist.min.js"></script>
    <link href="css/jquery.flexdatalist.css" rel="stylesheet">
</head>

<body>
    <form action="upload.php" method="post" enctype="multipart/form-data">
        Select image to upload:
        <input type="text" name="nombre">
        <input type="text" name="descripcion">
        <input type="file" name="image" />
        <input type='text' placeholder='Categorias' class='flexdatalist appearance-none block w-full bg-gray-200 text-gray-700 border border-gray-200 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500' data-min-length='0' data-selection-required='true' list='Categorias' data-search-by-word='true' data-value-property='value' id="categoria" name='categoria'>
        <datalist id="Categorias">
            <?php
            $query = "select * from categoria";
            $stmt = $sql->prepare($query);
            $stmt->execute();
            $rows = $stmt->fetchAll();
            foreach ($rows as $row) {
            ?>
                <option id="<?php echo $row['id_categoria'] ?>" value="<?php echo $row['id_categoria'] ?>"> <?php echo $row['nombre_categoria'] ?></option>
            <?php } ?>
        </datalist>
        <input type="submit" name="submit" value="UPLOAD" />
    </form>
</body>

</html>