module MovieHelper

    def main_image(movie)
        if movie.main_image.attached?
            image_tag movie.main_image.variant(resize_to_limit: [150, nil])
        else
            image_tag "placeholder.png"
        end
    end
    
    def total_gross(movie)
        if movie.flop?
            "Flop"
        else
            number_to_currency(movie.total_gross, precision: 0)
        end
    end

    def year_of(movie)
        movie.released_on.year
    end

    def nav_link_to(text, url)
        if current_page?(url)
            link_to(text, url, class: "active")
        else
            link_to(text, url)
        end
    end
end
