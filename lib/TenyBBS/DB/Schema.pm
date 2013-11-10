package TenyBBS::DB::Schema;
use 5.012;
use strict;
use warnings;
use utf8;

use Teng::Schema::Declare;
use Time::Piece;

base_row_class 'TenyBBS::DB::Row';

my $time_inflate = sub {
    Time::Piece->new(shift);
};

my $time_deflate = sub {
    shift->epoch;
};

table {
    name 'thread';
    pk 'id';
    columns qw(id title created_at);
    inflate qr/.+_at/ => $time_inflate;
    deflate qr/.+_at/ => $time_deflate;
};

1;
