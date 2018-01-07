<?php
	$servername = "db.ist.utl.pt";
	$username = "ist178349";
	$password = "=luispedro9=";
	$dbname = "ist178349";
	$regname = $_GET['regname'];

	try {
			$db = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
			
			$db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
			
			$db->beginTransaction();
								
			foreach($db->query("select userid from login where contador_login=(select max(contador_login) from login);") as $row) {
				$userid = $row['userid']; 
			}
								
			foreach($db->query("select typecnt from tipo_registo where nome='$regname' and userid='$userid';") as $row) {
				$typecounter = $row['typecnt']; 
			}
												
			$stmt = $db->prepare("update tipo_registo set ativo=0 where nome = ? and userid = ?;");
			$stmt->execute(array($regname, $userid));
								
			$stmt = $db->prepare("update registo set ativo=0 where typecounter = ? and userid = ?;");
			$stmt->execute(array($typecounter, $userid));
			
			$db->commit();
				
			echo 'Feito';
		}
			
	catch(PDOException $e){
		$db->rollBack();
		echo $sql . "<br>" . $e->getMessage();
	}
	$db = null;
?>
