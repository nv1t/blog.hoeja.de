YASI #i don&#039;t count anymore
################################
:date: 2012-02-24 19:29
:tags: de, pastebin, wtf, yasi

Ist da nicht sogar noch mehr machbar? Ich lasse das studieren des Codes
dem geuebten Leser offen. Have fun!

::




    <?
    include("functions.php");
    include("network.php");
    switch ($_GET["view"])
    {
    case "2";
    $id = $_GET["view"];

    break;
    default:
    $username = "";
    $password = "";
    if (isset($_POST["Username"]) && isset($_POST["Password"]))
    {
    $username = $_POST["Username"];
    $password = $_POST["Password"];
    $password2 = $_POST["Password2"];
    $email = $_POST["Email"];
    $email2 = $_POST["Email2"];
    $first = $_POST["FirstName"];
    $last = $_POST["LastName"];
    $agree = $_POST["agree"];
    $gender = $_POST["select"];
    $number = 0;
    if($username == "")
    {
        $msg = "- Please enter a username you wish to use!";
    }
    else
    {
        $number = $number + "1";
    }
    if($password == "")
    {
        $msg2 = "- Please enter a password you wish to use!";
    }
    else
    {
        $number = $number + "1";
    }
    if($password2 == "")
    {
        $msg3 = "- Please repeat your password to verify its correct!";
    }
    else
    {
        $number = $number + "1";
    }
    if($email == "")
    {
        $msg3 = "- Please enter your email address!";
    }
    else
    {
        $number = $number + "1";
    }
    if($email2 == "")
    {
        $msg4 = "- Please repeat your email address to verify its correct!";
    }
    else
    {
        $number = $number + "1";
    }
    if($first == "")
    {
        $msg5 = "- Please enter your first name!";
    }
    else
    {
        $number = $number + "1";
    }
    if($last == "")
    {
        $msg6 = "- Please enter your last name!";
    }
    else
    {
        $number = $number + "1";
    }
    if($agree == "")
    {
        $msg7 = "- Please agree to the terms and conditions!";
    }
    else
    {
        $number = $number + "1";
    }
    if($email2 == $email)
    {
    $number = $number + "1";
    }
    else
    {
    $msg9 = "- Your repeated email password is incorrect!";
    }
    if($password2 == $password)
    {
    $number = $number + "1";
    }
    else
    {
    $msg9 = "- Your repeated password is incorrect!";
    }
    if($number < 10)
    {
    echo("


    $msg$msg2$msg3$msg4$msg5$msg6$msg7$msg8$msg9 


    ");
    }
    else
    {
    $check = mysql_query("SELECT * FROM `users` WHERE `username` = '$username'");
    $check2 = mysql_num_rows($check);
    if($check2 > 0)
    {
    $msg10 = "- That username is already in use!";
    }
    else
    {
    $number1 = $number1 + "1";
    }
    $dis = mysql_query("SELECT * FROM `users` WHERE `email` = '$email'");
    $dis2 = mysql_num_rows($dis);
    if($dis2 > 0)
    {
    $msg11 = "- That email is already in use!";
    }
    else
    {
    $number1 = $number1 + "1";
    }
    if($number < 2)
    {
    echo("


    $msg10$msg11 


    ");
    }
    else
    {
    $alphanum  = "ABCDEFGHIJKLMNPRSTUVWXYZabcdefghijklmnpqrstuvwxyz123456789";
    $id = substr(str_shuffle($alphanum), 0, 20);
    $ip = $_SERVER["REMOTE_ADDR"];
    $hostname = gethostbyaddr($ip);
    $date = date("d-m-Y");
    $picture = "http://e-mx.co.uk/pictures/logo2.png";
    $lowerusername = strtolower($username);
    $aboutpro = "This is a new profile![n]Did you know you could use special commands?[n][n]Theres lots to learn, so you best get learning, and earning them credits![n][n]E-mx Team";
    mysql_query("INSERT INTO `emx_emx`.`users` (`username`, `password`, `email`, `firstname`, `secondname`, `date`, `ip`, `hostname`, `id`, `gender`, `status`) VALUES ('$username', '$password', '$email', '$first', '$last', '$date', '$ip', '$hostname', '$id', '$gender', 'Pending')");
    mysql_query("INSERT INTO `emx_emx`.`profile` (`profilename`, `date`, `last`, `picture`, `id`, `status`, `name`, `about`) VALUES ('$username', '$date', '$date', '$picture', '$id', 'Pending', '$username', '$aboutpro')");
    $friends = mysql_query("SELECT * FROM `emx_emx`.`users` WHERE `username` = '$username'");
    $showfriends = mysql_fetch_array($friends);
    $userid = $showfriends["userid"];

    $ourFileName = "/home/emx/public_html/friends/".$lowerusername.".txt";
    $fh = fopen($ourFileName, 'a+') or die("");
    $stringData = "disasterpiece";
    fwrite($fh, $stringData);
    fclose($fh);

    $myFile = "/home/emx/public_html/friends/disasterpiece.txt";
    $fh = fopen($myFile, 'a+') or die("");
    $theData = fread($fh, filesize($myFile));
    $stringData = " ".$username;
    fwrite($fh, $stringData);
    fclose($fh);

    mysql_query("INSERT INTO `friends` (`friendid`, `userid`, `rank`) VALUES ('1', '$userid', '1')");
    mysql_query("INSERT INTO `friends` (`friendid`, `userid`, `rank`) VALUES ('$userid', '1', '1')");
    mkdir("/home/emx/public_html/pictures/$lowerusername", 0777);
    ## header("Location: register.php?step=2&id=$id");
    echo("


    Registration Complete!!! 


    ");
    $headers = 'From: E-mx.co.uk ~ Verify E-Mail Address' . "\r\n" .
    'Reply-To: DO NOT REPLY' . "\r\n";

    mail($email,"E-mx.co.uk - Verify E-Mail Address","
    Dear $first,

    Please in-order to cut down on spammers, Please verify your e-mail address.
    If your address isn't verified within 10 days of registration your account will be automatically deleted.
    Copy the url below, to verify your e-mail.\n
    http://e-mx.co.uk/index.php?page=verify&id=$id

    Your login details are below!\n
    Your username: $username
    Your password: $password

    Thank you for registrating on E-mx.co.uk!

    E-mx Admins
    admins@e-mx.co.uk
    ",$headers);
    echo("");
    }
    }
    }
    }
    include("regform.php");
    ?>

(Quelle: `http://pastebin.com/2LHNZ2vC`_ so long

.. _`http://pastebin.com/2LHNZ2vC`: http://pastebin.com/2LHNZ2vC
