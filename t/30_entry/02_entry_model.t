use strict;
use warnings;
use utf8;
use t::Util;
use Plack::Test;
use Plack::Util;
use Test::More;
use Time::Piece;

use Test::Harness;

plan skip_all => 'not yet';

my $teny = TenyBBS->new;
my $db   = $teny->db;

my @res = $db->search('entries');
is @res, 4;

# TODO CRUD test

done_testing;
