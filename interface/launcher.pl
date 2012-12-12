#!/usr/bin/env perl
use utf8;
use DBI;
use Encode;
use strict;

my $tmpID; #for ID

#Database connect
my $dbh = DBI->connect('DBI:mysql:collocs:localhost', 'colloc', 'H4eSaa1L') or die $DBI::errstr;
#$dbh->do("SET NAMES utf8");

#ask
my $str = $dbh->prepare("SELECT * FROM journal WHERE mode=0") or die $dbh->errstr;
$str->execute();

#my $str = $dbh->selectrow-hashref("SELECT * FROM journal WHERE mode=0")or die $dbh->errstr;
print $str."\n";
while (my $val = $str->fetchrow_hashref){
	
	print "ID:" .$val->{'numb'}."\n";
	print "launch_path: ".$val->{'launch'}."\n";
	print "res_path: ".$val->{'path'}."\n";
	print "mode: ".$val->{'mode'}."\n";
		
	$tmpID = $val->{'numb'};
	#print $tmpID;
	my $launch = $val->{'launch'};
	my $res_path = $val->{'path'};
	my $upd = $dbh->prepare("UPDATE journal SET mode=1 WHERE numb=?") or die $dbh->errstr;
	$upd->execute($tmpID);
	system("$launch > $res_path")==0;
	if ($?==-1){
		print "failed to execute: $!\n";
	}
	elsif ($? & 127){
		printf "child died with signal %d, %s coredump\n",
		($? & 127), ($? & 128) ? 'with':'without';
	}
	else{
		printf "child exited wih value %d\n", $? >> 8;
	}
	#нужно проверить результат работы программы и записать, что скрипт отработал => можно забирать результат	
	if (-e $res_path){
		my $upd2 = $dbh->prepare("UPDATE journal SET mode=2 WHERE numb=?") or die $dbh->errstr;
		$upd2->execute($tmpID);
	}
}

#$dbh->commit(); ??
