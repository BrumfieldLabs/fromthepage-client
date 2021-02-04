require 'json'
require 'pry'

date=Time.now.strftime("%Y%m%d")
key=ARGV[0]
user=ARGV[1]
download_path=ARGV[2]
if ARGV.size < 3
  puts "USAGE:  ruby full_export.rb KEY SLUG OUTPUT_DIRECTORY"
  exit
end

response = `curl -s -H 'Authorization: Token token=#{key}' 'https://fromthepage.com/iiif/collections/#{user}'`
collections = JSON.parse(response)
collections["collections"].each do |collection_block|
  collection = collection_block["@id"]
  unless collection.include? "set"
    puts "attempting #{collection}"
    slug=collection.split('/').last
    raw_response = `curl -s -H 'Authorization: Token token=#{key}' -X POST "https://fromthepage.com/api/v1/bulk_export/#{slug}?plaintext_verbatim_page=true&plaintext_verbatim_work=true"`
    response = JSON.parse(raw_response)
    status_uri=response["status_uri"]
    download_uri=response["download_uri"]
    100.times.each do
      sleep 10
      status_response= `curl -s -H 'Authorization: Token token=#{key}' '#{status_uri}'`
      status = JSON.parse(status_response)["status"]
      if status == "finished"
        filename = File.join(download_path, "#{date}-#{slug}.zip")
        `curl -s -H 'Authorization: Token token=#{key}' '#{download_uri}' --output '#{filename}'`
        puts "downloaded #{filename}"
        break
      end
    end
   end
end
