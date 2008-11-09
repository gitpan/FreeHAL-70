#$Id: Wortschatz.pm 1057 2008-02-28 17:54:09Z schroeer $

package Lingua::DE::Wortschatz::Result;
use strict;

our $VERSION = "1.24";

sub new {
    my ($proto,$service,@names) = @_;
    my $class = ref($proto) || $proto;
    return bless { service => $service, names => \@names, data => [] }, $class;
}

sub add {
    my ($self,@values)=@_;
    push(@{$self->{data}},\@values);
}

sub dump {
    my $self=shift;
    print "Service ",$self->service,"\n\n";
    my @lengths;
    for my $row ($self->data,$self->{names}) {
        for (0..$#$row) {
            my $l=length($row->[$_]);
            $lengths[$_]=$l unless ($lengths[$_] && ($lengths[$_] > $l));
        }
    }
    my $form=(join " ",map {'%-'.$_.'s'} @lengths)."\n";
    printf $form,$self->names;
    printf $form, map {"-"x$_} @lengths;
    printf $form,@$_ for ($self->data);
}

sub service { shift->{service} }
    
sub names { @{shift->{names}} }
    
sub data { @{shift->{data}} }
    
sub hashrefs {
    my $self=shift;
    my @res=();
    for (@{$self->{data}}) {
        my %hash;
        @hash{@{$self->{names}}}=@$_;
        push(@res,\%hash);
    }
    return @res;
}

