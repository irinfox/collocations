#!/usr/bin/env perl
use utf8;
use DBI;
use Encode;
use strict;
use Cwd 'abs_path';
use File::Basename;

my $tmpID; #for ID
my $dir = dirname(abs_path($0))."/";
print $dir;

#Database connect
my $dbh = DBI->connect('DBI:mysql:collocs:localhost', 'colloc', 'H4eSaa1L') or die $DBI::errstr;
#$dbh->do("SET NAMES utf8");

#ask
my $str = $dbh->prepare("SELECT * FROM journal WHERE mode=0");
$str->execute() or die $dbh->errstr;
#my $str = $dbh->selectrow-hashref("SELECT * FROM journal WHERE mode=0")or die $dbh->errstr;
#print $str."\n";
while (my $val = $str->fetchrow_hashref){
	
	#print "ID:" .$val->{'numb'}."\n";
	#print "launch_path: ".$val->{'launch'}."\n";
	#print "res_path: ".$val->{'path'}."\n";
	#print "mode: ".$val->{'mode'}."\n";
		
	$tmpID = $val->{'numb'};
	#print $tmpID;
	my $launch = $val->{'launch'};
	my $res_path = $val->{'path'};
        my $upd = $dbh->prepare("UPDATE journal SET mode=1 WHERE numb=?");
	$upd->execute($tmpID) or die $dbh->errstr;
}
	
my $str1 = $dbh->prepare("SELECT * FROM journal WHERE mode=1");
$str1->execute() or die $dbh->errstr;
	
while (my $val1 = $str1->fetchrow_hashref){
      
	my $launch1 = $val1->{'launch'};
	my $res_path1 = $val1->{'path'};
        $launch1 =~ s/(\.\.)/$dir$1/g;
       #не печатает эту строчку 
        print "launch: ".$launch1."\n";  
	
        #my $add = "/var/www/html/colloc/inetrface/"; #for correct work of crontab
	my $abs_path = $dir.$res_path1;
        
        print "abs: ".$abs_path."\n";
	
        $tmpID = $val1->{'numb'};
      my $status =  system("$launch1 > $abs_path");

	if ($status){
	  if ($?==-1){
		print "failed to execute: $!\n";
	  } 
	  elsif ($? & 127){
		printf "child died with signal %d, %s coredump\n",
		($? & 127), ($? & 128) ? 'with':'without';
	  }  
	  else{
		printf "child exited with value %d\n", $? >> 8;
	   }
	}
	#нужно проверить результат работы программы и записать, что скрипт отработал => можно забирать результат	
	if (-e $abs_path){
            my $upd2 = $dbh->prepare("UPDATE journal SET mode=2 WHERE numb=?");
            $upd2->execute($tmpID) or die $dbh->errstr;
	}
}

#$dbh->commit(); ??
