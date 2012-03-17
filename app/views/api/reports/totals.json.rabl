object @report
attributes :id,
  :year_distance,
  :year_duration,
  :year_elevation_gain,
  :year_segment_count,
  :month_distance,
  :month_duration,
  :month_elevation_gain,
  :month_segment_count,
  :week_distance,
  :week_duration,
  :week_elevation_gain,
  :week_segment_count

node(:href) { |report| api_reports_totals_url }
node(:week_start_time) { |report| Date.commercial(report.year, report.week).beginning_of_day.to_i }
node(:week_end_time) { |report| Date.commercial(report.year, report.week).end_of_week.end_of_day.to_i }
node(:created_at) { |report| report.created_at.to_i }
node(:updated_at) { |report| report.updated_at.to_i }