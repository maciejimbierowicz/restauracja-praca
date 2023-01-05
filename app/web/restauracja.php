<?php include("config/functions.php"); 

ini_set('error_reporting', E_ALL);
ini_set('display_errors', 1);
$pdo = get_connection();

?>

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Restauracja</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="css/style.css" rel="stylesheet">
    </head>
    <body>
        <div class="main-content">
            <h2>Zarezerwuj stolik</h2>
            <form action="" method="POST">
                <label for="date">Data:</label>
                <input type="date" id="date" name="date">
                <br><br>
                <label for="time">Godzina:</label>
                <input type="time" id="time" name="time">
                <br><br>
                <label for="email">E-mail:</label>
                <input type="email" id="email" name="email">
                <br><br>
                <label for="phone">Telefon:</label>
                <input type="tel" id="phone" name="phone">
                <br><br>
                <label for="name">Imię i nazwisko:</label>
                <input type="text" id="name" name="name">
                <br><br>
                <label for="comment" maxlength="120">Komentarz:</label>
                <textarea id="comment" name="comment"></textarea>
                <br><br>
                <input type="submit" name="submit" value="Wyślij">
                <?php
                    if(isset($_SESSION['add']))
                    {
                        echo $_SESSION['add'];
                        unset($_SESSION['add']);
                    };
                ?>
            </form>
        </div>
    </body>
    
    <?php 

    if(isset($_POST['submit']))
    {   
        $date = $_POST['date'];
        $time = $_POST['time'];
        $email = $_POST['email'];
        $phone = $_POST['phone'];
        $name = $_POST['name'];
        $comment = $_POST['comment'];

        $sql = "INSERT INTO rezerwacje SET
        date=:date,
        time=:time,
        email=:email,
        phone=:phone,
        name=:name,
        comment=:comment
        ";

        $result = $pdo -> prepare($sql);
        $result->bindParam(':date', $date, PDO::PARAM_STR);
        $result->bindParam(':time', $time, PDO::PARAM_STR);
        $result->bindParam(':email', $email, PDO::PARAM_STR);
        $result->bindParam(':phone', $phone, PDO::PARAM_INT);
        $result->bindParam(':name', $name, PDO::PARAM_STR);
        $result->bindParam(':comment', $comment, PDO::PARAM_STR);
        $result->execute();
        
        if($result == true)
        {
            $_SESSION['add'] = "<div class='success'>Rezerwacja przyjęta</div>";
        }
        else
        {
            $_SESSION['add'] = "<div class='error'>Błąd przy tworzeniu rezerwacji</div>";
        }

    }
    ?>
</html>
