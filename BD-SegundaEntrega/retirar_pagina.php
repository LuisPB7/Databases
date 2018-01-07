<?php
		
	$servername = "db.ist.utl.pt";
	$username = "ist178349";
	$password = "=luispedro9=";
	$dbname = "ist178349";
	$pagename = $_GET['pagename'];

	try {
			$db = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
			
			$db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
			
			$db->beginTransaction();
								
			foreach($db->query("select userid from login where contador_login=(select max(contador_login) from login);") as $row) {
				$userid = $row['userid']; 
			}
				
			foreach($db->query("select max(pagecounter) from pagina;") as $row) {
				$pagecounter = $row['max(pagecounter)'] + 1; 
			}
				
				
			$stmt = $db->prepare("update pagina set ativa=0 where nome= ? and userid=?;");
			$stmt->execute(array($pagename, $userid));
			
			$db->commit();
				
			echo 'Feito';
		}
			
	catch(PDOException $e){
		$db->rollBack();
		echo $sql . "<br>" . $e->getMessage();
	}
	$db = null;
?>
