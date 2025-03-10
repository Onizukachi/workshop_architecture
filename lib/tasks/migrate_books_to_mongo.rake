
namespace :migrate do
  desc "Перенос книг из PostgreSQL (Book) в MongoDB (BookMongo)"
  task books: :environment do
    puts "Начинаем перенос книг..."

    count = 0

    Book.find_each do |book|
      BookMongo.create!(
        title: book.title,
        libid: book.libid,
        size: book.size,
        filename: book.filename,
        ext: book.ext,
        published_at: book.published_at
      )
      count += 1
    rescue => e
      puts "Ошибка при переносе книги ID=#{book.id}: #{e.message}"
    end

    puts "Перенос завершён! Всего перенесено: #{count} книг."
  end
end
