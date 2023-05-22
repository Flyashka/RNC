<?php
function insertTransaction($ls, $sum, $type) {
    // устанавливаем часовой пояс на Московское время
    date_default_timezone_set('Europe/Moscow');
    
    $datetime = date("Y-m-d H:i:s");
    $hash = md5($ls . $sum . $type . $datetime); // вычисляем хеш-код строки

    $servername = "localhost"; //Подключаемся к БД, на данном примере я использовал локальную сеть
    $username = "root";
    $password = "";
    $dbname = "rnc";

    // Подключаемся к БД
    $conn = new mysqli($servername, $username, $password, $dbname);

    // Проверяем соединение к БД
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    // Подготавливаем запрос к базе данных с заполнителями
    $stmt = $conn->prepare("INSERT INTO transaction (ls, sum, type, datetime, Valid, hash) VALUES (?, ?, ?, ?, 1, ?)");

    // Связываем параметры с заполнителями (со строкой выше)
    $stmt->bind_param("siiss", $ls, $sum, $type, $datetime, $hash);

    // выполняем запрос к базе данных
    $stmt->execute();

    // закрываем подготовленный запрос и соединение с базой данных
    $stmt->close();
    $conn->close();
}

insertTransaction(324874, 500, 1);

function transferData() {
    $servername = "localhost"; //Подключаемся к БД, данные должны быть индентичны тем, которые использовали для функции выше
    $username = "root";
    $password = "";
    $dbname = "rnc";

    // Создаем подключение к базе данных
    $conn = new mysqli($servername, $username, $password, $dbname);

    // Проверяем соединение
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    // Выбираем данные из таблицы "transaction", где "Valid" = 1
    $sql = "SELECT ls, sum, datetime, hash FROM transaction WHERE Valid = 1";
    $result = $conn->query($sql);

    // переносим данные в таблицу "data"
    if ($result->num_rows > 0) {
        while($row = $result->fetch_assoc()) {
            // проверяем, существует ли запись с таким же "ls" в таблице "data"
            $sql = "SELECT y FROM data WHERE ls = " . $row["ls"];
            $dataResult = $conn->query($sql);

            if ($dataResult->num_rows > 0) {
                // обновляем значение "y", "datetime" и "has" в таблице "data" на значения из таблицы "transaction"
                $dataRow = $dataResult->fetch_assoc();
                $y = $dataRow["y"] + $row["sum"];
                $sql = "UPDATE data SET y = " . $y . ", datetime = '" . $row["datetime"] . "', has = '" . $row["hash"] . "' WHERE ls = " . $row["ls"];
                $conn->query($sql);
            } else {
                // создаем новую запись в таблице "data" или обновляем значения "y", "datetime" и "has", если запись с таким же "ls" уже существует
                $sql = "INSERT INTO data (ls, y, datetime, has) VALUES (" . $row["ls"] . ", " . $row["sum"] . ", '" . $row["datetime"] . "', '" . $row["hash"] . "') ON DUPLICATE KEY UPDATE y = y + " . $row["sum"] . ", datetime = '" . $row["datetime"] . "', has = '" . $row["hash"] . "'";
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
