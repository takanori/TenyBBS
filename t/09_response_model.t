use strict;
use warnings;
use utf8;
use t::Util;
use Plack::Test;
use Plack::Util;
use Test::More;
use Time::Piece;

my $teny = TenyBBS->new;
my $db = $teny->db;


my @res;

@res = $db->search('response', { thread_id => 1 });
is @res, 2;

@res = $db->search('response', { thread_id => 2 });
is @res, 1;

@res = $db->search('response', { thread_id => 3 });
is @res, 3;

done_testing;
