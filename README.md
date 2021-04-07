# ical-splitter

This is a small script that uses the Ruby iCalendar gem to split a large ical
file into smaller chunks.

## Why?
I wrote this because Google Calendar doesn't like it when you try to import a
large calendar file. The limit seems to be around 1 MB, but I've seen issues
with files smaller than 1 MB as well.

## How?
Note: if you export your Google Calendar, it may give you a zip file with a pile
of ics files in it. You'll need to unzip that file before selecting the file(s)
you wish to import.

## Usage
```./split-calendar.sh bigcalendar.ics```
The shell script does a `bundle check` and `bundle install` if the iCalendar gem
isn't present. Then it invokes `ical-splitter.rb` on the file. It will then
write a series of files like `bigcalendar-1.ics`, `bigcalendar-2.ics`, etc which
should be less than or equal to 512 KB in size.  When the program completes, you
can import each of the files in succession to Google Calendar. 

## Changing the limit
To change the limit, edit `split-calendar.rb` and adjust the `LIMIT_SIZE`
constant. It's important that `LIMIT_SIZE` be large enough to hold at least one
event.

## Known Bugs
1. Occasionally, Google Calendar rejects an event with the error "insufficient
   permissions on the target calendar."  As far as I can tell, that's a bug in
   Google Calendar.

## Contributing
Open an issue and/or Fork, PR. 
