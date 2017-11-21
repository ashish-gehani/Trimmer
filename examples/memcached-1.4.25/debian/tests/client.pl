#!/usr/bin/perl -w
# test memcached daemon for set / get / flush_all
# inspired from t/lib/MemcachedTest.pm

use strict;
use IO::Socket::INET;

my $host = '127.0.0.1';
my $port = '11211';
my $test_key = "mykey";
my $test_value = "mycustomvalue";
my $test_value_length = length($test_value);
my $data;

sub new_conn {
	my $conn = IO::Socket::INET->new(PeerAddr => "$host:$port",
									 Proto => 'tcp'
				) or die "Fail to connect to memcached on $host:$port: $!";
	return $conn;
}

#################
# stats
my $sock = new_conn();
print $sock "stats\r\n";
$sock->recv($data, 1024);

unless ($data =~ /threads/) {
	print "Error when getting stats $data\n";
	exit 1;
}
$sock->close();
print "[*] stats OK\n";


#################
# set a key / value pair
print "[*] Store key and value pair\n";
$sock = new_conn();
print $sock "set $test_key 0 60 $test_value_length\r\n$test_value\r\n";
$sock->recv($data, 1024);

if ($data !~ /STORED/) {
	print "Error storing $test_key: $data\n";
	exit 1
}
$sock->close();
print " $test_key:$test_value stored\n";


#################
# getting the value of the key
print "[*] Get $test_key value\n";
$sock = new_conn();
print $sock "gets $test_key\r\n";

my $line = scalar(<$sock>);
if ($line =~ /^VALUE/) {
	my $value = scalar(<$sock>) . scalar(<$sock>);
	if ($value !~ /$test_value/) {
		print "Error getting $test_key value: $value\n";
		exit 1;
	}

	# remove the END of body
	$value =~ s/\r\nEND\r\n//;

	print " $test_key value found: '$value'\n";
}
else {
	print "Error $test_key is missing: $line\n";
	exit 1;
}


#################
# flush all keys
print "[*] Flush all keys\n";
$sock = new_conn();
print $sock "flush_all\r\n";
$sock->recv($data, 1024);

if ($data !~ /^OK/) {
	print "Error when executing flush_all: $data\n";
	exit 1;
}


#################
# verify that our key is missing
print "[*] Verify that $test_key is missing\n";
$sock = new_conn();
print $sock "gets $test_key\r\n";

$sock->recv($data, 1024);
if ($data !~ /^END/) {
	$data =~ s/\n/ /g;
	$data =~ s/\r/ /g;
	print "Error: $test_key found: '$data'\n";
	exit 1;
}
else {
	print " $test_key is not found (OK because of previous flush)\n";
	exit 0;
}
