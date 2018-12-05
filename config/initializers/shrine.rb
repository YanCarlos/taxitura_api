require 'shrine'
require 'shrine/storage/file_system'
require 'shrine/storage/s3'

s3_options = {
  bucket: ENV.fetch('AMAZON_S3_BUCKET'),
  access_key_id: ENV.fetch('AMAZON_S3_ACCESS_KEY'),
  secret_access_key: ENV.fetch('AMAZON_S3_ACCESS_SECRET_KEY'),
  region: ENV.fetch('AMAZON_S3_REGION')
}

Shrine.storages = {
  cache: Shrine::Storage::S3.new( prefix: 'cache', upload_options: {acl: 'public-read'}, **s3_options),
  store: Shrine::Storage::S3.new( prefix: 'store', upload_options: {acl: 'public-read'}, **s3_options),
}

Shrine.plugin :presign_endpoint, presign_options: { method: :put }

Shrine.plugin :activerecord
Shrine.plugin :backgrounding
Shrine.plugin :determine_mime_type
Shrine.plugin :cached_attachment_data
Shrine.plugin :restore_cached_data





