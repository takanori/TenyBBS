use strict;
use warnings;
use utf8;
use t::Util;
use Plack::Test;
use Plack::Util;
use Test::More;
use Time::Piece;

use Test::Harness;

use Log::Minimal;

plan skip_all => 'not yet';

# TODOブロックが機能しない
# TODO: {

#     my $teny = TenyBBS->new;
#     my $db   = $teny->db;

#     my @res = $db->search('threads');
#     is @res, 4;

#     # TODO CRUD test
# }

done_testing;
