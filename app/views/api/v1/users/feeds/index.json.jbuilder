json.current_page @feed_entries.current_page
json.total_pages @feed_entries.total_pages
json.next_page @feed_entries.next_page
json.page_size @feed_entries.size
json.total_count @feed_entries.total_count

json.entries do
  json.array! @feed_entries, partial: 'info', as: :entry
end
