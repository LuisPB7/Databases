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
	$pagename = $_GET['pagename'];

	try {
			$db = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
				
			$db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
			
			$db->beginTransaction();
								
			foreach($db->query("select userid from login where contador_login=(select max(contador_login) from login);") as $row) {
				$userid = $row['userid']; 
			}
				
			foreach($db->query("select pagecounter from pagina where nome= '$pagename';") as $row) {
				$pagecounter = $row['pagecounter']; 
			}
				
			foreach($db->query("select nome from registo R, reg_pag RP where R.regcounter=RP.regid and RP.pageid='$pagecounter';") as $row) {
				echo $row['nome'] . "<br><br>";
			}
			
			$db->commit();
								
		}
			
	catch(PDOException $e){
		$db->rollBack();
		echo $sql . "<br>" . $e->getMessage();
	}
	$db = null;
?>
