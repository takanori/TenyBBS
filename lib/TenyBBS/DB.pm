package TenyBBS::DB;
use strict;
use warnings;
use utf8;
use parent qw(Teng);

use DateTime;
use Data::GUID::URLSafe;
use YAML;
use Log::Minimal;

__PACKAGE__->load_plugin('Count');
__PACKAGE__->load_plugin('Replace');
__PACKAGE__->load_plugin('Pager');

# Threads ===========================================================

sub all_threads {
    my ($self) = @_;
    my $itr = $self->search(
        'threads',
        { },
        { order_by => {'updated_at' => 'DESC'} },
    );

    my @rows;
    while (my $row = $itr->next) {
        push(@rows, $row->get_columns);
    }
    return \@rows;
}

sub insert_thread {
    my ( $self, $args ) = @_;
    my $row = $self->insert(
        'threads',
        {   title      => $args->{title},
            content    => $args->{content},
            created_at => $self->current_time,
            updated_at => $self->current_time,
        }
    );
    return $row->get_columns;
}

sub update_thread {
    my ( $self, $args ) = @_;
    my $updated_count = $self->update(
        'threads',
        {   title      => $args->{title},
            content    => $args->{content},
            updated_at => $self->current_time,
        },
        { id => $args->{id} },
    );
    infof(Dump($args));

    my $row = $self->single( 'threads', { id => $args->{id}, } );
    return $row->get_columns;
}

sub delete_thread {
    my ($self, $args) = @_;
    my $deleted_count = $self->delete(
        'threads',
        { id => $args->{id} },
    );
    return $deleted_count;
}

sub update_thread_updated_at {
    my ($self, $args) = @_;
     $self->update(
        'threads',
        { updated_at => $self->current_time },
        { id => $args->{id} },
    );
}

# Entries ===========================================================

sub all_entries {
    my ( $self, $args ) = @_;
    my $itr = $self->search(
        'entries',
        { thread_id       => $args->{thread_id} },
        { order_by => { 'created_at' => 'DESC' } },
    );

    my @rows;
    while ( my $row = $itr->next ) {
        push( @rows, $row->get_columns );
    }
    return \@rows;
}

sub insert_entry {
    my ( $self, $args ) = @_;
    $self->update_thread_updated_at({id => $args->{id}});
    my $row = $self->insert(
        'entries',
        {   id          => Data::GUID->new->as_base64_urlsafe,
            thread_id   => $args->{thread_id},
            author_name => $args->{author_name},
            content     => $args->{content},
            created_at  => $self->current_time,
            updated_at  => $self->current_time,
        }
    );
    return $row->get_columns;
}

sub update_entry {
    my ( $self, $args ) = @_;
    $self->update_thread_updated_at({id => $args->{id}});
    my $updated_count = $self->update(
        'entries',
        {   author_name => $args->{author_name},
            content     => $args->{contnet},
            updated_at  => $self->current_time,
        },
        { id => $args->{id}, },
    );
    my $row = $self->single( 'threads', { id => $args->{id}, } );
    return $row->get_columns;
}

sub delete_entry {
    my ($self, $args) = @_;
    my $deleted_count = $self->delete(
        'entries',
        { id => $args->{id} },
    );
    return $deleted_count;
}

# Utility ===========================================================

sub current_time {
    my ($self) = @_;
    return DateTime->now( time_zone => 'Asia/Tokyo' );
}

1;
