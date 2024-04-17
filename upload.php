<?php
if(isset($_POST["submit"])){
    $check = getimagesize($_FILES["image"]["tmp_name"]);
    if($check !== false){
        $image = $_FILES['image']['tmp_name'];
        $imgContent = file_get_contents($image);
        echo "File uploaded successfully.";
        echo $imgContent;
    }else{
        echo "Please select an image file to upload.";
    }
}
echo '<img src="data:image/jpeg;base64,' . base64_encode($imgContent) . '">';
?>
