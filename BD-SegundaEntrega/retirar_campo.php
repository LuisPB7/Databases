/*
*
* Instituicao: Instituto Superior Tecnico
* Cadeira: Bases de Dados 15/16
* Autores: Antonio Tavares (78122), Luis Borges (78349), Paulo Ritto (78929)
*
*/

<?php
	$servername = "db.ist.utl.pt";
	$username = "ist178349";
	$password = "=luispedro9=";
	$dbname = "ist178349";
	$regtype = $_GET['regtype'];
	$camponame = $_GET['camponame'];

	try {
			$db = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
				
			$db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
			
			$db->beginTransaction();
								
			foreach($db->query("select userid from login where contador_login=(select max(contador_login) from login);") as $row) {
				$userid = $row['userid']; 
			}
											
			foreach($db->query("select C.typecnt from campo C, tipo_registo TP where TP.ativo=1 and TP.nome='$regtype' and TP.userid=C.userid;") as $row) { 
				$typecounter = $row['typecnt']; 
			}
												
			$stmt = $db->prepare("update campo set ativo=0 where typecnt = ? and nome= ? and userid = ?;");
			$stmt->execute(array($typecounter, $camponame, $userid));
			
			$db->commit();
				
			echo 'Feito!';
		}
			
	catch(PDOException $e){
		$db->rollBack();
		echo $sql . "<br>" . $e->getMessage();
	}
	$db = null;
?>
