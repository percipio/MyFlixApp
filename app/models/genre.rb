class Genre < ApplicationRecord
    before_save :titleize
    before_save :set_slug

    has_many :characterizations, dependent: :destroy
    has_many :movies, through: :characterizations

    validates :name, uniqueness: { case_sensitive: false }

    def to_param
      slug
    end

    private

        def titleize
            self.name = name.titleize
        end

        def set_slug
            self.slug = name.parameterize
        end

end
