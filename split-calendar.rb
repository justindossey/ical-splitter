require 'stringio'
require 'icalendar'

# split a large calendar file into multiple chunks. Provide input file (ics) as
# parameter. Output will be written as files "mycalendar-N.ics"
LIMIT_SIZE = 1024 * 512 # 512 kilobytes
INPUT_FILE = ARGV[0].freeze
filename_stub = File.basename(INPUT_FILE, ".ics")
File.open(ARGV[0]) do |cal_file|
  warn "Reading #{ARGV[0].inspect}"
  cals = Icalendar::Calendar.parse(cal_file)
  cal = cals.first
  n = 1
  cur = 0
  warn "Read #{cal.events.length} events. Splitting..."
  
  loop do
    break if cur == cal.events.length
    new_cal = Icalendar::Calendar.new
    cur_size = new_cal.to_ical.size
    new_fn = "#{filename_stub}-#{n}.ics"
    cal.events[cur..-1].each_with_index do |event, idx|
      if event.to_ical.size + cur_size < LIMIT_SIZE
        new_cal.add_event(event)
        cur += 1
        cur_size += event.to_ical.size
      else
        break
      end
    end
    warn "Writing #{new_fn}"
    File.open(new_fn, "w") {|f| f.write new_cal.to_ical }
    n += 1
  end
end
