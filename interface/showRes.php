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
				<li><a href="download.html" title="Download">Готовые файлы</a></li>
		    </ul>
			<h1>Collocations</h1>
	</div>
        <div id="container"> 		
<?php

	if ($_GET['file']!=null){
		//show existing file on the page
		if($_GET['res'==""]{echo "Файл уже обработан: <a href=".$_GET['file'].">".$_GET['file']."</a><br>";} 
	
		 else {echo "Файл уже обработан: <a href=".$_GET['file'].">".$_GET['res']."</a><br>";} 
		 echo "Top 50: <br>";
		 $handle = @fopen($_GET['file'], "r");
		 if ($handle){
		     ini_set("auto_detect_line_endings", true); //instead of length parameter 
		 	while(($buffer = fgets($handle)) <= 50){
                		echo $buffer."<br>";
			 } 
		  }
			if (!feof($handle)){
			  echo "Error: unexpected fgets() fail\n";
			}
			fclose($handle);	
		}
	
		if($_GET['name']!=null){
			echo $_GET['name'];
		}


	?>
		</div>
		<div id="bottom">
			Все <a href="http://code.google.com/p/collocations/source/browse/#svn%2Ftrunk" title="Программы, SVN">программы</a> и <a href="http://code.google.com/p/collocations/wiki/Documentation" title="Wiki документация">документация к ним</a> находятся в открытом доступе.
			<p>&copy;Крылова Ирина</p>
		</div>	
	</div>	
</body>
</html>
