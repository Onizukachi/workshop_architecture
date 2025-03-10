namespace :migrate do
  desc "Перенос книг из PostgreSQL (Book) в MongoDB (BookMongo)"
  task books: :environment do
    puts "Начинаем перенос книг..."
    start_time = Time.now

    total_count = 0
    batch_size = 1000

    # уменьшаем нагрузку на базу используя только необходимые поля
    scope = Book.select(:id, :title, :libid, :size, :filename, :ext, :published_at)

    scope.find_in_batches(batch_size: batch_size) do |batch|
      documents = batch.map do |book|
        {
          title: book.title,
          libid: book.libid,
          size: book.size,
          filename: book.filename,
          ext: book.ext,
          published_at: book.published_at
        }
      end

      begin
        result = BookMongo.collection.insert_many(documents, ordered: false)
        total_count += result.inserted_count
      rescue Mongo::Error::BulkWriteError => e
        puts "произошла ошибка #{e.inspect}"
      end
    end

    duration = Time.now - start_time
    puts "\nПеренос завершён за #{duration.round(2)}с"
    puts "Всего перенесено: #{total_count} записей"
  end
end
