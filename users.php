<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Авторизация</title>
</head>
<body>
    <h1>Авторизация</h1>
    <form method="post" action="users.php">
        <label for="username">Логин:</label>
        <input type="text" id="username" name="username"><br>
        <label for="password">Пароль:</label>
        <input type="password" id="password" name="password"><br>
        <input type="submit" value="Войти">
    </form>
</body>
</html>
<?php
// Подключение к базе данных rnc
$host = 'localhost'; // адрес сервера базы данных
$database = 'rnc'; // имя базы данных
$user = 'root'; // имя пользователя базы данных
$password = ''; // пароль пользователя базы данных
$link = mysqli_connect($host, $user, $password, $database)
    or die("Ошибка " . mysqli_error($link));

// Если форма отправлена, проверяем логин и пароль
if (!empty($_POST['username']) && !empty($_POST['password'])) {
    // Экранируем специальные символы в строке
    $username = mysqli_real_escape_string($link, $_POST['username']);
    $password = mysqli_real_escape_string($link, $_POST['password']);

    // Запрос к базе данных для проверки логина и пароля
    $query = "SELECT * FROM users WHERE username='$username' AND password='$password'";
    $result = mysqli_query($link, $query) or die("Ошибка " . mysqli_error($link));

    // Если найдена одна запись, то авторизация успешна
    if (mysqli_num_rows($result) == 1) {
        // Обновляем время последней авторизации
        $query = "UPDATE users SET last_login=NOW() WHERE username='$username'";
        mysqli_query($link, $query);

        // Перенаправляем на страницу funchion.php
        header("Location: funchion.php");
        exit();
    } else {
        // Выводим сообщение об ошибке
        echo "Ошибка: неверный логин или пароль";
    }
}

// Закрываем соединение с базой данных
mysqli_close($link);
?>