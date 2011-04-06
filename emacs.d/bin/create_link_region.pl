#!/usr/local/bin/perl

use strict;
use warnings;
use Web::Scraper;
use URI;
binmode(STDOUT, 'utf8');

my $scraper = scraper { process 'title', 'title' => 'TEXT' };
if ($ENV{'HTTP_PROXY'}) {
    $scraper->user_agent->proxy('http', $ENV{'HTTP_PROXY'});
} elsif ($ENV{'http_proxy'}) {
    $scraper->user_agent->proxy('http', $ENV{'http_proxy'});
}

my $href;
{
    local $/;
    $href = <>;
}
my @hrefs = split(/\n/, $href);
my @tags;
for (@hrefs) {
    my $uri = URI->new($_);
    my $res = $scraper->scrape($uri);
    push @tags, '<a href="'. $_. '" target="_blank">'. $res->{title}. '</a>';
}
print join("\n", @tags);
