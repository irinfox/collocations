<html>
<head>
 <title>Collocations interface</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"> 
	<meta name="Author" content="Krylova Irina"> 
	<meta name="keywords" content="collocations,MI,t-score,mutual information">
	<meta name="description" content="Collocations">
	<meta name="Generator" content="Notepad++">
	<link rel="stylesheet" href="style.css" type="text/css">
</head>

<body>
    <div id="wrap">
       <div id="header">
            <ul class="top-menu">
				<li><a href="main.html" title="Collocations main"><b>Выбор коллекции</b></a></li>
				<li><a href="download.php" title="Download">Готовые файлы</a></li>
		    </ul>
			<h1>Collocations</h1>
	</div>
        <div id="container"> 		
			<!--<form>
			код для обращения к БД и выводу файлов с mode=2-->
			<?php
				$host = "localhost";
				$login = "colloc";
				$PWD = "H4eSaa1L";
				$dbCon = mysql_connect($host,$login, $PWD);
				//проверка
				//print "код ошибки: ". mysql_error();
				//print "<br>Connected with ID: ".$dbCon."<br>"; 
                //к журналу
	            $dbName = "collocs";
	            mysql_select_DB($dbName, $dbCon);
				
			    $result = mysql_query("select * from journal where mode=2", $dbCon);
			    $result2 = mysql_query("SELECT * FROM journal WHERE mode=2", $dbCon);
				
				print "<b>Обработанные файлы, доступные для скачивания:</b><br><br>";
                
				while ($line = mysql_fetch_array($result)){
				  //$res_path = $line['path']." ";
				  //$res_path = $line[0];
				   //print $res_path."<br>";
				   
				   if ($line['name'] == ''){
                                	#print "<a href=".$line['path'].">".basename($line['path'])."</a><br>";
				      print "<a href=saveFile.php?flname=".basename($line['path'])."&flpath=".$line['path'].">".basename($line['path'])."</a><br>";  

				   }else{
				      print "<a href=saveFile.php?flname=".$line['name']."&flpath=".$line['path'].">".$line['name']."</a><br>";  
				     # header("Location:saveFile.php?flname=".$line['name']."&flpath=".$line['path']);#выводим пользовательское имя файла
				   }
				}
				
			?>
		<!--	</form>-->
		</div>
		<div id="bottom">
			Все <a href="http://code.google.com/p/collocations/source/browse/#svn%2Ftrunk" title="Программы, SVN">программы</a> и <a href="http://code.google.com/p/collocations/wiki/Documentation" title="Wiki документация">документация к ним</a> находятся в открытом доступе.
			<p>&copy;Крылова Ирина</p>
		</div>	
	</div>	
</body>
</html>
