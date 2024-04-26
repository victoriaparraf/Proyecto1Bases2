<?php
//include("dbConnection.php");

?>

<!DOCTYPE html>
<html lang="es">

<head>
    <title>Reportes</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="body dark-scheme">
    <style>
        body {
            background: #1c1c1c;
        }

        #caja {
            flex: 0 0 auto;
            display: block;


            width: 1000px;
            height: 800px;

            margin: 3% auto auto;
            padding: 60px;
            text-align: center;
        }

        #titulo {
            top: -10px;
            margin: -90px 10px 0px 0px;
            color: #FFFFFF;
        }

        /*
        #boton:hover,
        #boton:active {
            background: #FF0000;
        }
        */

        #fila {
            font-size: medium;
            text-align: left;
            padding: 8px;
            width: 90%;
        }

        .linea {
            height: 85px;
            outline: 5px #007ACC solid;
            padding: 10px 15px;
            border-radius: 5px;
            border: none;
            background-color: #FFFFFF;
        }

        .fechas {
            outline: 5px #007ACC solid;
            padding: 10px 15px;
            border-radius: 5px;
            margin-right: 25px;
            width: 5em;
            border: none;
            background-color: #FFFFFF;
        }

        .categorias {
            outline: 5px #007ACC solid;
            padding: 10px 15px;
            border-radius: 5px;
            margin-right: 25px;
            width: 10em;
            border: none;
            background-color: #FFFFFF;
        }

        .espacio {
            height: 20px;
        }

        .button {
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 10px 15px;
            gap: 15px;
            margin-right: 10px;
            background-color: #007ACC;
            outline: 3px #007ACC solid;
            outline-offset: -3px;
            border-radius: 5px;
            border: none;
            cursor: pointer;
            transition: 400ms;
        }

        #boton {
            color: white;
            font-weight: 700;
            font-size: 1em;
            transition: 400ms;
        }

        .button:hover {
            background-color: transparent;
        }

        #boton:hover {
            color: #007ACC;
        }
    </style>
    <div id="caja">
        <h2 id="titulo">Generador de Reportes</h2><br>
        <table>
            <thead>
                <th></th>
                <th></th>
            </thead>
            <tbody>
                <tr class="linea">
                    <td id="fila">
                        Reporte #1: Reporte de empleados por horas trabajadas
                    </td>
                    <td></td>
                    <td>
                        <button class="button" onclick="popupwindow('generar1.php','popup',1000,800);" id="boton">Generar</button>
                    </td>
                </tr>
                <tr class="espacio"></tr>
                <tr class="linea">
                    <td id="fila">
                        Reporte #2: Productos ordenados por cantidad de ventas
                    </td>
                    <td></td>
                    <td>
                        <button class="button" onclick="popupwindow('generar2.php','popup',1000,800);" id="boton">Generar</button>
                    </td>
                </tr>
                <tr class="espacio"></tr>
                <tr class="linea">
                    <td id="fila">
                        Reporte #3: Horas cumplidas por los empleados dado un mes especifico<br> (Selecciona una fecha)
                    </td>
                    <td>
                        <table>
                            <td>
                                <select name="mesR3" id="mesR3" class="fechas">
                                    <option value="Enero">Enero</option>
                                    <option value="Febrero">Febrero</option>
                                    <option value="Marzo">Marzo</option>
                                    <option value="Abril">Abril</option>
                                    <option value="Mayo">Mayo</option>
                                    <option value="Junio">Junio</option>
                                    <option value="Julio">Julio</option>
                                    <option value="Agosto">Agosto</option>
                                    <option value="Septiembre">Septiembre</option>
                                    <option value="Octubre">Octubre</option>
                                    <option value="Noviembre">Noviembre</option>
                                    <option value="Diciembre">Diciembre</option>
                                </select>
                            </td>
                            <td>
                                <select name="anoR3" id="anoR3" class="fechas">
                                    <option value="2023">2023</option>
                                    <option value="2022">2022</option>
                                    <option value="2021">2021</option>
                                </select>
                            </td>
                        </table>
                    </td>
                    <td>
                        <button class="button" onclick="generar3()" id="boton">Generar</button>
                    </td>
                </tr>
                <tr class="espacio"></tr>
                <tr class="linea">
                    <td id="fila">
                        Reporte #4: Productos filtrados por una categoria especifica y su cantidad en inventario (Selecciona una categoria)
                    </td>
                    <td>
                        <select name="catR4" id="catR4" class="categorias">
                            <option value="1">Medicamento</option>
                            <option value="2">Cuidado Personal</option>
                            <option value="3">Suplementos y Vitaminas</option>
                            <option value="4">Equipos y Dispositivos Médicos</option>
                            <option value="5">Botiquín</option>
                            <option value="6">Dietética</option>
                            <option value="7">Cosmética</option>
                            <option value="8">Infantil</option>
                            <option value="9">Ortopedia</option>
                        </select>
                    </td>
                    <td>
                        <button class="button" onclick="popupwindow('generar4.php','popup',1000,800);" id="boton">Generar</button>
                    </td>
                </tr>
                <tr class="espacio"></tr>
                <tr class="linea">
                    <td id="fila">
                        Reporte #5: Empleados actuales ordenados por sueldo
                    </td>
                    <td></td>
                    <td>
                        <button class="button" onclick="popupwindow('generar5.php','popup',1000,800);" id="boton">Generar</button>
                    </td>
                </tr>
                <tr class="espacio"></tr>
                <tr class="linea">
                    <td id="fila">
                        Reporte #6: Lista de productos ordenados por cantidad de productos en inventario
                    </td>
                    <td></td>
                    <td>
                        <button class="button" onclick="popupwindow('generar6.php','popup',1000,800);" id="boton">Generar</button>
                    </td>
                </tr>
                <tr class="espacio"></tr>
                <tr class="linea">
                    <td id="fila">
                        Reporte #7: Categorias mas vendidas por cada mes del año (Selecciona un año)
                    </td>
                    <td>
                        <select name="anoR7" id="anoR7" class="fechas">
                            <option value="2023">2023</option>
                            <option value="2022">2022</option>
                            <option value="2021">2021</option>
                        </select>
                    </td>
                    <td>
                        <button class="button" onclick="popupwindow('generar7.php','popup',1000,800);" id="boton">Generar</button>
                    </td>
                </tr>
                <tr class="espacio"></tr>
                <tr class="linea">
                    <td id="fila">
                        Reporte #8: Reporte Financiero
                    </td>
                    <td></td>
                    <td>
                        <button class="button" onclick="popupwindow('generar8.php','popup',1000,800);" id="boton">Generar</button>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>





</body>
<script>
    function popupwindow(url, title, w, h) {
        var left = (screen.width / 2) - (w / 2);
        var top = (screen.height / 2) - (h / 2);
        return window.open(url, title, 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);
    }

    function generar3() {
        let mes = document.getElementById('mesR3').value;
        let ano = document.getElementById('anoR3').value;
        popupwindow('generar3.php?mes=' + mes + '&ano=' + ano, 'popup', 1000, 800);
    }

    function generar4() {

    }

    function generar7() {

    }

    function generar8() {

    }
</script>