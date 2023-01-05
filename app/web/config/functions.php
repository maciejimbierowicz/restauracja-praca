<?php 
session_start();

function get_connection(){
  $host = getenv("DB_HOST");
  $user = getenv("DB_USER");
  $pass = getenv("DB_PASS");
  $name = 'restauracja';

  return new PDO('mysql'.':host='.$host.';dbname='.$name, $user, $pass);
};
