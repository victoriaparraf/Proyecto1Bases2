<?php
include "db.php";
require __DIR__ . '/vendor/autoload.php';

$mpdf = new \Mpdf\Mpdf();

$query = "CALL reporte1()";
$stmt = $sql->prepare($query);
$stmt->execute();
$rows = $stmt->fetchAll();
$i = 1;
$consulta = '';
foreach ($rows as $row) {
  $consulta = $consulta . '
    <tr>
        <th scope="row">' . $i . '</th>
        <td>' . $row['id_farmacia'] . '</td>
        <td>' . $row['capacidad'] . '</td>
    </tr>
    ';
  $i++;
}

$html = '<nav>
<img src="Assets/logo.png" width="170" height="90" style="margin: 2% 30% 2% 2%">
<h4 style="text-align: center;"> Reporte #1</h4>
<h5 style="text-align: center;"> Nombre de superhéroe o supervillano que poseen poderes artificiales y que han sido líderes </h5>
</nav>
<body>
<div style="margin: 3%">
    <table class="table table-striped table-dark">
        <thead>
          <tr>
            <th scope="col">#</th>
            <th scope="col">ID Farmacia</th>
            <th scope="col">Capacidad</th>
          </tr>
        </thead>
        <tbody>
          ' .
  $consulta
  . '</tbody>
        </table>
</div>

</body>';

$stylesheet = file_get_contents('Assets/kv-mpdf-bootstrap.css');
$mpdf->WriteHTML($stylesheet, 1); // CSS Script goes here.
$mpdf->WriteHTML($html, 2); //HTML Content goes here.
$mpdf->Output();
