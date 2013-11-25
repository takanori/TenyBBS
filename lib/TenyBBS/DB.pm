package TenyBBS::DB;
use strict;
use warnings;
use utf8;
use Encode;
use parent qw(Teng);
use DateTime;

__PACKAGE__->load_plugin('Count');
__PACKAGE__->load_plugin('Replace');
__PACKAGE__->load_plugin('Pager');

sub show_all {
    my ($self) = @_;
    my @entries = $self->search(
    'threads',
    {},
    { order_by => {'id' => 'DESC'} }
	);
	return @entries;
}

sub select_all {
    my ($self) = @_;
    # my @thread_entries = $self->search_by_sql('select * from threads');
    my @thread_entries = $self->search_by_sql(
    'select 
    threads.id as thread_id,
    threads.title as thread_title,
    threads.content as thread_content,
    threads.updated_at as thread_update_at,
    entries.id as entry_id,
    entries.author_name,
    entries.content as entry_content,
    entries.updated_at as entry_updated_at 
    from threads left join entries 
    on entries.thread_id = threads.id;'
    );
    return @thread_entries;
}

sub fetch_threads {
    my ($self) = @_;
    my @thread_list = $self->search_by_sql(
    'select * from threads order by updated_at desc;'
    );
    #return @thread_list;
}


sub fetch_entries {
    my ($self) = @_;
    my @entry_list = $self->search_by_sql(
    'select * from entries order by updated_at;'
    );
    return @entry_list;
}


# sub latest_text {
#     my ($self) = @_;
#     # my $row = $self->do(q{select * from bbs where id = 1});
#     my ($row) = $self->search(
#         'threadid',
#         {},
#         { order_by => {'id' => 'DESC'} }
# 	);
# 	# return $row;
#     return $row->get_column('text') if ($row);
# }

sub create_thread {
    my ( $self, $title, $content, $author_name ) = @_;
    $self->insert( 'threads',
    { author_name => $author_name,
        title => $title, 
        content => $content,
        created_at => $self->current_time,
        updated_at => $self->current_time,
    } );
} 1;

sub current_time {
    my ($self) = @_;
    return DateTime->now( time_zone => 'Asia/Tokyo' );
}

