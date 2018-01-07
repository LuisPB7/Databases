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
				
			foreach($db->query("select max(campocnt) from campo;") as $row) { 
				$campocounter = $row['max(campocnt)'] + 1; 
			}
				
			foreach($db->query("select max(S.contador_sequencia) from sequencia S, login L where L.contador_login=(select max(contador_login) from login) and S.userid=L.userid;") as $row) {
				$idseq = $row['max(S.contador_sequencia)']; 
			}
				
			$stmt = $db->prepare("INSERT INTO campo (userid, typecnt, campocnt, idseq, ativo, nome) VALUES (?, ?, ?, ?, true, ?)");
			$stmt->execute(array($userid, $typecounter, $campocounter, $idseq, $camponame));
			
			$db->commit();
				
			echo 'Feito!';
		}
			
	catch(PDOException $e){
		$db->rollBack();
		echo $sql . "<br>" . $e->getMessage();
	}
	$db = null;
?>
