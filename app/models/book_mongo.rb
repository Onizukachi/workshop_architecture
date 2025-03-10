class BookMongo
  include Mongoid::Document
  include Mongoid::Timestamps
  include Ransackable

  field :title, type: String
  field :libid, type: String
  field :size, type: Integer
  field :filename, type: String
  field :ext, type: String
  field :id_value, type: String
  field :insno, type: String
  field :published_at, type: DateTime

  has_and_belongs_to_many :authors
  has_and_belongs_to_many :genres
  has_and_belongs_to_many :keywords

  validates :title, :libid, :size, :filename, presence: true

  PUBLIC_FIELDS = %w[id del ext filename folder_id id_value insno
                     language_id libid series serno size title
                     published_at updated_at created_at]
  RANSACK_ASSOCIATIONS = %w[authors folder genres keywords language]
end
