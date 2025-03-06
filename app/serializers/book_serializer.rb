class BookSerializer < ApplicationSerializer
  attributes :id, :title, :series, :serno, :libid, :size, :filename,
             :del, :ext, :published_at, :insno, :folder_id, :language_id, :created_at
end
