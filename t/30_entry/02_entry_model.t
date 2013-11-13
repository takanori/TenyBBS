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

my @res = $db->search('entries');
is @res, 3;

# TODO CRUD test

done_testing;
