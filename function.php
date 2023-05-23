<?php
function insertTransaction($ls, $sum2) {
    // устанавливаем часовой пояс на Московское время
    date_default_timezone_set('Europe/Moscow');

    // получаем текущую дату и время
    $datetime = date("Y-m-d H:i:s");

    // устанавливаем соединение с базой данных
    $servername = "localhost";
    $username = "root";
    $password = "";
    $dbname = "rnc";
    $conn = new mysqli($servername, $username, $password, $dbname);

    // проверяем соединение
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }
    if ($sum2 <= 0) {
    echo "Ошибка! Сумма пополнения не может быть меньше или равна 0";
    return;
}

    // получаем значение conversion_rate из таблицы conversion
    $type = "online";
    $stmt = $conn->prepare("SELECT conversion_rate, last_operation_datetime FROM conversion WHERE type = ?");
    $stmt->bind_param("s", $type);
    $stmt->execute();
    $result = $stmt->get_result();

    // проверяем, что получены данные из таблицы conversion
    if ($result->num_rows == 1) {
        $row = $result->fetch_assoc();
        $conversion_rate = $row["conversion_rate"];
        $last_operation_datetime = $row["last_operation_datetime"];

        // вычисляем значение суммы в рублях
        $sum = $sum2 * $conversion_rate;

        // вычисляем хеш-код строки
        $hash = md5($ls . $datetime);

        // подготавливаем запрос к базе данных с заполнителями
        $stmt = $conn->prepare("INSERT INTO transaction (ls, sum, datetime, valid, hash, conversion_rate) VALUES (?, ?, ?, 1, ?, ?)");

        // связываем параметры с заполнителями
        $stmt->bind_param("isssd", $ls,$sum, $datetime, $hash, $conversion_rate);

        // выполняем запрос к базе данных
        if ($stmt->execute() === TRUE) {
            echo "Новая запись успешна созданна";
            
            // обновляем время в таблице "conversion"
            $current_datetime = date("Y-m-d H:i:s");
            if ($current_datetime != $last_operation_datetime) {
                $stmt = $conn->prepare("UPDATE conversion SET last_operation_datetime = ?");
                $stmt->bind_param("s", $current_datetime);
                $stmt->execute();
            }
        } else {
            echo "Error: " . $stmt->error;
        }

        // закрываем подготовленный запрос и соединение с базой данных
        $stmt->close();
        $conn->close();
    } else {
        echo "Error: no data found in conversion table or record is not uniq";
    }
}

if(isset($_POST['submit'])) {
  $ls = $_POST['ls'];
  $sum2 = $_POST['sum'];
  insertTransaction($ls, $sum2);
}

function transferData() {
    $servername = "localhost";
    $username = "root";
    $password = "";
    $dbname = "rnc";

    // создаем подключение к базе данных
    $conn = new mysqli($servername, $username, $password, $dbname);

    // проверяем соединение
    if ($conn->connect_error) {
        die("Connection failed: ". $conn->connect_error);
    }

    // выбираем данные из таблицы "transaction", где "Valid" = 1
    $sql = "SELECT ls, sum, datetime, hash FROM transaction WHERE Valid = 1";
    $result = $conn->query($sql);

    // переносим данные в таблицу "data"
    if ($result->num_rows > 0) {
        while($row = $result->fetch_assoc()) {
            // проверяем, существует ли запись с таким же "ls" в таблице "data"
            $sql = "SELECT y, hash FROM data WHERE ls = " . $row["ls"];
            $dataResult = $conn->query($sql);

            if ($dataResult->num_rows > 0) {
                // получаем значение "y" и "hash" из таблицы "data"
                $dataRow = $dataResult->fetch_assoc();

                // обновляем значение "y", "datetime" и "hash" в таблице "data" на значения из таблицы "transaction"
                $y = $dataRow["y"] + $row["sum"];
                $hash = $row["hash"] . $row["sum"];
                $sql = "UPDATE data SET y = " . $y . ", datetime = '" . $row["datetime"] . "', hash = '" . $hash . "' WHERE ls =" . $row["ls"];
                $conn->query($sql);
            } else {
                // создаем новую запись в таблице "data"
                $sql = "INSERT INTO data (ls, y, datetime, hash) VALUES (" . $row["ls"] . ", " . $row["sum"] . ", '" . $row["datetime"] . "', '" . $row["hash"] . "')";
                $conn->query($sql);
            }

            // обновляем значение "Valid" в таблице "transaction" на 0
            $sql = "UPDATE transaction SET Valid = 0 WHERE ls = " . $row["ls"];
            $conn->query($sql);
        }
    }

    // закрываем соединение с базой данных
    $conn->close();
}

transferData();
?>
<!DOCTYPE html>
<html>
<head>
  <title>Insert Transaction</title>
</head>
<body>
  <form method="post" action="">
    <label for="ls">Номер лицевого счёта:</label>
    <input type="text" name="ls" id="ls"><br><br>
    <label for="sum">Сумма:</label>
    <input type="text" name="sum" id="sum"><br><br>
    <input type="submit" name="submit" value="Выполнить транзакцию">
  </form>
</body>
</html>


